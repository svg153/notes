# Associate Cloud Engineer

## Info

cloud digital leader en 3 dias

associate cloud eng
Guia de examen hay preguntas de ejemplo para saber

- Puedes pedir extension si no es tu idioma nativo
- la grande son pregntas mas Grandes

<https://www.nowystyl.com/en/xio20/desks/>
<https://sp.humanscale.com/products/product-buy.cfm?group=m2.1>

Solo examen de prueba. Examtopics

## XXXXX

tener organizado
tener carpetas de proectos

arbol, organizacion, carpetas, proyectos, recuros

IAM, politica de iam, documento quien puede hacer que sobre qeu recuros y de manera opcional bajo que condiciones
Ej: carlos, edita, instancias de vm, los dias de diario
los permisos por norma, buena practica en grupos

service accoun pensada para sistemas o service
rotan y de corta duración
nunca de larga duración, por seguridad

Tiene una cuenta root cuando se crea la cuenta, pero es recomendable

Varios nieveles de acceso basada en carpetas, it, data, etc... y luego entorno. PAra grandes bancos o demas, env, div, entornos

para Poc o MVP, carpeta concreta donde solo se le da permiso a lo concreto a ese pr0yecto y se le pone budget. La otra opción es en ese proyectos tienes todos los permisos pero limitado en budget

Roles predefinidos, si no crear uno nuevo, no puede editar los roles predefinidos, si puedes crear uno nuevo partiendo e uno predefinido y luego editas el nuevo.
Puedes darle mas de un role a un usuario.

LAs politicas de IAM se pueden aplicar a nivel de proyecto carperta y aunque tu tenga, si se lo niegas a nivel de proyecto, acabas quitando el permiso
Se pueden negar políticas de IAM

### Virtual Private Cloud (VPC)

40 regiones
1 global VPC

- En AWS las VPC es regional

El trafico entre regiones aun siendo una VPC global cuesta dinero, como pasa con AWS.

Tu creas una VPC y en esa puedes poner dentro las regiones. En AWS tiene que crear una VPC por cada región y una subred por cada zona de disponibilidad y si quieres conectarlas tienes que hacer peering entre ellas.

las subredes son regionales, no globales. Con una

La VPC va asociada a un proyecto pero tu puedes tener multiples VPCs en un mismo proyecto

share VPCs: TODO:

Conectar varias VPCs:

- VPC NEtwork Peering (no sse pueden solapar rangos de IPs)
  - rutas transitivas
- Cloud VPN, tunel, es algo mas temporal, y puedes hacer rutas transitivas
- Multi-NIC: acoplando tarjetas de red una en cada VPCs, para analisis de trafico de seguridad

> TODO: slide de diferencias

Como conectar google cloud con otros clouds o con on-premises (hybrid connectivity)

- Cloud VPN IPSEC
  - Fácil de configurar
  - Vas por internet
  - Barato
  - No tiene buen rendimiento
- Cloud Interconnect
  - Vas por una red privada
  - Casos:
    - Subir mucho tráfico
    - Datos en on premises
- hay una version nueva llamada Cross Cloud Interconnect: que puede irse a una zona itermedia o incluso a recursos del propio google cloud en el cloud del otro proveedor

Firewall: determinar que tráfico entra y sale de la VPC. Reglas de firewall. desde que orgien a que objetivo o al reves, filtros por la red de origen o por Service Accound que tienen asociadas

- Regla de firewall a maquinas con autoscaling, se la da la regla asociada a la service account de las maquinas
- Buena practica es tener reglas de firewall por etiquetas o por service account
- Las reglas son estáticas, si se quiere algo dinamico es una version mejorada que cuesta mas. Ej: Puede shacer como loimitar acceso de TOR
  
Cloud Armor (WAF y Shield en AWS):

- Proteger contra ataques DDoS
- casos:
  - Dominio o ruta que están constantemente atacados
  - rate limit a endpoint

Cloud NAT:

- TODO:

Cloud Load Balancing:

- Application Load Balancing (CApa 7)
  - Externo:
    - Global: Global External Load Balancer
    - Regional: Regional External Load Balancer
  - Interno
    - Regional: Regional Internal Load Balancer
  - HTTP/HTTPS
  - SSL offloading
  - URL maps
  - Backend services
  - Health checks
  - Cloud CDN
- Network Load Balancing (Capa 4)
  - Proxy:
    - External:
      - Global: Global External Load Balancer
      - Regional: Regional External Load Balancer
    - Internal:
      - Regional: Regional Internal Load Balancer

- Passthrough
    -
  
  - TCP/UDP
  - SSL passthrough
  - Global external IP
  - Health checks
  - Backend services

TODO: Load Balancing decision tree

Pregunta ruta mas corta:

- El balanceador global, tu publicas una sola ip. anycast. las rutas que se anuncian son inteligentes.
- Si tienes balanceador regional. Crear registros de tipo A. Depende de como sea la APP y del ingress
- Igual que con Route 53 en AWS, registros basados en ubicación
-

### DNS

Transformar nombres de dominio a IPs

Recordar que hay un . al final que es el root y que normalmente se omite

Internal DNS:

Cloud DNS:

- Zona publica y poner el registro del dominio
- Zona privada y poner el registro del dominio que solo se puede resolver desde la VPC
  - Otro caso de uso para tenerlo en zona privada: para base de datos, en vez de ip pues das nombre.
- SLA del 100%

## Google Cloud Storage

Esto no es para: acceso a dato tenga sistemas de archivos

- Simple
- Reliable:
  - 11 9s de durabilidad
  - 4 9s de disponibilidad
- X
- X

Casos: imágenes, logs, pdfs, reportes.

Clases (se paga por gb y por acceso al archivo, así que hay que jugar con ellas), de mas a menos caro, de mas a menos veces que se accede

- Standard
- Nearline
- Coldline
- Archive

Las clases van por objeto.

La latencia de acceso es la misma, en cambio en S3 de AWS, la latencia de acceso es mayor en las clases mas baratas. Pero si que baja la disponibilidad, no la latencia.

Pregunta de ejemplo:

- que clase de almacenamiento para backups que se accede una vez al mes
- Si se conoce el patrón de acceso, no usar autoclass, marcarlo directamente.
- Tambien puedes accecer politicas de ciclo de vida, para que se mueva de una clase a otra en funcion a un tiempo o incluso lo borre.

TODO: tabla orientativa de cuando usar cada clase

| | < 1 month | 1-3 months | 3-12 months | > 12 months |
| --- | --- | --- | --- | --- |
| Standard | X | X | X | X |
| Nearline | | X | X | X |
| Coldline | | | X | X |
| Archive | | | | X |

Google Cloud Storage Autoclass: te autoajusta y va moviendo por objeto

- Tiene coste de gestion por objeto, pero se ahorra con el coste de gestion

Localización el bucket:
Regional: 1 zona

- Cuando: analitics
Dual-regional: 2 zonas
- Tienes tu el control
Multi-regional: 2 o mas zonas
- Donde replica cada objetivo, google lo hace automatico
  - Solo puedes decidir, si europa, si us, si asia

Casos:

- Streaming en dual o multi regional

Preguntas:

- Disponibilidad pero barato: multi-regional

TODO: diagrama de replicación de objetos.

## Google Compute Engine

Lanzar maquinas virtuales en la nube

- Mas barato
- Mas rápido
- Desde el SO que quieras y hacer lo que quieras

20 - 30 segundos en arrancar
Mantenimiento, migración en tiempo real a otro host físico

Familias de maquinas:
TODO: diagrama

Proposito general:
E2: web servers, Dev
N2, N2D:
T2D, T2A: Scale out

Workload optimizado:
C2, C2D, C3:
M1, M2:
A2, A3:

*A: procesadores ARM
*D: AMD

Diferencia las de ARM hay que recompilar tu software
las ARM son mas baratas

n2-standard-4-X
N: serie o familia
2: generación
standard: tipo
4: numero de vCPU
X: numero de memoria

Puedes crear maquinas custom con la cantidad de vCPU y memoria que quieras hasta un limite

Managed Instance Groups (MIGs):
Maquinas iguales que puedes crontrolar como una instancia
Especificas una plantilla y el grupo te mantienen el numero de instancias que le digas
Puede poner autoscaling
Cluster de máquinas
autohealing: si una instancia falla, la reemplaza. El grupo lo que hará sera siempre mantener ese numero de instancias

Sole Tenant Nodes:

- No compartes el host fisico con nadie.
- Temas de seguridad, cumplimiento, licencias, ...

Sustanced use discounts:

- hasta el 30% de descuento

Spot VMs:

- Batch jobs
- Maquinas iguales con hasta una 91% descuento. Si lo necesitas, se quita.
- FLotas de apis que soportan caidas. Bien arquiectado, no se nota la caida.
- Se puede poner para GKE con standard, y con autopilot.

Descuentos por usos comprometidos:

- Si sabes que bas a usar la maquina.
- Antes era por familia. Ahora enta el Flex, que te comprometes en en 4 dólares la hora. Mirar por regiones esta muy bien.
- Bases de datos por ejemplo

Disks:

- Crear discos adicionales diferentes caracteristicas rendimiento, capacidad, ...
- TODO: Tabla de comparación de discos
- Extreme SSD: para bases de datos con muchos IOPS, porque puedes configurarlos y son modelos concretos.

Cada maquina virtual tienen un disco ssd local asociado al host fisio y temporal.

- ¿?

Preguntas:

- Cuales las mejor forma para una
