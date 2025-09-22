---
title: "Genesis of the Project"
date: "2025-01-01"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- infastructure
- AS215011
- updates
---

**nxthdr** and **as215011** are celebrating their first new year! 🎉

This year, I plan to begin sharing blog posts to provide updates on the project, infrastructure changes, software development, and more. However, before diving into those exciting topics, now seems like the perfect opportunity to reflect on the what has been done since the beginning of the project.

<!--more-->

This post focuses solely on the infrastructure aspect of the project, detailing the process of acquiring an ASN, IPv6 prefixes, IX servers, compute servers, and domain names. If you are interested about the costs, you can check the open [bookkeeping](https://docs.google.com/spreadsheets/d/1fguIDaXn4DuEexZrudJjzn2Sucpy8Qx5bACcYEH1ie4/edit?usp=sharing).


## ASN and IPv6 prefixes

**as215011** has been active since April 2024. Initially, I acquired an AS number and two /44 prefixes to explore the administrative and technical requirements involved in managing an ASN. My goal was to gain hands-on experience with RPKI, reverse DNS, and Geofeed configurations, as well as to experiment with the [RIPE Database](https://www.ripe.net/manage-ips-and-asns/db/) or [PeeringDB](https://www.peeringdb.com/).

I used [Securebit](https://www.securebit.ch/) to obtain the ASN and IP space. Securebit is a Swiss company specializing in cloud and networking services, including IX servers through their own IXP [SBIX](https://www.peeringdb.com/ix/3118) or others such as [DE-CIX](https://www.peeringdb.com/ix/31). As a RIPE LIR, they provide IP space and ASNs.

In hindsight, there are probably cheaper LIRs such as [freetransit](https://freetransit.ch/). However, at the time, I opted for Securebit since I intended to use their IX servers as well and preferred to have everything in one place.

The administrative process for obtaining an ASN is relatively straightforward, at least when you are using a sponsoring LIR. Once the ASN is ordered, the LIR will provide an End User Assignment Agreement (EUAA) for you to sign. Additionally, you will need to provide an ID and verify it through a identity verification platform (in my case, it was [iDenfy](https://www.idenfy.com/)).

As far as I know, there’s no requirement to have a mailing address in a country administered by RIPE. However, be aware that this may not be the case for other RIRs, such as [AFRINIC](https://www.afrinic.net/become-member?lang=en-GB), where different rules may apply.

Once the EUAA is signed and the ID verified, the LIR submits the request to RIPE. The process is pretty fast, in my case it took only 3 days to get an email saying:

```
Today, the RIPE NCC assigned the following Autonomous System Number:

AS215011 to Matthieu Gouel
```

Afterward, I updated the RIPE Database mostly with my contact information. I also created a [PeeringDB](https://www.peeringdb.com/) account and linked the [ASN](https://www.peeringdb.com/net/36080) to it.


## IXP servers

Having an ASN and some IPv6 prefixes is pretty cool, but it's even better when you can announce them to the world.
There are several ways to achieve this, the simplest is to use a cloud provider that support BGP sessions. For instance, [Vultr](https://www.vultr.com/) offers free [BGP sessions](https://www.vultr.com/features/bgp/) from their cloud instances.

In this setup, you can announce your prefixes through your ASN (or a private one if you don’t have your own) by peering with Vultr’s transit provider (currently [Constant](https://www.constant.com/)).

Another option is to peer at an Internet Exchange Point (IXP). An IXP is a physical location, typically in or near a data center, where networks can interconnect and exchange traffic. By peering at an IXP, you can easily establish connections with hundreds of networks from a single location.

As mentioned earlier, Securebit offers IX servers in multiple IXPs, making it a convenient choice for those looking to establish such peering arrangements. Unfortunately, Securebit's IXP, SBIX, isn't very popular. As a result, in May 2024, I decided to rent an IX server from [iFog](https://ifog.ch/en/ip/ixp-access) in Frankfurt. This gives me access to [LOCIX](https://www.peeringdb.com/ix/2084) and their own IXP [FogIXP](https://www.peeringdb.com/ix/3756).

There is some additional administrative work required to join an IXP, mainly providing information to iFog such as your ASN, the prefixes you want to announce, your contact details, etc. You’ll also need to prove ownership of your ASN by updating the relevant record in the RIPE database. Once everything is in order, you’ll receive Proxmox credentials to access your VM within a few days.

The VM comes with multiple NICs. One of them is used to establish a session with iFog’s upstream AS, which will provide transit for free. The other NIC(s) connect to the LAN of the IXP(s). From there, you can peer with the IXP route servers, enabling you to connect with most other networks at the exchange. Additionally, you have the possibility to peer directly with other networks participating in the IXP. For instance, I've established direct peering with [Cloudflare](https://www.cloudflare.com/) by using their [Peering Portal](https://peering.cloudflare.com/).

After a few days peering with the LOCIX Route Servers, [Hurricane Electric](https://he.net/) contacted me through the email I had registered on PeeringDB, offering to peer with me. I've asked if they could provide me free transit, to which they agreed. This allowed me to have two distinct upstream providers: one from iFog and another from Hurricane Electric.

In August 2024, colleagues affiliated with the [CNRS](https://www.cnrs.fr/fr) facilitated access to a second iFog IX server, located in Amsterdam, with the understanding that I would maintain it to support research-related activities. Naturally, I accepted, especially considering that the iFog Amsterdam IX server is connected to [NL-IX](https://www.peeringdb.com/ix/64), one of the largest IXPs in Europe.


## Compute server

Now that we have IP addresses, announced via our own ASN, and are peering with several networks from several locations, the next question is: what can we do with all this? We need some services utilizing these IP addresses.

I won't go into the specifics of the project's objectives here -- for this you can check the main page of **nxthdr**. Basically the main goal is to observe the Internet for research and education purposes. To do so, we need services to provide probing capacity, data storage, data analysis, observability, etc.

In May 2024, I've rent a [Scaleway Dedibox](https://www.scaleway.com/fr/dedibox/) type Start-2-M-SSD in Amsterdam. This server is connected to the two IX servers in Frankfurt and Amsterdam via Wireguard tunnels. It originates the BGP sessions to the IX servers and announces the prefixes. The IX servers then propagate these announcements to peers and transit providers.

Currently, there is no redundancy for the compute server. If it goes down, all services will be unavailable, and if it crashes, all data will be lost. At the moment, I am willing to accept this risk, as the collected data is not critical and can be easily re-collected. However, in the future, a second server could be added as a backup, data replication.

To access these services as a user, I purchased two domain names from [Porkbun](https://porkbun.com/): `nxthdr.dev` and `as215011.net`. The AAAA DNS records for these domains point to a reverse proxy running on the compute server. This reverse proxy then forwards incoming requests to the appropriate services hosted on the same server.


## What about IPv4-only users?

At the moment, I don't have any IPv4 addresses, as they are quite expensive. However, it’s relatively inexpensive to rent a VPS with a single IPv4 address and use it as an IPv4-to-IPv6 proxy.

To achieve this, I rented two Scaleway "Stardust" instances (the cheapest option) in Amsterdam and Warsaw. A reverse proxy runs on each IPv4 proxy server, forwarding requests to the compute server. The A record for the domain names points to the IPv4 addresses of these proxy servers.

Since dual-stack configurations generally prioritize IPv6, the additional latency introduced by the proxy servers should not impact them. The [Happy Eyeballs](https://datatracker.ietf.org/doc/html/rfc6555) algorithm, which measures connectivity between IPv4 and IPv6, will most likely prefer the direct IPv6 connection.


## What's next?

In 2024, I focused my time and resources on developping **as215011** network and building the core infrastructure. In 2025, my focus will shift to developing the probing infrastructure to observe the internet through active measurements.
