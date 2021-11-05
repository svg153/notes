# [Deliveritis Aguda | Carlos Buenosvinos](https://www.youtube.com/watch?v=vGCowJY5QCQ)

la responsabilidad de un CTO, CEO, es ganar pasta. Luego le metes la coletilla de la CXX pero es ganar pasta

Para ganar pasta lo mejor es sacar mas cosas a producción, deliveritis aguda.

Obsesionarse por subir la feature / US / task a producción lo antes posible.

5 tips:

1. Definition of done: las tareas no estan acabadas hasta que no estan subidas a produccion y un usuario las puede ver, tocar, etc...

1. Estrategia de control de versiones:

- Con pequeños, Truck con feature toggles, En grandes con auditoria y demas puede tener mas sentido eso.
- minimizar el numero de ramas que creamos por funcionalidad -> quitas desperdicio
- Ventajas de tener equipos localizados vs deslocalizados y opensource

1. Elegidos para deployar:

- "Si eres valiente para escribir codigo que va a producción también lo eres para subir a producción"

  - El primer dia que vengas haces deploy a prod
  - No es un auto heroico, nada de gatekeepers
  - automatización y testing la base

- Optimizar las US:
  - Los devs somos responsables de identificar dentro de la US y los req que pide, cuanto va a costar cada parte (las "florituras")
  - Tips:
    - Casos A y Caso B
    - Todos vs parte de los usuarios
    - Todos vs parte de la plataforma

1. one click deploy y rollback:

- Puede tardar 15 min maximo
- Deploy hasta de un junior el primer día, si no lo hace, es problema del proceso y no de la persona...
- Deploy automatizado sencillo y evaluar si es necesario meterte en kubernetes y demas, en funcion de como este la empresa los productos
  - **No dejarse llevar por el hype**
- equipos pequeños que no req mucho hype, ni infra.
- Equilibrar en función de como estan la empresa, en que fase. Va a determinar el estilo de juego.
  - No es lo mismo el equipo de 3º que el equipo de champions
    - Cuando estas en startup que no esta validado el modelo de negocio, no empezar con microservicios, _Do not worry be happy_
      - Ya llegará Markert fit, ya entrara dinero y se hará bien

> _No soy un loser por no hacer microservicios, yo maximizar el rendimiento para ganar pasta._

1. Cuellos de botella

- QA sin QAs
  - La gente con un QA se releja
  - Crosstesting
  - Se amplia conocimiento y se empiezan ha hacer cosas nuevas
- SM sin SMs
- Arquitectura sin arquitectos
  > _La arquitectura es un disciplina que vive en los developers_
- Todos en el equipo atacan y todos defienden
  > _Todas las disciplinas (skills) necesarias viven en el equipo, pero no en personas concretas_

1. Atacar el sprint

El maximo de **gente posible sin que se moleste** atacando el sprint de arriba a abajo dado que está priorizado.

- Si le preguntas a un PO, una menos de la necesaria. Por tanto, si dicen 2 -> 3

Standup:

- Ayudar a las us de maxima prioridad

1. RETROs

- Como trabajamos mejor de cara a la delivery.
- ¿Como subimos a prod mas rapido, mas frecuente y de mayor calidad?

Delivery First es una actitud

Como CTOs, sois responsables de liderar con el ejemplo poniendo el foco en el delivery y no en la tecnologia.

## Otras

what if metodologia

- clientes que respondan a modelos face de delivery continua... cliente fake / Cliente VIP --> dando ventajas por ser el VIP que hace de conejillo

Si solo te guias por un cliente acabas cayendo en ese solo...
Tener una vision diferente para qeu no este sesgado,

XP ---> CI, TDD, Coding standards, collective owner acceptant test....

Codigo desacoplado, estrategia de control de versiones sencillo...

> _No entregar lo que el cliente te pide si no lo que te necesita_
