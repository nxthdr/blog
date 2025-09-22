---
title: "Alpha of the Probing Platform"
date: "2025-07-08"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- announcement
- probing-platform
---

The **nxthdr** probing platform has reached an important milestone: it is now in **alpha**! Early adopters can start using it for free.

<!--more-->

You may ask: why another measurement platform? After all, we already have excellent initiatives like RIPE Atlas, CAIDA Ark, and M-Lab.
The answer is that nxthdr fills gaps left open by existing efforts:

- **Peering and active measurements together**: integrating both makes it correct and easy to correlate and analyze datasets in one place.
- **Native support for anycast measurements**: because we control both the vantage points and their source addresses, running anycast experiments is finally possible.
- **Freedom in probe design**: most platforms limit you to predefined measurements (ping, traceroute, etc.). With nxthdr, users decide what probes to send and when, enabling rapid prototyping of new tools and methods.
- **Open, free, and transparent**: measurements are easy to run at no cost, results are placed in the public domain without restrictions or delay, and the entire toolchain is open source.

You can check out a comprehensive comparison of nxthdr with other platforms in the [documentation](https://docs.nxthdr.dev/docs/reference/comparison/).

From a user perspective, the platform is straightforward. After signing up, each user is allocated multiple /80 IPv6 prefixes (IPv4 is not yet supported). More precisely, every vantage point provides two /80 prefixes per user: one for unicast measurements and one for anycast measurements. Probes can then be launched from any vantage point, with results streamed in real time to a ClickHouse database. All data is open: every measurement is public domain and accessible to everyone without authentication.

We allocate such a large address space per user because the source address itself can serve as a measurement ID. This gives users flexibility in how you can structure their experiments: a distinct source address can mark an entire campaign for easier grouping and analysis; separate addresses per vantage point make it straightforward to identify the origin of anycast measurements; and varying the source per destination prefix, or even per individual probe, enables studies of load balancing, path variability, or the behavior of middleboxes.

All of this is already live in alpha. We are now looking for early adopters to try the platform and share feedback. Researchers, network operators, students, and anyone curious about Internet measurement is welcome to sign up for free at [nxthdr.dev](https://nxthdr.dev). You can talk to us about it in our [Discord](https://discord.gg/KRsVs7jafg).

Each account comes with 10,000 probes per day, automatically reset at midnight UTC. Need more? Reach out at [admin@nxthdr.dev](mailto:admin@nxthdr.dev).

## What’s next?

The alpha release is just the beginning, and there are a few [limitations](https://docs.nxthdr.dev/docs/measurements/limitations/) and features we plan to address for the beta release:

- **Expanding probing locations**: currently, there are only two vantage points, as the alpha focuses on proof of concept. Our goal is to provide 30–40 locations worldwide, potentially with multiple vantage points per location, to better scale the platform for more users.
- **TCP probe support**: at the moment, only UDP and ICMPv6 probes are supported. Adding TCP probes will enable a wider range of measurements and use cases.
- **Enhanced tooling and documentation**: while the core functionality is in place, we aim to improve the user experience, documentation, and measurement tooling to make it even easier to design, launch, and analyze experiments.

Of course, we also welcome feedback and suggestions from the community to help shape the platform’s future.
