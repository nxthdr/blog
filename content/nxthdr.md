---
title: nxthdr
toc: false
---

**nxthdr**, pronounced /ˈnɛkst ˈhɛdə˞/ or simply "Next Header", is an initiative to offer metrology capabilities to researchers and students to study and learn about the Internet.

It integrates high-speed probing capabilities together with peering control, offering the community a unique platform. **nxthdr** enables Internet-scale route tracing while managing and collecting BGP advertisements from diverse vantage points and multiple IXPs, powered by [**as215011**](/as215011).

At the moment, **nxthdr** is in its early stages, with the infrastructure being built rapidly. It's not yet possible for users to their own measurements[^1] from the platform nor change its BGP configuration[^2], but this is a priority for the project.

Nonetheless, you can already access the data collected by **nxthdr** in the [datasets](/datasets) section.

## Openness

Every aspect of **nxthdr** is open, transparent and participatory:

* The [datasets](/datasets) collected is freely accessible under [ODbL](https://opendatacommons.org/licenses/odbl/) license, with no restrictions, authentication, or need for justification.
* The [tools](https://github.com/nxthdr) powering the platform are all open-source, such as [risotto](https://github.com/nxthdr/risotto) and [saimiris](https://github.com/nxthdr/saimiris). You can use them, contribute to them, or even run your own instance.
* The [infrastructure](https://github.com/nxthdr/infrastructure) is managed entirely as open-source code. You can see the configuration of the servers and routers, the services running, the monitoring setup, the database tables and more. You can make suggestions or improvements by opening an issue or a pull request.
* The [observability](https://grafana.nxthdr.dev) is public, with Grafana dashboards providing real-time insights into the platform's health. It also ease the debugging and troubleshooting communication in case of issues.
* The [roadmap](https://github.com/orgs/nxthdr/projects/1) of the project is public and participatory, inviting ideas and contributions. The roadmap is updated regularly to reflect the current state of the project. Feel free to open issues to suggest new features or improvements.
* The [bookkeeping](https://github.com/nxthdr/bookkeeping) is complete and publicly available. It includes the financial transactions, the donations received and the budget forecast. The bookkeeping is currently updated annually.

## Flagship Projects

### Risotto

[risotto](https://github.com/nxthdr/risotto) is a BGP Monitoring Protocol (BMP) collector. Each **as215011** router sends BMP messages to risotto, which stores the updates in a ClickHouse database. By maintaining a state, risotto ensures accurate and comprehensive BGP data, which is made freely available to the community for analysis.

### Saimiris

[saimiris](https://github.com/nxthdr/saimiris) is a high-speed probing platform that provides the essential plumbing for users to perform traceroute-like and ping-like measurements from multiple vantage points. The results are stored in a ClickHouse database and made available to the community for analysis.
At its core, saimiris leverages [caracat](https://github.com/maxmouchet/caracat), a high-speed ICMP/UDP IPv4/v6 probing library. This library serves as the foundation for reimplementing powerful tools such as [yarrp](https://github.com/cmand/yarrp) and [zmap](https://github.com/zmap/zmap).


## Get Involved

Join us on [Discord](https://discord.gg/KRsVs7jafg) to discuss the project and get involved!


[^1]: Self-service active measurements ([roadmap](https://github.com/nxthdr/roadmap/issues/13))
[^2]: Self-service BGP configuation ([roadmap](https://github.com/nxthdr/roadmap/issues/12))
