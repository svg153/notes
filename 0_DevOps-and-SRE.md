# DevOps and SRE

- [Google SRE: Site Reliability Engineering at a Global Scale](https://thenewstack.io/google-sre-site-reliability-engineering-at-a-global-scale/)

When DevOps was coined around 2009, its purpose was to break down silos between development and IT operations.

Site reliably engineering balancer between the Reliability needs and the devs velocity goals.

The SRE team has emerged as the answer to how you can build systems at scale, striking that balance between velocity, maintainability and efficiency.

Google [DORA metrics](https://thenewstack.io/googles-formula-for-elite-devops-performance/).

> **SRE’s mission: reliability, velocity, maintainability and efficiency** Dr. Christof Leng

[Dr. Jennifer Petoff](https://sre.google/sre-book/table-of-contents/), Google’s director of SRE education and co-author of the original [SRE O’Reilly guide](https://sre.google/sre-book/table-of-contents/).

The day-to-day production responsibly rests with the SRE team, ultimately the uptime and availability buck stops with the dev team.

> _Responsibility for having a reliable service is not off-loaded onto the SRE or thrown over the fence. SRE’s job is to help the dev team meet their reliability and velocity goals and to meet the needs of our users first and foremost_. Dr. Jennifer Petoff

SREs can only work on what they can do significantly more efficiently than anyone else. If devs can do it, that should remain a dev headcount.

The [Google SRE Engagement Model](https://sre.google/sre-book/evolving-sre-engagement-model/) concerns production only, which includes:

- System architecture and inter-service dependencies
- Instrumentation, metrics and monitoring
- Emergency response
- Capacity planning
- Change management
- Performance — availability, latency and efficiency

> _SRE is not to be the ops team. Our mission is not to handle operations, but to improve inherent reliability of systems through engineering_. Dr. Jennifer Petoff

SRE mission: **The SRE team aims to reduce the ops workload by answering what broke, how to fix it, and then how to make sure it’s fixed for good.**

For SREs, there’s always more work to do than there is time, so all their work should have a clear scope.

Standardization reduce cognitive load.

**SRE as a production teacher**.

SREs are most effective if they join a development team early on, bringing reliability along as you [shift left](https://thenewstack.io/the-great-shift-left-what-changes-for-developers-and-security-teams/).

SLOs from the start of the project, because from the start the architecture already chosen should scale to the expected number of nines.

SRE engagement, can be scaled up or down over time, but that isn’t needed for all services. Christof Leng groups:

- Baseline support — tactical and reactive ad-hoc support like office hours or consulting projects, where the developers execute based on advice received, or as part of the incident response team in larger-scale outages
- Assisted engagement — SRE provides strategic, proactive, product-focused consultancy, with a dedicated SRE point of contact and a shared production roadmap; this can be an SRE temporarily embedded on a dev team for a critical product where an SRE can be a force multiplier
- Full support — SRE is the effective owner of production, does on-call rotations to solve less obvious and complex production problems — the goal is the SRE to automate themselves out of a job in 18 months.

## incident management

Don’t be a hero, don’t be a constant firefighter

> _Whatever you do, remember that heroics are not sustainable. You can’t firefight production forever. Neither can you work day and night, it’s not sustainable. Solve the problem through smart engineering, not brute force._ Dr. Jennifer Petoff.

## Conclusions / Ideas

> **_United you stand. Divided you fall._**
