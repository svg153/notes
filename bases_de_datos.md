# Distintas bases de datos

[Fireship - 7 Database Paradigms](https://www.youtube.com/watch?v=W2Z7fbCLSTw)
[BettaTech - 5 Bases de Datos que DEBERÍAS CONOCER (como Ingeniero de Software)](https://www.youtube.com/watch?v=vvsqP1f1JJs)

## Relacionales

[Fireship - relational](https://youtu.be/W2Z7fbCLSTw?t=245)
[BettaTech - BBDD - relaciones](https://youtu.be/vvsqP1f1JJs?t=121)

Desde 1974
Las mas populares.

Utilizan paran representar datos que tienen una estructura y relaciones entre datos

Datos en tablas cada entidad determinada que tienen clave primaria (primary keys).

Relaciones entre modelos se definen con la clave foranea (foreign key), identificadores qeu existen en otra tabla

Consistencia de los datos, porque al borrar un intenten que esta referenciado o referencia a otra tabla, el motor se da cuenta.

Requiere un schema de definicion de la base de datos.

ACID: Atomicity, Consistency, Isolation, Durability

Utiliza un lenguaje especial llamado Structured Query Language (SQL) que te permite realizar consultas a la base de datos.

Casos de uso:

- Solventa la mayoria de los problemas de la aplicacion
- :warning: No para datos no estructurados

Ejemplos:

- MySQL
- PostgreSQL
- SQLite
- Oracle
- Microsoft SQL Server (SQL Server)

## No relacionales (No SQL)

[BettaTech - BBDD - relaciones](https://youtu.be/vvsqP1f1JJs?t=200)

hay muchos subtipos de bases de datos no relacionales.
Decidir que base de datos especifica que queremos usar hay que usar.
Es mejor no llamarlas no relaciones, es mejor subirlas al mismo nivel que las SQL.

## Bases de datos de clave-valor

[Fireship - key-value](https://youtu.be/W2Z7fbCLSTw?t=45)
[BettaTech - BBDD - calve-valor](https://youtu.be/vvsqP1f1JJs?t=239)

Tablas de hash vitaminadas.

Para acceder a un elemento usamos su clave.
Son muy rapidas en las lecturas porque están en memoria RAM.

Rapidas pero no puedes hacer consultas complejas y al estar en RAM no puedes tener bases de datos muy grandes.

Se pueden guardar tambien en disco no solo en RAM.

Casos de uso:

- apps de caché
- Pub/Sub
- Leaderboard

Empresas:

- [Github](https://github.blog/2009-10-20-how-we-made-github-fast/)
- [Twitter](http://highscalability.com/blog/2014/9/8/how-twitter-uses-redis-to-scale-105tb-ram-39mm-qps-10000-ins.html)
- Snapchat

Ejemplos:

- Redis: SET and GET
- Memcached
- LevelDB
- Cloud wrappers
  - Amazon ElastiCache (Redis)

## Bases de datos basas en documentos

[Fireship - documents](https://youtu.be/W2Z7fbCLSTw?t=167)
[BettaTech - BBDD - documentos](https://youtu.be/vvsqP1f1JJs?t=295)

Utilizan el concepto de documento, que es un conjuntos de información estructurada como json, xml, yaml.
Ofrecen herramientas de consultas avanzadas.
Consultas sobre los atributos individuales de los documentos, flexibilidad.
Mas dificultad para gestionar relaciones entre entidades y por tanto la consistencia de los datos. La responsabilidad de esto cae en el programador y es mas complejo.
Candidatas para pruebas de concepto, y prototipado de aplicaciones.

Cada documento es un contenedor de key-values no estructurados.
Los documentos se agrupan en colecciones que tienen indices y se pueden relacionar entre ellos con relaciones.

Casos de usos:

- Solventa la mayoria de los problemas de la aplicacion
- Juegos
- IOT
- :warning: No es ideal para grafos.

Tradeoff:

- :+1: Schema-Less
- :+1: Relational-ish queries
- :-1: withouth joins

Ejemplos:

- MongoDB
- CouchDB

### Bases de datos para búsqueda

Las bases de datos funcionan muy similar a las basadas en documentos.

La diferencia es que analiza todo el texto y genera indices para cada elemento "buscable" (similar a como lo hace en un libro en el indice de palabras).

Muy rapidas, y pueden admitir errores de sintaxis, sinónimos, y busqueda en diferentes idiomas.

Casos de uso:

- Motores de búsqueda (Search Engines)
- Type-ahead

Empresas:

Ejemplos:

- elastic
- Solr
- algolia
- meilisearch

Esta construidas a partir de Apache Lucene (1999).

## Bases de datos basas en grafos

[Fireship - graph](https://youtu.be/W2Z7fbCLSTw?t=381)
[BettaTech - BBDD - grafos](https://youtu.be/vvsqP1f1JJs?t=381)

Los grafos sirven para modelar casos de unos como relaciones entre usuarios, mapas gps.

Data como nodos y relaciones como aristas.

Te permiten ejecutar los algoritmos mas comunes en los grafos, como encontrar caminos o encontrar arboles de generación

Cypher vs SQL

Casos de uso:

- Grafos
- Grafos de conocimiento (Knowledge Graph)
- Motores de recomendaciones (Recommendation Engine)

Empresas:

- Airbnb

Ejemplos:

- Neo4j
- ArangoDB (multiparadigma, clave-valor y documentos)

## Bases de datos columnares (wide column)

[Fireship - wide column](https://youtu.be/W2Z7fbCLSTw?t=108)

Es como las key-value, pero añadiendo otra dimension

Es mas facil de escalar en multiples nodos

Tradeoff

- :+1: Schema-less
- :-1: Without joins

Casos de uso:

- Time-Series
- Historical records
- High-Write, Low-Read

Ejemplos:

- Cassandra
- Apache HBASE

### Bases de datos de series temporales

[BettaTech - BBDD - time series](https://youtu.be/vvsqP1f1JJs?t=418)

Basa de datos para guardar datos basados en series temporales.

Te permite hacer cualquier funciones sobre el tiempo, medias, desviaciones, etc.

Especialidades en ingerir grandes cantidades de puntos de una métrica

Casos de uso:

- Monitorización de infraestructura
  - CPU a lo largo del tiempo
- Ambiental
  - Temperatura a lo largo del tiempo

Empresas:

- [Netflix](https://netflixtechblog.com/scaling-time-series-data-storage-part-i-ec2b6d44ba39)

-

Ejemplos:

- influxDB
- Amazon TimeStream

## Bases de datos multiparadigma (multi-model)

Pensabas para abstraer de la complejidad de las bases de datos, desde el punto de vista de un Frontend.

Tu defines el modelo y lo que quieres y la base de datos se encarga de ver en que typo de base de datos encaja mejor.
Puedes tener diferentes bases de datos pero hacer queries de la misma manera a todas.

Casos de uso:

- Para todo cuando no quieres preocuparte de la base de datos.
- Prototipos

Ejemplos:

- FaunaDB usa GraphQL
