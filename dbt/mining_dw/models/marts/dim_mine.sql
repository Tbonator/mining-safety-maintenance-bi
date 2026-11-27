-- One row per mine. Descriptive attributes the dashboards filter and group by.

with mines as (

    select * from {{ ref('int_mines__classified') }}

)

select
    mine_id,
    mine_name,
    case coal_metal_ind
        when 'C' then 'Coal'
        when 'M' then 'Metal/non-metal'
        else 'Unknown'
    end                             as commodity_type,
    mine_type,
    mine_status,
    mine_status_group,
    mine_status_date,
    controller_name,
    operator_name,
    state_code,
    county_name,
    nearest_town,
    primary_sic,
    primary_canvass,
    employee_count,
    is_valid_location,
    map_latitude,
    map_longitude
from mines