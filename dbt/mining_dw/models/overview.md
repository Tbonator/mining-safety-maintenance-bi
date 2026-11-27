{% docs __overview__ %}
# Mining Safety & Maintenance BI

An end-to-end ELT pipeline on public US mine safety data from the
Mine Safety and Health Administration (MSHA).

**Flow:** MSHA files → Python + dlt → `raw` → dbt `staging` → `intermediate` → `marts` → Power BI and QlikView

| Layer | Schema | Built as | Job |
|---|---|---|---|
| Raw | `raw` | tables (dlt) | Files exactly as downloaded, every column as text |
| Staging | `staging` | views | Rename, cast, clean. One row in, one row out |
| Intermediate | `intermediate` | views | Business rules: severity, injury flags, equipment groups |
| Marts | `marts` | tables | Star schema the dashboards read |
| Snapshots | `snapshots` | tables | SCD Type 2 history of mine ownership |

**Validation:** national all-injury rates are tested against MSHA's published
figures on every run (`assert_rates_match_published`).

Click the blue icon at the bottom right to see the lineage graph.
{% enddocs %}