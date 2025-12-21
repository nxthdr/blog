---
title: "Autumn 2025 Update"
date: "2025-12-22"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- season
---

Our main focus this autumn was on creating a non-profit association for nxthdr (see [non-profit creation](/2025/10/non-profit-creation/)). Nonetheless, we did not neglect the development of the platform this autumn, which we will detail here.

<!--more-->

## Developing the self-service peering platform

One of our main goals is to provide a self-service peering platform to our users. The idea is to assign a private AS number to each user and allow them to request one or multiple IPv6 prefixes for a given period of time.

We then provide an easy way for users to connect to our peering infrastructure and announce their assigned prefixes to any of our IXP servers. This enables users to experiment with BGP using a real peering infrastructure connected to the Internet. This is a great way to learn about BGP and peering, but also to conduct interesting experiments that would be hard to do otherwise. We are inspired by the Columbia University [PEERING](https://peering.ee.columbia.edu/) testbed, which has supported many BGP research experiments, but we aim to provide a more user-friendly and self-service experience. In the future, we could also provide a way to announce to probing servers to enable interesting combined probing and peering experiments.

We created a new API, [PeerLab Gateway](https://github.com/nxthdr/peerlab-gateway), which handles user ASN and prefix allocation. It follows the same pattern as [Saimiris Gateway](https://github.com/nxthdr/saimiris-gateway), but is specialized for peering instead of probing. We then have a [cronjob](https://github.com/nxthdr/peerlab-bird-config) that updates the BIRD configuration policy which maps between users, ASNs and prefixes. Finally, we developed the client side, [PeerLab](https://github.com/nxthdr/peerlab), which facilitates the user environment to connect to our peering infrastructure via a Tailscale-like overlay network.

## Refactoring the sFlow pipeline

Our sFlow pipeline, which allows us to get visibility into the traffic flowing through our network, was refactored to use our own sFlow collector, [Pesto](https://github.com/nxthdr/pesto). Previously, we were using [goflow2](https://github.com/netsampler/goflow2) to collect and serialize sFlow data, but we wanted to develop an alternative parser in Rust that would implement not only the main sFlow v5 [RFC](https://sflow.org/sflow_version_5.txt), but also all of the sFlow extensions created afterwards. We found that no parser as complete as we expected existed, let alone in Rust, so we created our own [sflow-parser](https://github.com/nxthdr/sflow-parser) library.

Of course, this work was not in the critical path of the platform, but nxthdr's goal is also to provide open-source tools to the community, similarly to [Saimiris](https://github.com/nxthdr/saimiris) and [Risotto](https://github.com/nxthdr/risotto).
