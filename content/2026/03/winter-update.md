---
title: "Winter 2025 Update"
date: "2026-03-20"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- season
---

This winter, we focused on securing the future of nxthdr through funding efforts while continuing to push the platform forward on the technical side. With both the probing and peering platforms reaching alpha, nxthdr is taking shape as a **Platform as a Service (PaaS)** for internet measurements.

<!--more-->

## Seeking funding

A significant part of our energy this winter went into applying for external funding. We submitted two applications, one to a national funding program and one to an international one, and we are now waiting for the results. This is an important step for nxthdr, as it would allow us to dedicate more time and resources to the project and accelerate its development.

## The nxthdr CLI

We built a new command-line interface, **nxthdr**, that brings together probing and peering experiments in a single tool. You can check your probing credits, request and revoke IPv6 prefix leases, and interact with the local [PeerLab](https://github.com/nxthdr/peerlab) setup, all from your terminal.

One aspect that genuinely surprised us is how well the CLI works with AI agents. The self-service nature of the PaaS combined with a well-designed CLI means that an AI agent can autonomously set up a peering session, run probes, and retrieve results with minimal human intervention. This dramatically reduces the time and effort required to design and run internet measurement experiments. Compared to the traditional approach of manually provisioning infrastructure, running experiments, and parsing raw data, the difference is striking. It reinforces our belief that nxthdr is a future-proof approach to internet measurements, and AI integration makes that case even stronger.

## PeerLab reaches alpha

The peering platform, [PeerLab](https://github.com/nxthdr/peerlab), has reached alpha state, joining the probing platform at the same maturity level. This milestone means the core workflow, from ASN assignment to prefix leasing and BGP session establishment with real IXPs, is stable enough for early users to experiment with.

## AI-assisted pull request reviews

We started using [Claude](https://www.anthropic.com/claude) to automatically review and respond to pull requests. This is particularly useful for [Renovate](https://github.com/renovatebot/renovate) PRs, which regularly bump dependencies and sometimes introduce breaking changes that require careful attention. Having Claude triage and comment on these saves us meaningful time and helps us catch issues we might otherwise miss in a routine dependency update.

## Documentation

For a self-service platform, documentation is not optional. We invested heavily this winter in writing comprehensive documentation, now available at [docs.nxthdr.dev](https://docs.nxthdr.dev/docs/). It covers the probing and peering workflows, the CLI, the APIs, and the underlying infrastructure. Good documentation is what allows users and AI agents alike to interact with the platform independently, and we see it as a core part of the product.
