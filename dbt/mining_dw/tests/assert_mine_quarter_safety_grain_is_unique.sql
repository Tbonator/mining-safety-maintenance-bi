-- fct_mine_quarter_safety should have one row per mine and quarter.
select mine_id, calendar_year, calendar_quarter, count(*) as row_count
from {{ ref('fct_mine_quarter_safety') }}
group by 1, 2, 3
having count(*) > 1