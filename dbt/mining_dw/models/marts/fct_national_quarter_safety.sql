-- One row per calendar quarter for all US mining: operator + contractor hours and all injuries.
-- This is the table for industry-wide rates that match how MSHA publishes them:
--   all-injury rate = injury_count x 200,000 / total_hours_worked
-- For per-mine rates use fct_mine_quarter_safety instead (operator injuries and hours only).

with operator_hours as (

    select
        calendar_year,
        calendar_quarter,
        sum(hours_worked)                  as operator_hours_worked
    from {{ ref('int_employment__mine_quarter') }}
    where calendar_year is not null
      and calendar_quarter is not null
    group by 1, 2

),

contractor_hours as (

    select
        calendar_year,
        calendar_quarter,
        sum(hours_worked)                  as contractor_hours_worked
    from {{ ref('stg_msha__contractor_employment_production_quarterly') }}
    where calendar_year is not null
      and calendar_quarter is not null
    group by 1, 2

),

accidents as (

    select
        calendar_year,
        calendar_quarter,
        count(*)                                                       as accident_count,
        count(*) filter (where is_injury)                              as injury_count,
        count(*) filter (where is_nfdl_injury)                         as nfdl_injury_count,
        count(*) filter (where is_fatal)                               as fatality_count,
        count(*) filter (where is_injury and is_contractor_injury)     as contractor_injury_count,
        sum(days_lost)                                                 as days_lost
    from {{ ref('fct_accidents') }}
    where calendar_year is not null
      and calendar_quarter is not null
    group by 1, 2

),

quarters as (

    select calendar_year, calendar_quarter from operator_hours
    union
    select calendar_year, calendar_quarter from contractor_hours
    union
    select calendar_year, calendar_quarter from accidents

)

select
    q.calendar_year,
    q.calendar_quarter,
    cast(to_char(make_date(q.calendar_year, (q.calendar_quarter - 1) * 3 + 1, 1), 'YYYYMMDD') as integer)
                                                              as quarter_start_date_key,
    coalesce(o.operator_hours_worked, 0)                      as operator_hours_worked,
    coalesce(c.contractor_hours_worked, 0)                    as contractor_hours_worked,
    coalesce(o.operator_hours_worked, 0)
        + coalesce(c.contractor_hours_worked, 0)              as total_hours_worked,
    coalesce(a.accident_count, 0)                             as accident_count,
    coalesce(a.injury_count, 0)                               as injury_count,
    coalesce(a.nfdl_injury_count, 0)                          as nfdl_injury_count,
    coalesce(a.fatality_count, 0)                             as fatality_count,
    coalesce(a.contractor_injury_count, 0)                    as contractor_injury_count,
    coalesce(a.days_lost, 0)                                  as days_lost
from quarters as q
left join operator_hours   as o using (calendar_year, calendar_quarter)
left join contractor_hours as c using (calendar_year, calendar_quarter)
left join accidents        as a using (calendar_year, calendar_quarter)