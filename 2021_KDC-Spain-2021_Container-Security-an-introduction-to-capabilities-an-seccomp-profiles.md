# [Container Security, an introduction to capabilities an seccomp profiles - Mario Vázquez, Red Hat](https://www.youtube.com/watch?v=yCp_cPiJF14)

## Linux Capabilities

Before Kernel 2.2

- Privs: UID = 0 -> Avoid kernel checks
- Non-Privs: UID != 0 -> Kernel checks

After Kernel 2.2:

- Los privilegios dejar de ser algo del UID y de todo o nada , y pasa a ser capabilities concretas que un programa puede hacer o no. Si puede hacerla es que tiene privilegios para esa en concreto.
- Cada hilo tiene sus capabilities
- Some of the capabilities are enable by def, CRI-O, ContainerD

Si necesitas usar una capabilities tiene que estar en el PermittedSet y en el EffectiveSet

### File capability set

Le das las Caps al binario. Y se las "pone" al thread.
No te sirve para hacer bypass

### Demo

Las capabilities estan en el `/proc/<ID_CONT>/status`

```bash
capsh --decode
or
docker / podman effectiveCaps
```

En el 20min

- En container que no sea root. Cuando tu app necesita caps, hay que ejecutarlo en el run con la capbility correcpondiente -> las ambient caps pero kubernetes no lo permite. ¿Como lo hacemos? ---> Con el la del file camps

> No puedes tener el puerto en el 80 porque no tienes esa cap en el efective

### Secure Computing (seccomp)

- Decidir que syscalls puede hacer la app
- Requiere conocer cosas de bajo nivel -> strace
- A nivel de podman hay una manera de hacerlo automatico, pero tienes que probar todo para no dejarte nada porque si no no te va a dejar usarla en ejecución
- Hay diferentes prefiles para run o crun.

### Demo de seccomp

Generar un perfil y aplicarlo y probar que falla con otras

## Linux Capabilities in Kubernetes

- User namespaces -> no tienen nada que ver con los namespaces de kubernetes
  - El contenedor se ejecuta como root pero
  - slinux ayuda a prevenir que puede ahcer el usuario
- A nivel de programación hay librerias qeu te permite solo cogerlas en el momento que la necesitan, la cogen y la quitan. Peo tienen que estar para poder cogerla, pero luego durante el resto del timepo no puede.
- SecurityContext configure AllowPriviliegeEscalation

### Demo de caps in kubernetes

- La cap de ambiente esta siempre vacia porque por ahora no lo permite
- en el 40min -> deploy con el drop de caps
- en el 42min -> pone la cap en el fichero

## Seccomp in Kubernetes

- /var/lib/kubelet/seccomp
- Kube 1.22 feature, perfil reducira las syscall per defecto

### Demo Seccomp in Kubernetes

- Aplicar los seccomp en los nodos para permitir las acciones

## Managing capabilities and seccomp on kubernetes

- PodSecurityPolicies
  - PodSecurityAdmission lo remplaza
  - Tambien hay gente que usa GateKeeper (OpenPolicityAgent) y SCC de openshift
