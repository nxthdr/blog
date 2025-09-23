---
title: "Summer 2025 Update"
date: "2025-09-22"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- season
---

The big news this summer: the **nxthdr** probing platform is now in **alpha**! Early adopters can already start using it for free. Full details are in the [announcement post](https://blog.nxthdr.dev/2025/07/probing-alpha/).

<!--more-->

## Measurement Platform enters Alpha
Since the prober, [Saimiris](https://github.com/nxthdr/saimiris), had matured over the winter and spring, the next step was to create an API layer—the [Saimiris Gateway](https://github.com/nxthdr/saimiris-gateway). It handles user authentication, prefix allocation, and launching measurements. In parallel, I worked on a new version of the [website](https://nxthdr.dev), which now offers user registration, a dashboard to manage measurements, and dynamic documentation to guide users through designing probes and analyzing results.

I also published a static [documentation](https://docs.nxthdr.dev/docs/), which collects all the information needed to understand the network, measurements, datasets, and tools. It’s still a work in progress and will continue to expand over time.

Next steps for the probing platform include adding more vantage points worldwide, supporting TCP probes, and improving the overall user experience with better tooling, examples, and documentation. Feedback and suggestions from the community are especially welcome to help shape the platform’s future.

## Research using the Peering Infrastructure

The more mature peering infrastructure, built on IX servers in Frankfurt and Amsterdam, has been actively used in network research. This summer we gained (at least temporarily) access to a second VM at NL-IX Amsterdam, doubling our presence there. During these experiments, the Frankfurt server ensured stable connectivity between nxthdr services and the Internet.

These first experiments provide valuable insight into how the peering infrastructure should evolve. The long-term vision is to offer a peering platform as a service, where users can request BGP sessions from multiple locations worldwide. For now, management remains manual, but this hands-on phase helps us gain experience, identify challenges, and prioritize future development.

On the BGP observability side, the BGP monitoring collector [Risotto](https://github.com/nxthdr/risotto) has also evolved, with support for additional BGP attributes. This results in more complete datasets available for anyone to analyze. We are now also collecting per-policy BGP updates in addition to post-policy updates, which provides a more detailed view of routing changes.
