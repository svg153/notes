# [Charlando sobre Kubernetes Multi Cluster con KELSEY HIGHTOWER!](https://www.youtube.com/watch?v=e1bavPwQmVc)

## [¿Que son los contenedores y los orchestrators?](https://youtu.be/e1bavPwQmVc?t=315)

una plataforma que ayuda a los desarrolladores o al equipo de operaciones a reducir el time to prod y mejorar el ciclo de vida de los aplicaciones

## [¿Deberían los desarrolladores saber de Docker y Kubernetes?](https://youtu.be/e1bavPwQmVc?t=393)

Es importante tener un equipo dedicado a mantener la infraestructura y que se focalice en tenerla un plataforma evolutiva en el tiempo por lo que hemos aprendido del pasado desde Windows Server a Kubernetes. Y así los desarrolladores se pueden centrar en el desarrollo. Al final ellos han hecho la aplicaciones y saben como quiere que funcione, por lo tanto, tienen que haber una colaboración entre ambos equipos. Por tanto si ambos equipo entienden algo del lenguaje del otro la colaboración será mucho mas fluida.

## [¿Cuando crear un nuevo cluster en vez de añadir mas nodos?](https://youtu.be/e1bavPwQmVc?t=561)

Hay que tener en cuanta el hardware de cada maquina. Mejor 1 maquinas de 4 cores que 5 de 1 core.
Porque en un solo dominio. Riesgo de cosas como el fuego, la red se corta, etc... Si lo divides en varias, reduces el problema.

A veces tienen sentido escalar el cluster
Kubernetes tiene un control plane.

Mejore dividir en cluster, para actualizaciones.

## [¿Multicluster en Kubernetes?](https://youtu.be/e1bavPwQmVc?t=744)

Como crear archivos de configuración y como distribuirlos, eso es para todo, no solo para Kubernetes
En el caso de Kubernetes hay una API.

- cuando empiezas, con un pull de un repo.

<https://youtu.be/e1bavPwQmVc?t=968>
GitOps no funciona en todos los casos, una función que necesita implementarse progresivamente y distribuirlo progresivamente en uno o mas clusters. Para eso, no se puede definir un fichero estático y Kubernetes no ayuda. Hay otras herramientas que ayudan como Flagger, Argo CD & Rollouts, pero no hay nada definitivo,

## [Multi Ingress / Istio](https://youtu.be/e1bavPwQmVc?t=1040)

Cuando tienes varios clusters puedes hacerlo con Istio y Envoy pero al final tienes que instalar en cada uno de ellos y comunicarlos entre ellos y eso no es un buena practica porque al final uno se convierte en el principal, pero al final Envoy se ejecuta "en el borde del cluster" pero dentro del cluster.

En GCP se han hecho Traffic director o Anthos Service Mesh.

Lo que hacen es crear una capa por encima de las "regiones" y crear una capa de servicios.

sacar el control plane fuera del cluster y llevarlo a un area mas centrar y así poder controlar varios clusters a la vez.
El data plane se sigue ejecutando en el cluster, pero el control plane esta fuera.

- Esto permite registra varios clusters en "un dominio". Ir a un "registro de servicios" y poner las reglas de Istio y en control plane lo comunicará los data planes de los clusters.
  - Con esto puedes escalar horizontalmente.

Cuando tienes varias regiones pones un balanceador global de carga encima de esas regiones (Google Cloud Load Balancer)

## [Infraestructura como datos](https://youtu.be/e1bavPwQmVc?t=1361)

¿Cuando deberías empezar ha hacer la infraestructura con Kubernetes en vez de con Terraform? ¿Terraform, Ansible, deberíamos seguir usándolas ahora?

- Primero hay que preguntarse ...
  - ¿Que resolvían en el momento que se crearon?
  - ¿Para resolver eso mismo, ahora hay algo mejor?

¿Que resolvían en el momento que se crearon?

- Puppet: se creó para automatizar ciertas acciones en servidores linux. Se centró en el "scripting".
- Terraform: Se centro en la infraestructura y los cloud providers que ya tenían una API definida e hicieron un lenguaje mas declarativo.
  - tiene un problema: Actualizar una VM, dependiendo el cloud puede que sea borrar y crear de nuevo y eso hace que no lo sepas tu con solo ver el fichero. ya que es algo interno de Terraform y el cloud prov. Así que, solo te queda avisar.
  - Lo bueno que tiene que vale para muchos sistemas y conectarlos.
  - 3 niveles (decide ownership and behavior): cloud providers control plane, terraform module, HCL files.

> _When you say infrastructure is code and you own the resource, then you code is nothing more a mere suggestion and you are going to lose the synchrony between your logic and the actual logic of your provider_

Kubernetes se basa en la **Promised Theory**, _Tell me what you want and I will do whatever it takes to get you there_

En Kubernetes, no necesitas escribir código (porque existen unos controladores que poseen toda la lógica y si no, lo puedes implementar tú "custom resource definition") solo tienes que decir lo que quieres que haga (de manera de manera declarativa) y el controlador de Kubernetes lo hará, porque sabe gestionar todo lo relacionado con contenedores, desde bajarlos y rearrancarlos cuando fallan, hasta actualizarlos.

Esto permite tener solo información de la infraestructura, pasando de **infraestructura cómo código** a **infraestructura como dato** (no es YALM vs HCL, es data vs code)

Al tener **infraestructura como dato**, te puedes beneficiar de que los datos son intercambiables. Puedes usar Helm pasarlo luego a Ket, y luego pasarlo a otra que haga comprobaciones de seguridad, etc... Y te permite hacer **data pipelines** con tu infraestructura.

Con los datos puede tenerlo en git, diff, backup, restaurarlo y volver al estado anterior sin perder el contrato original. El software no funciona así lo que ves no refleja la realidad.

Al final, va a seguir terraform y demás, para crear el cluster pero no para administrar los recursos.

## [La polémica de Docker Desktop](https://youtu.be/e1bavPwQmVc?t=)

El negocio del software se basa en tener clientes que paguen por un software, para poder pagar a los desarrolladores para que puedan seguir mejorándolo para tener mas cliente y obtener beneficios.

El software libre, puedes cambiarlo y no pagar por el. Así que, las únicas maneras de que esos productos libres, sigan siendo sostenibles (añadiendo nuevas funcionalidades, arreglando errores, seguridad) es que algo o alguien subvencione o haya un modelo de negocio sostenible para seguir pagando a los desarrolladores a largo plazo.

Lo que hay que poner el foco es en el roadmap de los productos para seguir pagando la suscripción o no

## [Como Kubernetes ayuda a desarrolladores a avanzar más rápido](https://youtu.be/e1bavPwQmVc?t=)

¿Necesitan de verdad uqe la gente comprenda Kubernetes?

- Kubernetes es como un librería para el desarrollo de la infraestructura, pero es una librería de bajo nivel. Como el tiempo la gente hará librerías de alto nivel abstrayendo y haciendo mas simple la creación de la infraestructura para los desarrolladores.
  - Tienes librerías de mas alto nivel como Knative, Cloud Run que se enfocan en el despliegue de aplicaciones ocultando los objetos de bajo nivel.

> _Use the tools you need at the layer which you work but always question are you working at the right layer_

## [Como empezar en TI](https://youtu.be/e1bavPwQmVc?t=2197)

Encuentra una manera de convertir el miedo en curiosidad aprendiendo cosas nuevas.

Los fundamentos son muy importantes, todo lo de ahora es gracias a toda la experiencia anterior.

Actualmente lo que estamos haciendo es creando experiencias para unirlas con los usuarios y recolectar datos de esa experiencia para poder mejorar esa experiencia.

El resto son herramientas para llegara conseguir eso, desde los lenguajes a la infraestrcutura.
