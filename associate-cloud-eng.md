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

IAM, politica de iam, documento quien puede hacer que sobre qeu recuros y de manera opcional bajo que condicione
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

## Google Kubernetes Engine

Cluster: conjunto de maquinas

Cluster donde puedes lanzar contendores

Como va kubernetes:
Tu defines lo que quieres y kubernetes se encarga de llegar a este estado, si mure va a intentar llevarlo a ese estado.

kubectl - la linea de comandos de Kubernetes

Pod es la unidad minima de Kubernetes, se componen de Pods
Conjuntos de contenedores que estan dentor de la misma red

Sidecar -

Service: se compone de Pods, y dentro del spec tienes un selector, app: frontend

El ingress tambien se configura por servicio, donde defines en el backend el serviceName y el servicePort

en GKE que es el Kubernetes de google que ayuda en la gestión del cluster

Los Node Pools son grupos de nodos que tienen la misma configuración de maquinas virtuales

y la diferencia con los pods es que los nodos son maquinas virtuales y los pods son contenedores que corren en los nodos

**Cluster autoscaler**: si necesitas mas nodos, los crea, si no los borra.
El Horizontal Pod Autoscaler **HPA**, el autoscaler de los pods, si necesitas mas pods, los crea, si no los borra. Pero si no hay espacio para que esto ocurra, el cluster autoscaler no puede hacer nada. Están relacionados pero no dependen el uno del otro.
Vertical Pod Autoscaler **VPA**: si necesitas mas recursos, aumenta los recursos, si no los disminuye.

### GKE autopilot

Hasta aqui GKE da cosas, pero tu tienes que gestionar node pools, autoscaling, logging, monitoring, DNS, ...

Pero con GKE autopilot, google se encarga de todo esto, y tu solo te preocupas de los contenedores.

## Cloud Run

Es un servicio de contenedores sin servidor

Se ejecuta sobre kubernetes, pero tu no te preocupas de nada

...

## App Engine

El antecesor a Cloud Run

Pregunta:  Si se sale de lo estandar, usar App Engine tipo Flexible

Deprecarlo, por Cloud Run

## Cloud Functions

Funciones sin servidor

Bajo un evento se ejecuta una función, pasa A, B ocurre entonce C.

Event driver serverless compute platform

El modelo de pago es el mismo de cloud run.

Diferencia con cloud run, que cloud run es para contenedores y cloud functions es para funciones o codigo concreto sin necesidad de contenedorizar.

No tiene tanta flexibilidad como cloud run, pero es mas facil de usar.

Tienes limites de tiempo de ejecución. Mure por definición. Si necesitas mas tiempo, usar cloud run. Esta pensado para cosas rapidas, algo rapido.

--

## Databases en GCP

Cloud SQL:

- as

AlloyDB:

- Separa la capa de computo de la capa de almacenamiento. Si quisieras
- Motor columnas, todos los datos de una columna juntos, para analisis. Agrerado de datos, no transaccional.
- cache en cada maquina
- Postgres sobre vitaminado
- Cargas de trabajo compatibles con postgres. Gente de Oracle. Consultas analiticas sin datawarehouse.
- Tener una replica en allow es mas rapido que en cloud sql

Cloud Spanner

- invento google, no suele caer
- si comparas sql vs nosql son paradigmas distintos
- Relation semantics, Schemas, ACID, transacciones, SQL unido a la escalabilidad horizontal y global
- con 99.999% de disponibilidad, totalmente manejado
- RDBMS.
- YouTube, Gmail...
- Casos de usos: consistencia fuerte y alta disponibilidad. Banca, tieneda de productos de venta global.

Firestore:

- Base de datos documental. Serverless.
- No schema,
- Era un producto de firebase

Big table:

- clave valor de columna ancha, no fuerza a tener mismas columnas
- Casos de usos: contadores, IOT, anuncios con latencias bajas.

Slide de comparación de bases de datos

![Optional Image Description](https://storage.googleapis.com/gweb-cloudblog-publish/images/Which-Database_v03-22-23.max-2000x2000.jpg)

Tips:

- Global
- big table para iot o sensores,

### Pub/Sub

Que es: Sistema asincrono para conectar productores y consumidores

- Solo envia, no transforma los mensajes
- Broker de mensajes y colas

Resuelve:

- Diferente velocidad entre productor y consumidor
- Diferente velocidad entre consumidores
- absorber picos de trafico
- no perder mensajes

Ciclo de vida: publicador que lanza el mensaje, el mensaje se va a un topic, y el consumidor se suscribe a ese tema. Tu creas una subcripcion a un tema si te vas a suscribir a ese tema. Tiempo de vida de los mensajes: 7 dias en el message storage. Y el ack, cuando te llega el mensaje, haces el ack para que no vuelva a llegar.

Casos de uso:

- IoT, sensores
- Gmail tiene esto, para que no pierdas mensajes
- totalmente manejado
- Scala, fiable esta en todas las regiones y es global de cualquier region a cualquier region.
- Perfomance: 1 millon de mensajes por segundo.
- Coste pago por uso.
- hasta 100gbs
- 3x3 replicacion hasta 7 dias
- cifran en transito y en reposo

Patrones:

- Fan out: un mensaje a muchos consumidores
- Fan in: muchos mensajes a un consumidor
- Pub/Sub to Cloud Storage: cuando llega un mensaje, se guarda en un bucket de cloud storage para analisis posterior o para guardar el mensaje para siempre. Ej: para cumplir con la ley de retención de datos.

Idependientemente de cuanto mensajes haya los envia a cada subcripcion. y cada uno se lleva 1 mesnaje. vs dos subcripciones que se lleva el mensaje los dos.

Push vs pull, admiten los dos. Push es mas facil de usar, pero pull es mas escalable.

Simple pubsub look like. Caso de HR. HR system enviar un evento de message a un topic, y el cada uno de los sitemas que necesitan ese evento se suscriben a ese topic, y en cuanto llega el mensaje, lo procesan.

Puedne llegan mensajes duplicados, pero tienes menos latencias, pero si lo activas, pierdes latencia

revisar la parte del exacly once delivery. Solo se puede en una region.
Ahora tambien se puede que se envien en orden.

### BigQuery

No sale mucho, siempre que haya algo de analica, siempre bigquery, proque no hya mcuho de data

es un datawarehouse, querys analiticas.

unico, es serverless. admite real time.

- ML integrado
- BI engine
- Exabyte scale
- datos cifrados en reposo y en transito
- Solo pagas por las querys que haces, no por la infraestructura

Porque es tan rapido, y tieee tanta fama

- storage vs compute separado. Storage es muy barato.
- Puedes tener hasta historico
- ingestar es gratis en batch

Ingesta de datos:

- Batch
  - Dataflow
  - Pub/Sub
- Querys
- Data transfer service: para traer datos de otros servicios de google o de otros proveedores
- 3rd party

costes de ingesta + costes de querys + costes de almacenamiento

Almacenamiento columnar. Es mas rapido.

Storage optimizado, buenas practicas. A los 90 dias de un dato sin tocar, baja a la mitad. Cuando se resetea, cargas datos, copias, query y cuando haces streaming.

Limitless features:

- Particionado y clustering

Asi solo lees por particion, y no por todo el dataset y asi ahorras costes
clustering, aparte de columnar puedes ordenar por id de clientes, mas rapido

reclusterizar, es free, mainetenerlo es gratis, automatico

Caso real sin particionar, en filtrar 4$ vs 0.01$

Limite de 4000 particiones por tabla
beneficios de particionar
No particiones si neceistas usar los datos.
Clusterizar siempre, va mejor con LIMIT clauses, cuidado con las preguntas porque a veces usar el limit no afecta porque se lee todo.

En bigquery puedes tener columnas nested, y puedes hacer querys sobre ellas sin tener que hacer joins

- una reduccion de un 37% menos de coste

Query cache: si haces la misma query, varias veces, la segunda vez es mas rapida. La cache se invalida cuando hay datos nuevos. Si compañero hace una query, le cuesta. La cache es por cuenta.

Mayor interoperalidad: con otros servicios de google, con otros proveedores, con otros servicios de google cloud.

- Storage federation y Database federation, es decir, puedes lanzar querys a otros servicios de google cloud, o a otros proveedores, o a otros servicios de google cloud.

BigQuery ML: machine learning en bigquery, sin tener que mover los datos, y sin tener que mover los datos a un modelo. Puedes hacer modelos de regresión, clasificación, clustering, forecasting. Tienes que tener Vertex AI para hacer modelos mas complejos y hay un pricing espacial.

- Buil-in models
- Feature
- MLops
- AI/ML applications
- Motor de inferencia

Casos de usos y beneficios: Gente, coste y complejidad y seguridad

### Otros servicios de analitica

#### dataflow

Transformar datos en tiempo real o batch

- Servicio sobre Apache Beam
- millones de queries por segundo
- totalmente manejado
- Conectar data source: Pub/Sub, BigQuery, Cloud Storage, con target sources

Que es un pipeline: Esto es de apache beam. Pipeline: source, Ptransform, Pcollection, Sink. Todo esto de la P es porque es en paralelo.

dataflow pipelen, python, java, node. para integrar con otros servicios de google cloud es muy facil, p.apply(PubSubIO.Read().from("topic")

Ventanas fijas: Cada 5 mensajes haz la transformacion
ventanas deslizantes:
ventanas de sesion: Por usuario, por ejemplo

#### dataproc

Hadoop y Spark

Traerte tus cluster de hadoop.

Hadoop manjeado. serveless or compute. no lock in, integrado.

ventajas de on-premise vs compute vs dataproc

Cluster flexibles, autoscaling, integracion con otros servicios de google cloud

Te creas cluster muy facil para cada trabajo, y luego lo borras. ETLs de mapreduce, spark, hive, ML

#### datafusion

Basado en cdap, que es hacer pipelines de datos de manera visual, muy sencillo.

### Composer

Cluster de Airflow de manera sencilla

- Orquestar pipelines de datos de dataproc

## Samples Questions

100TB de datos no relaciones, bigtable en vez de bigquery por la cantidad de teras
migrar de on-premises a cloud uyn mysql, cloud sql
base de datos, escale gb, datos relaciones, escalado horizontal, Cloud Spanner.
10TB en bigQuery hjay spike enorme en querys, columnas que quieres.

- no selector en bigquery
20tb datos no acceder high, minimo precio, datos accedidos un par de veces al año, coldline porque es cada 90 dias.
applicacion acelerar la eficiencia de productos hacer sinks a aun sitio. Pub/Sub a Cloud Storage por que los logs solo se exportan a BigQuery or Pub/Sub

## Consejos para el examen de la certificación

Perder el miedo la proceso y al examen.

Si suspendes tienes unas restricciones

- TBC

| Level | Description | Duration | Cost | Questions | Languages |
|-------|-------------|----------|------|-----------|-----------|
| Foundational | Validate broad knowledge of cloud services | 90 min | 99$ + tax | 50 - 60 questions, multiple choice, multiple select | English, Japanese |
| Associate | Validate fundamental skills to deploy and maintain cloud solutions | 2 hours | 125$ + tax | 50 - 60 questions, multiple choice, multiple select | English, Japanese, Spanish, Portuguese |
| Professional | Validate key technical job functions and advanced skills | 2 hours | 200$ + tax | 50 - 60 questions, multiple choice, multiple select | English, Japanese* |

En marzo del 27 de 2024

Se abre un nuevo examen de certificación Professional Cloud Developer (Beta)

- 3 horas
- 120
- 70 - 75 multiple choice, multiple select questions
- English

Decidir como te examinas, en casa o en un centro de examen.

on site:

- Madrid hay 4 centros de exámenes, technoform, prometric, pearson vue, ...
- Los horarios son bastante limitados, de 9:00 a 17:15
- Bueno que tiene, el proceso es mucho mas sencillo, te registras y te envian un codogp, te presentas 15 min antes, dos ids, primaria (DNI, oficiales) y secundaria (tarjeta de credito, biblioteca, ...)
- No puedes pasar dentro con nada, a veces hay taquillas, para dejar las cosas, pero depende de la demanda.

Remoto:

- Proceso para examintarte online, te registras, tienes multitud de horaios. Requisitos: entornos tranquilo, sin ruido, durante todo el examen vas a estar vigilado y grabado, para que no te lean las preguntas. Vas a tener que enseñar la habitación, la mesa, el suelo. Instalar un software que te va a bloquear todo los programas, salvo el navegador.
- Verificación de identidad previo al examen.
- Lanzarlo desde el entorno, y se activa 10 min antes de la hora del examen. Aunque tu tengas una hora, hay una serie limitadas de personas controlando, puede que pase la hora de inicio, pero no cuenta. No hace falta dos autorizaciones, solo una.

En cualqueir momento puedes volver a cualquier pregunta.
Haz una pasada por todas, si eso, continua y luego vulves a las que no has respondido.
El de arquitec es el unico que mantiene los casos de estudio: Son preguntas que te dan un caso de estudio y luego te hacen preguntas sobre el caso de estudio. Familiarizate con los casos de uso típicos, y asi las respuestas que cojamos tiene que estar de acuerdo con el caso de uso.

- Ejemplo: casos de uso de preferencia de open source, entonces aunque la respuesta sea de google con una tecnologia que cuadra perfectamente, habria que elegir la de open source.

El resultado final, cuando acabas te da una aproximación, te llega una semana despues, no te dijen nada más, aprobado o suspendido.

cloud.google.com/learn/certification

- Guides, de cloud engineer. Porcentaje de peso por cada bloque.

<https://cloudskillsboost.google/paths/11>
<https://github.com/sathishvj/awesome-gcp-certifications>

<https://cp.certmetrics.com/google/en/login>

Si, suspendes, ahora en google tienen un portal que te dice las partes que tienes que mejorar.

Todos los examen duran 3 años

Codigo de renovacion de certificación, o para una segunda certificación: 50% de descuento.

puedes pedir una extension de tiempo si no es tu idioma nativo.

## Ejemplo de preguntas

- 3 tipos de roles, roles basicos (primitivos, owners, viewer, writer...), roles predefinidos, roles personalizados
- Multi-AZ, alta disponibilidad generas un standby y hace un failover. Set Up read replicas, para que las lecturas se hagan en las replicas y no en la principal.
- firewall gestionados que permite conexiones entrantes, permitir una regla solo si no hay otra: Prioridad, con el numero mas bajo es la que se aplica primero. 65535 es la ultima, 2^16
- que commando metadata de una instancia de VM: curl <http://metadata.google.internal/computeMetadata/v1/>
  - buena practica asocial la google account a una service account, token temporal. Los sdks de GCP, ya lo hacen por ti.
- nueva version de app engine para solo el 1% de los usuarios. Traffic Splitting, para que solo el 1% de los usuarios vean la nueva version.
- Capcidad disponible de una manage instance group, no baja con una nueva version: Rolling update, poniendo el maxSurge set a 1 y el maxUnavailable a 0, solo va de una en una, y no admites que no haya ninguna disponible.
- Requistos, base de usuarios desconocidos, database soluction que puede escalar con cambios minimos, es base de datos relacional: Cloud Spanner

bit.ly/gcp-ace-test
