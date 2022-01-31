# [dockerCon 17 EU - Taking Docker to production](https://www.youtube.com/watch?v=V4f_sHTzvCI)

## [Legacy apps work in containers too](https://speakerdeck.com/bretfisher/road-to-docker-production-what-you-need-to-know-and-decide?slide=9)

- Microservices conversion is not required
- [12 factor is a horizon we're always chasing](https://12factor.net/)
- Don't let these ideas delay containerization

## Dockerfiles

- [Maturity Model](https://speakerdeck.com/bretfisher/road-to-docker-production-what-you-need-to-know-and-decide?slide=12)
  - start -> not crash
  - logs and all things stdout & stderr
  - documented in file
  - work with others
  - lean -> usa lo que la base que tengas en el proyecto no te vayas a alpine (no lo necesitas en desde el primer día y puede ser que no lo necesites)
  - scale -> que la app puede correr en multiples contenedores al mismo tiempo

## [Dockerfiles: Anti-pattern](https://speakerdeck.com/bretfisher/road-to-docker-production-what-you-need-to-know-and-decide?slide=16)

- Trapping data
  - Define VOLUME for each location
- Using: latest
  - Use specific FROM tags
  - Specify version for critical apt/yum/apk packages
- Leaving Default Config
  - Update default config via ENV, RUN, ENTRYPOINT
- Environment Specific
  - PROBLEM: different config for each environment COPYing at image build
  - SOLUTION: Single Dockerfile with def ENVs and overwrite per environment with ENTRYPOINT script

## Containers-on-VM or Containers-on-Bare-Metal

- Both, evaluarlo en tu caso -> pruebas de performance

## Swarm

## [Outsource well-defined plumbing](https://youtu.be/V4f_sHTzvCI?t=2156)

These will accelerate your project to production

- Image registry
- Logs
- Monitoring and alerting

## [Tech stacks](https://youtu.be/V4f_sHTzvCI?t=2248)

### [Pure Open Source Self-Hosted Tech Stack](https://youtu.be/V4f_sHTzvCI?t=2248)

| Layer              | Tech                         |
| ------------------ | ---------------------------- |
| FaaS               | OpenFaaS                     |
| Swarm GUI          | Portainer                    |
| Central Monitoring | Prometheus + Grafana         |
| Central logging    | ELK                          |
| Layer 7 Proxy      | FlowProxy / Traefik          |
| Registry           | Docker distribution + Portus |
| CI / CD            | Jenkins                      |
| Storage            | REX-Ray                      |
| Networking         | Docker Swarm                 |
| Orchestration      | Docker Swarm                 |
| Storage            | Docker                       |
| HW / OS            | InfraKit / Terraform         |

### [Docker for X: Cheap and Easy Tech Stack](https://youtu.be/V4f_sHTzvCI?t=2386)

| Layer              | Tech                    |
| ------------------ | ----------------------- |
| FaaS               | OpenFaaS                |
| Swarm GUI          | Portainer               |
| Central Monitoring | Librato / Sysdig        |
| Central logging    | Docker for AWS or Azure |
| Layer 7 Proxy      | FlowProxy / Traefik     |
| Registry           | Docker Hub / Quay       |
| CI / CD            | Codeship / TravisCI     |
| Storage            | REX-Ray                 |
| Networking         | Docker Swarm            |
| Orchestration      | Docker Swarm            |
| Storage            | Docker                  |
| HW / OS            | Docker for AWS or Azure |

### [Docker EE + Docker for X](https://youtu.be/V4f_sHTzvCI?t=2386)

| Layer              | Tech                    |
| ------------------ | ----------------------- |
| FaaS               | OpenFaaS                |
| Swarm GUI          | Docker EE (UCP)         |
| Central Monitoring | Librato / Sysdig        |
| Central logging    | Docker for AWS or Azure |
| Layer 7 Proxy      | Docker EE (UCP)         |
| Registry           | Docker EE (DTR)         |
| CI / CD            | Codeship / TravisCI     |
| Storage            | REX-Ray                 |
| Networking         | Docker Swarm            |
| Orchestration      | Docker Swarm            |
| Storage            | Docker EE               |
| HW / OS            | Docker for AWS or Azure |
