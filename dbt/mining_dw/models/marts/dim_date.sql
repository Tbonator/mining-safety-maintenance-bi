-- One row per calendar day, from the first MSHA records to well past today.
-- date_key (YYYYMMDD as a number) is the key the fact tables join on.

with days as (

    select generate_series(
        date '1980-01-01',
        date '2030-12-31',
        interval '1 day'
    )::date as date_day

)

select
    cast(to_char(date_day, 'YYYYMMDD') as integer)     as date_key,
    date_day,
    extract(year from date_day)::int                    as year,
    extract(quarter from date_day)::int                 as quarter,
    'Q' || extract(quarter from date_day)::int          as quarter_name,
    to_char(date_day, 'YYYY') || '-Q'
        || extract(quarter from date_day)::int          as year_quarter,
    extract(month from date_day)::int                   as month,
    trim(to_char(date_day, 'Month'))                    as month_name,
    to_char(date_day, 'Mon')                            as month_short,
    to_char(date_day, 'YYYY-MM')                        as year_month,
    extract(isodow from date_day)::int                  as day_of_week,
    trim(to_char(date_day, 'Day'))                      as day_name,
    extract(isodow from date_day) in (6, 7)             as is_weekend,
    date_trunc('quarter', date_day)::date               as quarter_start_date
from days