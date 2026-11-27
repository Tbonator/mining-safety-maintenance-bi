-- Reconciliation: the quarterly table must hold exactly as many fatalities
-- and injuries as the accident fact it was built from.
-- If these ever differ, rows were lost or double-counted in the join.
with from_accidents as (
    select
        count(*) filter (where is_fatal)  as fatalities,
        count(*) filter (where is_injury) as injuries
    from {{ ref('fct_accidents') }}
    where calendar_year is not null
      and calendar_quarter is not null
),

from_quarters as (
    select
        sum(fatality_count) as fatalities,
        sum(injury_count)   as injuries
    from {{ ref('fct_mine_quarter_safety') }}
)

select *
from from_accidents, from_quarters
where from_accidents.fatalities <> from_quarters.fatalities
   or from_accidents.injuries   <> from_quarters.injuries