-- One row per mine and calendar quarter: operator hours worked plus accident counts.
-- hours_worked is the mine OPERATOR's hours only. MSHA publishes contractor hours
-- nationally, not per mine. So per-mine rates must use the operator_ counts:
--   operator injury rate = operator_injury_count x 200,000 / hours_worked
-- The all-injury counts (operator + contractor) are kept for totals and reconciliation.
-- Always sum both sides first, then divide. Never average a rate.

with hours as (

    select * from {{ ref('int_employment__mine_quarter') }}
    where calendar_year is not null
      and calendar_quarter is not null

),

accidents as (

    select
        mine_id,
        calendar_year,
        calendar_quarter,
        count(*)                                     as accident_count,
        count(*) filter (where is_injury)            as injury_count,
        count(*) filter (where is_nfdl_injury)       as nfdl_injury_count,
        count(*) filter (where is_fatal)             as fatality_count,
        count(*) filter (where is_injury and not is_contractor_injury)      as operator_injury_count,
        count(*) filter (where is_nfdl_injury and not is_contractor_injury) as operator_nfdl_injury_count,
        count(*) filter (where is_fatal and not is_contractor_injury)       as operator_fatality_count,
        sum(days_lost)                               as days_lost
    from {{ ref('fct_accidents') }}
    where calendar_year is not null
      and calendar_quarter is not null
    group by 1, 2, 3

),

joined as (

    select
        coalesce(h.mine_id, a.mine_id)                     as mine_id,
        coalesce(h.calendar_year, a.calendar_year)         as calendar_year,
        coalesce(h.calendar_quarter, a.calendar_quarter)   as calendar_quarter,
        coalesce(h.hours_worked, 0)                        as hours_worked,
        coalesce(h.avg_employee_count, 0)                  as avg_employee_count,
        coalesce(h.coal_production_tons, 0)                as coal_production_tons,
        coalesce(a.accident_count, 0)                      as accident_count,
        coalesce(a.injury_count, 0)                        as injury_count,
        coalesce(a.nfdl_injury_count, 0)                   as nfdl_injury_count,
        coalesce(a.fatality_count, 0)                      as fatality_count,
        coalesce(a.operator_injury_count, 0)               as operator_injury_count,
        coalesce(a.operator_nfdl_injury_count, 0)          as operator_nfdl_injury_count,
        coalesce(a.operator_fatality_count, 0)             as operator_fatality_count,
        coalesce(a.days_lost, 0)                           as days_lost,
        h.mine_id is not null                              as has_hours_reported
    from hours as h
    full outer join accidents as a
        on  h.mine_id          = a.mine_id
        and h.calendar_year    = a.calendar_year
        and h.calendar_quarter = a.calendar_quarter

)

select
    *,
    cast(to_char(make_date(calendar_year, (calendar_quarter - 1) * 3 + 1, 1), 'YYYYMMDD') as integer)
        as quarter_start_date_key
from joined