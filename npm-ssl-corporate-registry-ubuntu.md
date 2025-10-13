# npm + Ubuntu: solucionar errores SSL con registro corporativo (guía práctica)

Cuando trabajas en entornos corporativos, es común que el registro de paquetes (npm registry) esté detrás de un proxy o de una CA (autoridad certificadora) privada. Esto puede provocar errores SSL en npm, instalaciones extremadamente lentas o fallidas.

Este artículo explica cómo diagnosticar y solucionar el problema de forma segura, sin desactivar la verificación SSL, en una máquina Ubuntu.

Nota: todas las URLs y nombres han sido enmascarados. Sustituye `https://registry.internal.example.com/npm-proxy` por tu URL real.

---

## Cómo detectarlo rápidamente (qué ves al principio)

1. La instalación se queda “pensando” o tarda demasiado

- Al ejecutar `npm install` o `npm ci`, el progreso avanza muy lentamente o parece colgarse.

1. `npm ping` falla con un error de certificados

- Ejemplo típico:
  - `npm notice PING https://registry.internal.example.com/npm-proxy`
  - `npm error code UNABLE_TO_GET_ISSUER_CERT_LOCALLY`
  - `npm error request to https://registry.internal.example.com/npm-proxy/-/ping failed, reason: unable to get local issuer certificate`

1. `curl` al endpoint responde OK

- Una petición a metadatos devuelve 200 y tiempos razonables, lo que sugiere que la red y el DNS funcionan:
  - `curl -sk -o /dev/null -w 'HTTP %{http_code} total=%{time_total}s\n' https://registry.internal.example.com/npm-proxy/react`

Interpretación rápida:

- Si curl funciona pero npm falla con “unable to get local issuer certificate”, casi seguro es un problema de confianza de la CA en el contexto de Node/npm (no de conectividad).

---

## Síntomas típicos

- `npm ping` falla con `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`.
- `npm install` tarda mucho o falla; `curl` directo al endpoint responde pero npm reintenta por errores SSL.
- Peticiones de metadatos al registry responden, pero npm no confía en la cadena de certificados.

## Causa raíz

Node/npm no confía en la CA corporativa utilizada por el endpoint del registry. En Ubuntu, el bundle del sistema suele estar en `/etc/ssl/certs/ca-certificates.crt`, pero Node puede no estar usando dicha cadena si no se le indica.

## Solución segura y persistente

1. Exportar la CA del sistema para Node

Añade a tu `~/.profile` (o shell de login):

```bash
# >>> corp-npm-ca >>>
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
# <<< corp-npm-ca <<<
```

Vuelve a cargar el entorno: `source ~/.profile`.

1. Configurar npm con registry y CA

En `~/.npmrc` (ajusta la URL del registry):

```ini
registry = https://registry.internal.example.com/npm-proxy
cafile = /etc/ssl/certs/ca-certificates.crt
strict-ssl = true
```

1. Verificar conectividad

- `npm ping --registry=https://registry.internal.example.com/npm-proxy`
- `npm view react version --registry=https://registry.internal.example.com/npm-proxy --silent`
- En tu proyecto: `npm ci --no-audit --no-fund` o `npm install --no-audit --no-fund`

Si todo está bien, deberías obtener un `PONG` y las instalaciones completarán con normalidad.

## Diagnóstico rápido si vuelve a ocurrir

- Ver el registry efectivo:
  - `npm config get registry`
- Revisar variables de proxy:
  - `env | egrep -i '^(http|https)_proxy|no_proxy'`
- Comprobar DNS del registry:
  - `getent hosts registry.internal.example.com`
- Medir latencia HTTP a metadatos:
  - `curl -sk -w 'HTTP %{http_code} connect=%{time_connect}s, ttfb=%{time_starttransfer}s, total=%{time_total}s\n' -o /dev/null https://registry.internal.example.com/npm-proxy/react`
- Ping de npm:
  - `npm ping --registry=https://registry.internal.example.com/npm-proxy`

Determinando la causa exacta (paso a paso):

- Si `npm ping` falla con UNABLE_TO_GET_ISSUER_CERT_LOCALLY pero `curl` funciona:
  - Verifica `npm config get strict-ssl` (debe ser true por seguridad) y `npm config get cafile` (si no está configurado, npm podría no usar el bundle de sistema).
  - Exporta temporalmente `NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt` y reintenta `npm ping`. Si ahora funciona, confirma que el problema era la confianza de la CA.
  - Opcional: inspecciona la cadena con `openssl s_client -showcerts -servername registry.internal.example.com -connect registry.internal.example.com:443 < /dev/null | sed -n '1,50p'` para ver emisores.

## Workaround temporal (no recomendado como solución final)

Si estás bloqueado y necesitas desbloquearte para diagnosticar, puedes desactivar temporalmente la verificación SSL:

```bash
npm config set strict-ssl false
# ...pruebas rápidas...
npm config set strict-ssl true
```

Es preferible instalar la CA correctamente (NODE_EXTRA_CA_CERTS y `cafile`) en lugar de dejar `strict-ssl=false`.

## Script opcional (conveniencia)

Puedes guardar este script y ejecutarlo para aplicar la configuración de forma idempotente (ajusta la URL del registry):

```bash
#!/usr/bin/env bash
set -euo pipefail
REG="https://registry.internal.example.com/npm-proxy"
CAF="/etc/ssl/certs/ca-certificates.crt"
PROF="$HOME/.profile"
NPMRC="$HOME/.npmrc"

echo "[1/5] Update $PROF with NODE_EXTRA_CA_CERTS (idempotent)"
touch "$PROF"
awk 'BEGIN{p=1} /^# >>> corp-npm-ca >>>$/ {p=0} { if(p) print } /^# <<< corp-npm-ca <<</ {p=1}' "$PROF" > "$PROF.tmp" || true
mv "$PROF.tmp" "$PROF" 2>/dev/null || true
cat <<'EOF' >> "$PROF"
# >>> corp-npm-ca >>>
export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt
# <<< corp-npm-ca <<<
EOF

echo "[2/5] Update $NPMRC with registry/cafile/strict-ssl (idempotent)"
touch "$NPMRC"
awk 'BEGIN{IGNORECASE=1} !/^[ \t]*(registry|cafile|strict-ssl)[ \t]*=/' "$NPMRC" > "$NPMRC.tmp" || true
mv "$NPMRC.tmp" "$NPMRC"
{
  echo "registry = $REG"
  echo "cafile = $CAF"
  echo "strict-ssl = true"
} >> "$NPMRC"

echo "[3/5] Source $PROF for current session"
. "$PROF" || true

echo "[4/5] Verify npm configuration"
echo "NODE_EXTRA_CA_CERTS=${NODE_EXTRA_CA_CERTS-}"
npm config get registry
npm config get cafile
npm config get strict-ssl

echo "[5/5] Connectivity checks"
npm ping --registry="$REG"
npm view react version --registry="$REG" --silent || true

exit 0
```

## Notas finales

- Si tu organización entrega un PEM específico (por ejemplo `CORP-ROOT-*.pem`), úsalo en lugar del bundle del sistema cambiando tanto `NODE_EXTRA_CA_CERTS` como `cafile` a la ruta de ese PEM.
- En proyectos que usan `yarn`, existen flags equivalentes: `yarn config set registry` y `yarn config set cafile`.
- Evita exponer tokens o URLs internas en repos públicos: centraliza credenciales en variables de entorno o gestores de secretos.

---

## Checklist rápida (TL;DR)

Detección

- npm install/ci tarda demasiado o parece colgarse.
- `npm ping --registry=https://registry.internal.example.com/npm-proxy` falla con `UNABLE_TO_GET_ISSUER_CERT_LOCALLY`.
- `curl -sk` al endpoint devuelve 200 en tiempos razonables.

Diagnóstico

- `npm config get registry` confirma el registry esperado.
- Revisar `HTTP(S)_PROXY`/`NO_PROXY` en el entorno.
- DNS correcto: `getent hosts registry.internal.example.com`.
- Latencia metadatos: `curl -sk -w 'HTTP %{http_code} total=%{time_total}s\n' -o /dev/null https://registry.internal.example.com/npm-proxy/react`.

Solución

- En `~/.profile`:
  - `export NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt`
- En `~/.npmrc`:
  - `registry = https://registry.internal.example.com/npm-proxy`
  - `cafile = /etc/ssl/certs/ca-certificates.crt`
  - `strict-ssl = true`

Verificación

- `source ~/.profile` (o abre una nueva sesión).
- `npm ping --registry=https://registry.internal.example.com/npm-proxy` → PONG.
- `npm view react version --registry=https://registry.internal.example.com/npm-proxy --silent`.
- En el proyecto: `npm ci --no-audit --no-fund`.
