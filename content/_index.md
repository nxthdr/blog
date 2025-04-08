---
toc: false
---

<div class="hx-mt-6 hx-mb-6" style="text-align: center;">
{{< hextra/hero-headline >}}
A Wide-Open Window to the Internet
{{< /hextra/hero-headline >}}

{{< hextra/hero-subtitle >}}
Internet Measurements — Open, Ethical, and For Everyone
{{< /hextra/hero-subtitle >}}
</div>

**nxthdr**, pronounced /ˈnɛkst ˈhɛdə˞/ or simply "Next Header", is an initiative to offer metrology capabilities to researchers and students to study and learn about the Internet.

It integrates high-speed probing capabilities together with peering control, offering the community a unique platform. The **nxthdr** [infrastructure](/infrastructure) enables Internet-scale route tracing while managing and collecting BGP advertisements from diverse vantage points and multiple IXPs, powered by the **as215011** [network](/as215011).

> [!IMPORTANT]
> Currently, **nxthdr** is in its early stages and not yet open to the public for experiments.
> However, the [datasets](/datasets) collected are already accessible.


## Flagship Projects

### Peering Platform

The peering platform is built around an autonomous system, **as215011**, which advertises multiple IPv6 prefixes. This network is designed to support researchers and students in conducting Internet-scale experiments on routing and peering. See the [**as215011**](/as215011) page for more information.

BGP data is collected using [risotto](https://github.com/nxthdr/risotto) BGP Monitoring Protocol (BMP) collector. Each **as215011** router sends BMP messages to risotto, which stores the updates in a ClickHouse database. By maintaining a state, risotto ensures accurate and comprehensive BGP data, which is made freely [available](/datasets) to everyone for analysis.

### Probing Platform

The probing platform consists of multiple servers distributed worldwide. These servers can perform high-speed traceroute-like and ping-like measurements. They advertise **as215011** IPv6 prefixes, allowing measurements using both source unicast and anycast addresses.

[saimiris](https://github.com/nxthdr/saimiris) is a high-speed probing pipeline that provides the essential plumbing for users to perform active measurements from the probing servers. The measurements results are stored in a ClickHouse database and made freely [available](/datasets) to everyone for analysis.

## Values

Every aspect of **nxthdr** is open, transparent and participatory:

* The [datasets](/datasets) collected is freely accessible under [ODbL](https://opendatacommons.org/licenses/odbl/) license, with no restrictions, delay, authentication, or need for justification.
* The [tools](https://github.com/nxthdr) powering the platform are all open-source, such as [risotto](https://github.com/nxthdr/risotto) and [saimiris](https://github.com/nxthdr/saimiris). You can use them, contribute to them, or even run your own instance.
* The [infrastructure](https://github.com/nxthdr/infrastructure) is managed entirely as open-source code. You can see the configuration of the servers and routers, the services running, the monitoring setup, the database tables and more. You can make suggestions or improvements by opening an issue or a pull request.
* The [observability](https://grafana.nxthdr.dev/dashboards) is public, with Grafana dashboards providing real-time insights into the platform's health. It also ease the debugging and troubleshooting communication in case of issues.
* The [roadmap](https://github.com/orgs/nxthdr/projects/1) of the project is public and participatory, inviting ideas and contributions. The roadmap is updated regularly to reflect the current state of the project. Feel free to open issues to suggest new features or improvements.
* The [bookkeeping](https://docs.google.com/spreadsheets/d/1fguIDaXn4DuEexZrudJjzn2Sucpy8Qx5bACcYEH1ie4/edit?usp=sharing) is complete and publicly available. It includes the financial transactions, the donations received and the budget forecast.


## Get Involved

Join us on [Discord](https://discord.gg/KRsVs7jafg) to discuss the project and get involved!
