# [Microservicios](https://martinfowler.com/microservices/)

## Pre-requisitios

- Aprovisionamiento rápido: Un nuevo servidor en cuestión de horas
- Monitoreo básico:
  - it's essential that a monitoring regime is in place to detect serious problems quickly.
  - Detectar problemas técnicos (contando errores, disponibilidad del servicio, etc.)
  - Monitorear los problemas comerciales, como detectar una caída en los pedidos
- Implementación rápida de aplicaciones:
  - Esto implicará un [DeploymentPipeline](https://martinfowler.com/bliki/DeploymentPipeline.html) tanto para pruebas como para producción

## [DevOpsCulture](https://martinfowler.com/bliki/DevOpsCulture.html)

- el aprovisionamiento y la implementación se puedan realizar rápidamente
- pueda reaccionar rápidamente cuando su supervisión indique un problema.
  - desarrollo y las operaciones, tanto en la solución del problema inmediato como en el análisis de la causa raíz para garantizar que se solucionen los problemas subyacentes.

Mas alla de unos pocos Microservicios:

- Deberá rastrear las transacciones comerciales a través de múltiples servicios
- automatizar su aprovisionamiento e implementación mediante la adopción completa de [ContinuousDelivery](https://martinfowler.com/bliki/ContinuousDelivery.html)
- También está el cambio a [equipos centrados en el producto](https://martinfowler.com/articles/microservices.html#OrganizedAroundBusinessCapabilities) que debe iniciarse
- Deberá organizar su entorno de desarrollo para que los desarrolladores puedan intercambiar fácilmente entre varios repositorios, bibliotecas y lenguajes
- Un [modelo de madurez](https://martinfowler.com/bliki/MaturityModel.html) puede ayudar a medida que asumen más microservicios

combina estrechamente la orientación del usuario, la lógica empresarial y la capa de datos.
es lo suficientemente moderna como para justificar la descomposición en lugar de una reescritura y reemplazo completos.

una arquitectura de microservicios:

- creación de Service Mesh, una capa de infraestructura dedicada para ejecutar una red rápida, confiable y segura de microservicios
- sistemas de orquestación de contenedores para proporcionar un nivel más alto de abstracción de la infraestructura de implementación
- evolución de sistemas de entrega continua como GoCD para construir, probar e implementar microservicios como contenedores.
- API Gateway

Roadmap

- Elegir una que esté bastante desacopladas del monolito, no requieran cambios en muchas aplicaciones orientadas al cliente que actualmente usan el monolito y posiblemente no necesitan un almacén de datos. Esten en le borde de la aplicacion.
  - Con el objetivo de practicar

> Como principio fundamental, los equipos de entrega deben minimizar las dependencias de los microservicios recién formados con el monolito.

En los casos en los que un nuevo servicio termina con una llamada al monolito, sugiero exponer una nueva API del monolito y acceder a la API a través de un método anticorrupción. Capa en el nuevo servicio para asegurarse de que los conceptos de monolito no se filtren.

El principal impulsor de las capacidades de desacoplamiento de un monolito es poder liberarlas de forma independiente. Este primer principio debe guiar todas las decisiones que tomen los desarrolladores sobre cómo realizar el desacoplamiento. Un sistema monolítico a menudo se compone de capas estrechamente integradas o incluso de varios sistemas que deben liberarse juntos y tienen interdependencias frágiles.

La mayoría de los intentos de desacoplamiento comienzan con la extracción de los componentes orientados al usuario y algunos servicios de fachada para proporcionar API amigables para el desarrollador para las interfaces de usuario modernas, mientras que los datos permanecen bloqueados en un esquema y sistema de almacenamiento.
