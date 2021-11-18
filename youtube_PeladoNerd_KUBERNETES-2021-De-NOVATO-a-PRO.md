# [KUBERNETES 2021 - De NOVATO a PRO! (CURSO COMPLETO)](https://www.youtube.com/watch?v=DCoBcpOA7W4&t=1596s)

...

## [RedinessProbe y LivenessProbe](https://youtu.be/DCoBcpOA7W4?t=2289)

ReadinessProbe: que tu pod está listo para recibir trafico.

- Si no le dices nada te va da siempre ok (Ready 0/1 o 1/1).

LivenessProbe: que tu pod está vivo y no quieres que lo mate.

- Muy recomendable si tu app tarde en arrancar.
  - En el caso de tener una app web en el 80 podrías LivenessProbe con un tcpSocket al 80 y un ReadinessProbe con un httpGet al path / y puerto 80 y esperar un status code 200.
    - Asi kubernetes sabe qeu esta viva, no la va a matar pero tiene que esperar un poco para mandar trafico ya que si lo mandas los users darían errores

## [Ports](https://youtu.be/DCoBcpOA7W4?t=2417)

## [Deployments](https://youtu.be/DCoBcpOA7W4?t=2473)

No deberíamos estar desplegando pods, y deberíamos hablar siempre de deployments.

El deployment es otro tipo de recurso de kubernetes. Es un template para crear pods.

Le puedes definir muchas cosas, como las réplicas.

Es lo que va a usar kubernetes para controlar que lo que está en el cluster es lo que se quiere.

## [DaemonSets](https://youtu.be/DCoBcpOA7W4?t=2628)

Es otra forma de crear un pod.

Es una forma de desplegar un pod pero en todos los nodos. Un solo pod en cada nodo. Cada uno es una replica de cada uno.

Se usa principalmente para hacer monitorización de servicios.

El deployment te ponga 2 pods en el mismo nodo y daemonSets no.

## [Manifiesto StatefulSet y Volúmenes](https://youtu.be/DCoBcpOA7W4?t=2811)

Cada vez que quieras algo que se mantenga cuando se muera un pod, tienes que usar StatefulSet.
Si quieres que una app se mueva entre nodos, debes usar StatefulSet para mantener los datos.

@CONTINUE@
