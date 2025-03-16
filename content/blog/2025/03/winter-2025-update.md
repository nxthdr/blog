---
title: "Winter 2025 Update"
date: "2025-03-20"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- infrastructure
- saimiris
- prowl
---

In this earlier [post](/blog/2025/01/genesis-infrastructure/), I talked about the origins of the **nxthdr** and **as215011** projects, laying the groundwork for what I focused on throughout 2024. Moving into 2025, I plan to share updates more regularly--aiming for quarterly posts at the end of each season. This is the winter update.

<!--more-->

My primary focus was on building the probing platform. One of the core goals of **nxthdr** is to provide an active measurements platform accessible to everyone. Data collected from both regular measurements and ad-hoc experiments are shared openly, without restrictions, delays, or authentication, and with a permissive license.

The probing servers are deployed worldwide using [Vultr](https://www.vultr.com/) instances. Vultr provides a BGP [feature](https://www.vultr.com/features/bgp/) that allows users to bring their own AS, and its instances are relatively affordable. I allocated one **as215011** /44 prefix to the probing platform, with probing servers announcing sub-prefixes to enable both source anycast and unicast capabilities.

All the Ansible playbooks and BIRD configuration files used to deploy the servers are available in the [infrastructure](https://github.com/nxthdr/infrastructure) repository.

Once the infrastructure was in place, I shifted my focus to developing the software side of the probing pipeline. [Saimiris](https://github.com/nxthdr/saimiris) provides a simple interface for running probes and collecting results. Its *client* component enables users to send [caracat](https://github.com/maxmouchet/caracat) probes to one or more agents with the probes being published to a dedicated [Redpanda](https://www.redpanda.com/) topic for each probing agent.

The *agent* component, running on the probing servers, listens to its assigned Kafka topic and executes the probes. Responses are then sent to a common Kafka topic and subsequently stored in a [ClickHouse](https://clickhouse.com/) database.

While probe generation can be done with any script, I developed [prowl](https://github.com/nxthdr/prowl), a Python library that simplifies the process of generating probes for common use cases such as ping and traceroute.

## Experiment

To validate the platform’s early design, I conducted a proof of concept experiment. This experiment involves sending three ICMP pings from an anycast source address to approximately 7.2 million /48 IPv6 prefixes discovered by Rye and Levin in their ACM SIGCOMM 2023 [paper](https://v6-research.cs.umd.edu/papers/v6_sigcomm23.pdf).

Probing at a rate of 10,000 packets per second from two Vultr instances (Paris and Atlanta) took roughly 40 minutes. You can view the per-minute number of replies in this [dashboard](https://grafana.nxthdr.dev/d/defi1poeecykgf/saimiris?orgId=2&from=2025-03-13T08:23:08.228Z&to=2025-03-13T09:05:59.573Z&timezone=browser).

Finally, you can access the results of this experiment through the ClickHouse proxy. All data is shared under the Open Database License (ODbL). However, due to the current 7-day data retention policy, the specific data from this experiment may no longer be available. In the future, I plan to conduct regular experiments like this and retain certain datasets for longer periods.

For fun, we can reimplement the [anycatch](https://github.com/benjojo/AnyCatch) technique to discover anycast prefixes. The query returns prefixes where we get replies from the two agents:

```sh
echo """
  SELECT DISTINCT toIPv6(cutIPv6(reply_src_addr, 10, 1)) AS anycast_prefix
  FROM
  (
      SELECT
          reply_src_addr,
          length(groupUniqArray(agent_id)) AS n_agents
      FROM saimiris.results
      WHERE (timestamp > toDateTime('2025-03-13 08:25:00')) AND (timestamp < toDateTime('2025-03-13 09:05:00'))
      AND (reply_icmp_type = 129) AND (reply_icmp_code = 0)
      GROUP BY reply_src_addr
  )
  WHERE n_agents > 1
     """ | curl 'https://clickhouse.nxthdr.dev/?user=read&password=read' \
          --data-binary @-
```


At the time of writing, the result of this query was:

```
2606:4700:4700::
2606:4700:f1::
2409::
2a0d:2a00:1::
2a09:8280:70::
2001:19f0:ffff::
2a02:ed3:400::
2a02:ed3:5e0::
2a09:8280:16::
2a0b:e42:1::
2a03:2800:500::
2a09:8280:13::
2a10:a8c0:12b::
2402:cf80:107::
2001:4860:4806::
2a06:1700:100::
2607:f740:e04a::
2a0d:7c40:3000::
2804:7918::
2a10:7180:100::
2001:558:1049::
2602:fed2:7021::
2a10:a8c0:1::
2a02:fe80:1010::
```
