# [CÓMO Facebook se DESCONECTÓ de INTERNET - RCA REVIEW](https://www.youtube.com/watch?v=FKDr5Mnd6HE)

Internet es una red de redes

Para que los proveedores puedan estar conectados a la red, se usa el protocolo BGP

- BGP, border gateway protocol, es un protocolo que sirve para avisar a las demas redes como llegar a tu red

Tu proveedor de internet y lo hace por ti.

Empresas muy grandes ellos mismo avisan a los servidores de internet como llegar a sus servidores

Cloudflare: notó que Facebook dejó de anunciar las ips de los servidores de DNS.

- DNS, Domain Name System, es un sistema de nombres de dominio, que sirve para resolver nombres de dominio a direcciones IP. Sería como una guía telefónica de internet, traduce nombres a IP. Sirve para no acordarse de las IPs.

Cloudflare guarda una copia de cada actualizaciones BGP, para saber qeu está pasando.
Normalmente no se hacen cambios de esas direcciones ya que esas ips y rutas.

A las 15:40 Facebook empezó a hacer muchas actualizaciones BGP (x250 veces de lo normal) y ahí Facebook se desconectó de internet.

Internamente se calló todo, no podían llegar a los servidores. Por lo que tuvieron que hacer todo sin la red de Facebook y sin los servicios de Facebook, comunicarse por Facetime, Discord y activar protocolos de seguridad.
Otros servicios externos que usan servicios de Facebook, también tuvieron impacto. Como los autologin de Facebook y WhatsApp para empresas.

## [Pablo Gutiérrez del Castillo - Entrevista](https://youtu.be/FKDr5Mnd6HE?t=343)

### Cómo se hace para manejar tus propias rutas a tus servidores

Ellos habilitan el recibir las redes y tu le mandas las rutas de la red, utilizando ASN como intermediario.
Cada uno tienen una whitelist de rutas que quieres enviar y anunciar unas a uno y otras a otro proveedor.

### [Que pasó en Facebook?](https://youtu.be/FKDr5Mnd6HE?t=543)

Ellos cometieron un error cuando propagaron el """DELETE de las rutas""" que hizo que no pudieran arreglarlo remotamente a su router, y tuvieron que hacerlo de otra manera, como fisicamente a los routers.

Facebook sus propios routers, su propio sistema operativo.

hay sistemas que hace backups de las configuraciones de los routers.

Si tu tienes una sesión BGP, tienen un TTL y despues se empiezan a borrar. El router de tu proveedor al no ver la ruta empieza a borrar las rutas.

Asique tambien los proveedores como Cloudflare si no ve la ruta, lo borra solo.

### [¿Que se puede hacer para evitarlo?](https://youtu.be/FKDr5Mnd6HE?t=746)

Ellos tenían sistemas para enviar el delete masivo

Tienen un sistema que audita estas tareas de mantenimiento, y los comandos que realizan sobre los routers estaban auditados por humanos y por un sistema automatico, pero algo pasó. Decían que tenian bug.

Que se puede hacer:

- Code Review
- Documentado, para ejecución ordenada
- Backups

### [Impacto](https://youtu.be/FKDr5Mnd6HE?t=832)

Cloudflare tuvo impacto de consultas masivas de redes de Facebook

Los DNS, iban mas lentos

## ¿Que hacer si usas esos servicios?

- Tener un sitio web, para actualizarlo facilmente lista de RRHH y diferentes contactos.
- Diferentes formas de vender, no solo a traves de WhatsApp.
