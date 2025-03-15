---
title: Infrastructure
toc: false
---


This page offers an overview of the **nxthdr** platform's infrastructure, outlining its key components and progressively building a complete picture of the system. The infrastructure is managed as code and is open-source, accessible in the [infrastructure](https://github.com/nxthdr/infrastructure) repository.


## Core Server

![nxthdr_infrastrcture](infrastructure/core.png)

All essential **nxthdr** services run on the core server, a [Scaleway](https://www.scaleway.com/en/dedibox/) Dedibox bare-metal server located in Amsterdam, Netherlands. **nxthdr** relies on various key components, including ClickHouse and PostgreSQL for databases, Redpanda for data streaming, and Prometheus, Loki, and Grafana for observability. These are examples of the technologies currently in use, and they may evolve as the platform grows.

All services are managed using [Docker](https://www.docker.com/). We utilize two Docker networks. The *backend* network is internal and not accessible from the internet, facilitating communication between services. The *dmz* network is internet-facing and used by a [Caddy](https://caddyserver.com/) HTTPS reverse proxy to route traffic to backend services. Some non-HTTPS services also have an interface in the dmz network.

Currently, there is no redundancy for the core server, but regular backups of service data are performed.


## IXP Servers and IPv4 Proxy

![nxthdr_infrastrcture](infrastructure/core-ixp.png)

The core server has direct IPv4/IPv6 connectivity through Scaleway. However, we also operate the **as215011** networks networks to enable Internet-scale peering and routing experiments. As a result, we use **as215011** as an entry point to **nxthdr**, allowing us to dogfood our own network.

Currently, **as215011** routers are located in Frankfurt, Germany, and Amsterdam, Netherlands, connected to multiple IXPs. In addition, each router is connected to the core server via a WireGuard tunnel. The routers announce the prefix `2a06:de00:50::/44` which is used only for **nxthdr** core infrastructure. More precisely, the core server initially announces the prefix to each IXP router.

The current limitation of **as215011** is that it is IPv6-only. To address this, we use an "IPv4 proxy server"--a [Scaleway](https://www.scaleway.com/en/) cloud instance with a public IPv4 address. This server proxies IPv4 traffic to the IPv6-only core server through a [Caddy](https://caddyserver.com/) reverse proxy. All **nxthdr** domains have both A and AAAA records: the A records point to the IPv4 proxy server, and the AAAA records point directly to the core server.


## Probing Servers

![nxthdr_infrastrcture](infrastructure/core-ixp-probing.png)

Finally, we manage probing servers used for active measurements. These servers are [Vultr](https://www.vultr.com/) instances located in multiple locations worldwide. They run a [saimiris](https://github.com/nxthdr/saimiris) probing agent. These servers rely on the core server to function, as it manages and stores the data (probes and results) using Redpanda and ClickHouse.

The probing servers also advertise the prefix `2a0e:97c0:8a0::/44`, which is dedicated to the **nxthdr** probing infrastructure. This enables measurements using source unicast and anycast addresses managed by **as215011**. As with other parts of the network, the limitation is that it is IPv6-only. However, if measurements need to be performed from IPv4-only networks, the server's IPv4 address can possibly be used.
