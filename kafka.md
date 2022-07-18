# kafka

Replication factor de 3 -> 300gb -> 100gb
El minimo replicas: 2

cuanto tiempo queramos darnos para reprocesar en funcionar

en cloud mucho mas estable

operacional:

- zookeeper: tiene problemas de seguridad y no los actualiza, con lo cual los van a cambiar.
- zookeeper: cuorum, minimo 3 maquinas.
  - 3.0, 3.1 ya no lo lleva
- Monitorizar
  - Metricas cambiarlas para prometheus
- Incidencias: replicación
  - El nodo da ack de las X replicas
  - en otros sistemas analitica, con un ack de 1 vale
  - Cuando se caen el "mínimo de replicas" deja de acceptar mensajes. Porque no puede replicarlo
    - Pero se puede tener lectura de los mensajes

No confluence cloud tiene las api muy bien, pero hay scripts oficiales que hacen lo mismo

particiones lo mas balanceado posible. Misma clave para cosmos y kafka.
