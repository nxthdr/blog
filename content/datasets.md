---
title: Datasets
toc: false
---

The datasets are accessible from ClickHouse using our HTTP proxy. In the future, we might offer other ways to access the data.

> All data produced by **nxthdr** and **as215011** are publicly available and freely usable under [Open Data Commons Open Database License (ODbL)](https://opendatacommons.org/licenses/odbl/).

Here is a working example you can try in your terminal:

```sh
echo """
     WITH concat(prefix_addr, '/', prefix_len) AS prefix
     SELECT prefix,
            max(length(communities)) AS n_communities
     FROM bmp.updates
     GROUP BY prefix
     ORDER BY n_communities DESC
     LIMIT 5 FORMAT PRETTY
     """ | curl 'https://clickhouse.nxthdr.dev/?user=read&password=read' \
          --data-binary @-
```

```
   ┏━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
   ┃ PREFIX             ┃ n_communities ┃
   ┡━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
1. │ 2804:3018::/32     │           107 │
   ├────────────────────┼───────────────┤
2. │ 2804:c70:2000::/36 │           105 │
   ├────────────────────┼───────────────┤
3. │ 2804:c70:1000::/36 │           105 │
   ├────────────────────┼───────────────┤
4. │ 2804:42e0::/32     │           105 │
   ├────────────────────┼───────────────┤
5. │ 2804:c70:3000::/36 │           105 │
   └────────────────────┴───────────────┘
```

We use a basic username/password authentication to access the data. This is solely to prevent automated scraping, but the credentials are public and can be freely shared.

user: `read`
password: `read`


## Raw Peering Dataset

The raw peering dataset is available in the `bmp.updates` table. The schema is described in our [infrastrcture](https://github.com/nxthdr/infrastructure/blob/main/clickhouse-tables/bmp/bmp.sql) repository.

Each router of **as215011** sends BMP messages to [risotto](https://github.com/nxthdr/risotto), which records the updates in a ClickHouse database.

Each raw corresponds to an update or a withdraw, capturing prefixes, AS paths, communities, and other attributes.


## Raw Probing Dataset

The raw probing dataset is available in the `saimiris.results` table. The schema is described in our [infrastructure](https://github.com/nxthdr/infrastructure/blob/main/clickhouse-tables/saimiris/saimiris.sql) repository.

Active measurements using [saimiris](https://github.com/nxthdr/saimiris), whether scheduled via cron jobs or performed on demand, are stored in a ClickHouse database. This data consists of traceroute-like and ping-like measurement results collected from multiple vantage points.

Each row corresponds to a measurement result, capturing the source and destination IP addresses of the sent packet, the reply, the hop count, and other relevant attributes.
