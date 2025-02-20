---
title: nxthdr
toc: false
---

**nxthdr**, pronounced /ˈnɛkst ˈhɛdə˞/ or simply "Next Header", is an initiative to offer metrology capabilities to researchers and students to study and learn about the Internet.

It integrates high-speed probing capabilities with self-service[^1] peering control, offering the community a unique platform. **nxthdr** enables Internet-scale route tracing while managing and collecting BGP advertisements from diverse vantage points and multiple IXPs, powered by [**as215011**](/as215011).

Every aspect of **nxthdr** is open and transparent:
* The [infrastructure](https://github.com/nxthdr/infrastructure) is managed entirely as open-source code.
* The [data]() collected is freely accessible[^1], with no restrictions or need for justification.
* The [tools](https://github.com/nxthdr) powering the platform are all open-source, such as [risotto](https://github.com/nxthdr/risotto) and [saimiris](https://github.com/nxthdr/saimiris).
* The [roadmap](https://github.com/orgs/nxthdr/projects/1) of the project is public and participatory, inviting ideas and contributions.
* The [bookkeeping](https://github.com/nxthdr/bookkeeping) is complete and publicly available.


## Flagship Projects

### Risotto

[risotto](https://github.com/nxthdr/risotto) is a BGP Monitoring Protocol (BMP) collector. Each **as215011** router sends BMP messages to risotto, which stores the updates in a ClickHouse database. By maintaining a state, risotto ensures accurate and comprehensive BGP data, which is made freely available to the community for analysis.

### Saimiris

[saimiris](https://github.com/nxthdr/saimiris) is a high-speed probing platform that provides the essential plumbing for users to perform traceroute-like and ping-like measurements from multiple vantage points. The results are stored in a ClickHouse database and made available to the community for analysis.
At its core, saimiris leverages [caracat](https://github.com/maxmouchet/caracat), a high-speed ICMP/UDP IPv4/v6 probing library. This library serves as the foundation for reimplementing powerful tools such as [yarrp](https://github.com/cmand/yarrp) and [zmap](https://github.com/zmap/zmap).


## Get Involved

Join us on [Discord](https://discord.gg/KRsVs7jafg) to discuss the project and get involved!


[^1]: Under [construction](https://github.com/nxthdr/roadmap/issues/12). Stay tuned!