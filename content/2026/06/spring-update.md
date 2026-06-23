---
title: "Spring 2026 Update"
date: "2026-06-21"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- season
---

In the [winter update](/blog/2026/03/winter-update/) we brought both the probing and peering platforms to alpha. The most important milestone this spring, though, has nothing to do with code: the project now covers its own running costs. On the technical side, the season's recurring theme was **closing the feedback loop**: not just *can you run an experiment*, but *can you see what happened, trust the result, and act on it*.

<!--more-->

## Funding and partnerships

This was a great season for the sustainability of the project. **École Polytechnique** paid the non-profit for helping run internet-scale experiments, the second such engagement after a first one last December. The amounts are modest, but they are real, recurring, and as always entirely visible in our public [bookkeeping](https://docs.google.com/spreadsheets/d/1ptkRO_R6Jgl1gUEaqihGFT23hSMS3msxBi8uUaS5xFo/edit?usp=sharing). These funds go to the association, and they mark a meaningful milestone: the platform now covers its own running costs and stands on its own.

Even better, we are starting a partnership with the **CNRS** and **École Polytechnique** on a larger research project that should help secure the platform for years to come. There is much more to say about that, and we will, in a future post.

## Closing the feedback loop on peering

On the technical side, the biggest step this spring was giving peering users the tools to validate and observe their own announcements, end to end.

First, **RPKI**. PeerLab now manages Route Origin Authorizations (ROAs) for leased prefixes, and users can toggle Route Origin Validation (ROV) on their sessions. On the gateway side we added ROA caching with warm-up at startup so this stays fast. This means you can experiment with both sides of RPKI, signing your origins and validating what you receive, on real BGP sessions.

Second, **visibility**. Announcing a prefix is only half the story; the other half is finding out whether the rest of the internet actually sees it. The new `ris-visibility` command (and the underlying peering routes/lookup feature) queries public route collectors so you can check, from the same CLI you used to announce a prefix, whether and where it propagated. Together with RPKI, this turns peering from a fire-and-forget action into a proper [feedback loop](https://docs.nxthdr.dev/docs/peering/). These capabilities shipped in the **nxthdr 0.5.0** release.

## Taking control of your measurements

The probing side got the same treatment. Until now you could launch a measurement, but managing it afterwards was awkward. The Saimiris gateway gained a proper measurements API, and the CLI now exposes it: you can **list** your measurements, **filter** and **sort** them, **cancel** ones that are stuck, and export results as **CSV** for analysis. Running an experiment and getting your data back is now a self-service round trip.

## A more coherent CLI

With both platforms growing, the CLI needed to feel like one tool rather than several bolted together. We did a consistency pass adopting a uniform `<group> <resource> <verb>` command structure across auth, credits, probing, and peering, reworked the README around that convention, and added shell completions and `--version`. On the maintenance side, releases now go out through crates.io [Trusted Publishing](https://crates.io/) (OIDC) with a tag-and-version guard and a documented release runbook, so cutting a new version is reliable and reproducible.

## Eyes on the platform

Closing the loop applies to operations too. We want to know something is wrong before a user does. This season we added [BGPalerter](https://github.com/nttgin/BGPalerter) to watch for hijacks and route leaks against our own prefixes, per-session BGP monitoring via [`bird_exporter`](https://github.com/czerwonk/bird_exporter), and no-data alerts on the BMP, sFlow, and Saimiris pipelines so a silent data path raises a flag. Alertmanager is now reachable (behind basic auth) with documented silencing, and we worked through a Docker 27 IP-isolation regression that had been disrupting services until we made the fix permanent in Ansible.

## Deepening AI-in-the-loop development

The winter update mentioned using Claude to triage pull requests. We leaned into that further. Most active repositories now carry a `CLAUDE.md` describing how to work in them, and PRs get an automatic, advisory (never blocking) Claude review on open. On the infrastructure side we wrote dedicated `deploy` and `health-check` skills with safety guardrails, so routine operations are assisted but constrained. The self-service, well-documented, CLI-first design keeps paying off here: the same affordances that let an AI agent run an experiment also let one help us build and operate the platform.

## A self-hosted home for the community

We replaced Discord with a fully self-hosted Matrix stack (Synapse, Matrix Authentication Service, and a Cinny web client), in keeping with the project's open and self-hosted ethos. You can join the conversation at [chat.nxthdr.dev](https://chat.nxthdr.dev).

This spring closed a lot of loops. The summer will be about widening them: more users, more experiments, and steady progress toward beta. Stay tuned.
