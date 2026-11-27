-- int_employment__mine_quarter should have one row per mine and quarter.
select mine_id, calendar_year, calendar_quarter, count(*) as row_count
from {{ ref('int_employment__mine_quarter') }}
group by 1, 2, 3
having count(*) > 1
