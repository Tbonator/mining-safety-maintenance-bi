-- The quarterly table should have one row per mine, subunit and quarter.
-- A singular test passes when this query returns 0 rows.
select
    mine_id,
    subunit_code,
    calendar_year,
    calendar_quarter,
    count(*) as row_count
from {{ ref('stg_msha__employment_production_quarterly') }}
group by 1, 2, 3, 4
having count(*) > 1