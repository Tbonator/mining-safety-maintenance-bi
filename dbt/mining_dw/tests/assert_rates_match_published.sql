-- Benchmark test: our national all-injury rate should be within 5% of MSHA's published rate.
-- A bigger gap means our injury definition or our hours differ from MSHA's.
-- Set to warn: small definition differences are expected, but you should know about them.
{{ config(severity='warn') }}

with ours as (

    select
        calendar_year,
        round(sum(injury_count) * 200000.0 / nullif(sum(total_hours_worked), 0), 2) as our_rate
    from {{ ref('fct_national_quarter_safety') }}
    group by 1

)

select
    p.calendar_year,
    p.all_injury_rate                                   as published_rate,
    o.our_rate,
    round(abs(o.our_rate - p.all_injury_rate) / p.all_injury_rate * 100, 1) as pct_difference
from {{ ref('msha_published_rates') }} as p
left join ours as o
    on o.calendar_year = p.calendar_year
where o.our_rate is null
   or abs(o.our_rate - p.all_injury_rate) / p.all_injury_rate > 0.05