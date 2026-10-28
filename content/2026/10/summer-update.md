---
title: "Summer 2026 Update"
date: "2026-10-28"
authors:
- name: Matthieu Gouel
  link: https://github.com/matthieugouel
  image: https://github.com/matthieugouel.png
tags:
- update
- season
---

In the [spring update](/blog/2026/06/spring-update/) we closed the feedback loop on both peering and probing. We will be upfront: this summer was quiet. There were no new user-facing features. Almost all of the work went into platform maintenance, making sure the infrastructure is solid enough for the experiments that have started this fall. It is not the most exciting kind of work, but it is the kind that decides whether those experiments produce data we can trust.

<!--more-->

## An outage we should have seen

The most important lesson of the season came from a failure. In July we found that the probing agents hosted on Vultr had been sending probes into the void: a misconfigured BGP static route meant our probing prefixes were never announced, so replies had no way back. The fleet sent around 700 million probes in a week and captured 30 replies. Once fixed, the prefixes became visible from 23 [RIPE RIS](https://ris.ripe.net/) collectors and the replies table went from 30 rows a week to tens of millions every few hours.

The bug itself was simple. What bothered us was that nothing alerted on it.

## Monitoring that actually fires

In the spring we added no-data alerts on the BMP, sFlow, and [Saimiris](https://github.com/nxthdr/saimiris) pipelines. This summer we discovered that several of them could never fire: a label mismatch in the PromQL joins meant the expressions silently matched nothing. In the same vein, [`bird_exporter`](https://github.com/czerwonk/bird_exporter) went blind whenever BIRD restarted (it kept answering with no metrics, which looks exactly like "all sessions up"), and one of our BGP hosts had been unmonitored for almost two weeks because of it.

We fixed each of these, and changed how we write alerts: a new rule is now checked by evaluating its expression against a past moment when the failure it targets actually happened. We also added an alert for a blind exporter, and replaced the single "disk full" alert with a trend-based warning that gives us lead time.

The same pattern showed up in the IP enrichment data. The daily import of IP-to-ASN and geolocation data had been failing since June because an upstream container image moved, and the tables slowly drained until lookups returned empty strings. The job now reports what it loaded, and three alerts cover a failing run, a job that stopped running, and empty data.

## Platform hygiene

The rest of the season was the usual list of things that only matter when they go wrong:

- **Backups.** PostgreSQL holds the data we cannot reconstruct: user identities, prefix leases, probing allocations, and the Matrix server. It had no backup at all. It now has a verified dump procedure, tested by an actual restore.
- **Disk and logs.** Old container images and unbounded logs were slowly filling disks. We added image pruning and log rotation fleet-wide (reclaiming about 47 GB on the core host alone), and reduced the number of Loki streams created on every deploy.
- **Pinned versions.** One routine deploy pulled several months of automatic updates at once and took down two services: recent ClickHouse builds no longer run on our core host's CPU, and Synapse dropped a configuration key we relied on. Both are now pinned, and we documented how to roll back a service to its last good image.
- **A memory leak in the probing agent.** Saimiris cached network senders per source IP without ever releasing them, which pushed one node to the edge of its memory. The cache is now bounded and exposes metrics, and we fixed the IPv6 address configuration that triggered it.
- **Smaller fixes.** [sflow-parser 0.7.0](https://github.com/nxthdr/sflow-parser) fixes a crafted packet that could trigger a huge allocation, the gateways no longer log the database password at startup, and we prepared the IPv4 sessions with Cloudflare at NL-IX.

We also wrote a GDPR erasure runbook, so that requests to delete personal data have a documented and honest answer, including what it means now that backups exist.

## Assisted operations

Much of this debugging was done with Claude in the loop, using the `deploy`, `health-check`, and `rollback` skills from the spring, plus a new `check-alerts` skill that triages what Alertmanager is reporting. One lesson made its way back into the skill: the memory leak above was first classified as a known, benign alert, which is exactly why it stayed hidden for weeks. Known noise is now treated with more suspicion.

## Looking ahead

A quiet season on the surface, then, but a necessary one: the experiments that started this fall run on a platform that tells us when something breaks. More on those in the next update.
