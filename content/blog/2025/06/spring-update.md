---
title: "Spring 2025 Update"
date: "2025-06-21"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- season
---

Welcome to the spring update for **nxthdr**. As mentioned in the [winter update](/blog/2025/03/winter-update/), I'm continuing with quarterly posts to share progress. This season has seen a lot of foundational work across the board, focusing on improving our software components, enhancing observability, and streamlining infrastructure.

<!--more-->

The primary efforts this spring were geared towards maturing the existing systems and ensuring they are reliable and maintainable.

## Risotto Enhancements
Significant improvements were made to **Risotto**, our BGP monitoring tool. The codebase was refactored by separating the library and application components, which enhances modularity. I addressed a BMP parsing error that was causing high CPU usage and integrated [Cap'n Proto](https://capnproto.org/) for more efficient data serialization. The previous API was removed and I implemented better metrics for monitoring Risotto's performance and health. I now consider Risotto stable, and can be used by anyone interested in BGP monitoring using the BMP protocol.

## Saimiris Developments
The probing pipeline, **Saimiris**, has been developed significantly. Regular measurements are now being performed using the IPv6 hitlist, which also allows me to benchmark Saimiris's reliability and ensure consistent performance. I have also extended the set of features, particularly by allowing multiple prober instances to be set on the agent in order to probe from multiple source addresses. In the same way as Risotto, Prometheus metrics have been added for the Saimiris agent and Cap'n Proto has been adopted, aligning our data formats across components.

## Observability Overhaul
A major focus this season was on bolstering our observability stack. Right now, I'm alone maintaining the platform and ensuring that it's doing a safe and consistent job. Therefore, I've extended the host, Docker, and application metrics across all the servers to remove blind spots. The same goes for logging of Docker containers and syslog, which are now pushed to Loki from all servers. Grafana [Alloy](https://grafana.com/docs/alloy/latest/) is a great help in doing that, and is now installed on all servers as a Docker container. I also implemented a new *Traffic* pipeline using [Goflow2](https://github.com/netsampler/goflow2) to collect and analyse traffic data from all servers. This data is stored in ClickHouse and can be fetched through the ClickHouse proxy by anyone as with any other dataset.

## Infrastructure Automation
On the infrastructure front, I've continued to automate and stabilize our deployments. The installation of a new IXP server at NL-IX Amsterdam was completed and gave me the opportunity to improve server deployment automation. The same goes for probing servers, which are now easily deployable. Automation work is important to allow me to manage the infrastructure alone without spending too much time on it. But working on the automation itself can be time-consuming, so that's a compromise. My strategy is to improve the automation gradually when a new use-case arises.

This spring has been about strengthening the core components and observability of the **nxthdr** platform. These improvements lay a solid foundation for the next phase of development and the introduction of new features. Stay tuned for the summer update!

