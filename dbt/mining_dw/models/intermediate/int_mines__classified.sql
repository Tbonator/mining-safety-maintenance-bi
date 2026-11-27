-- Mines with business rules applied:
--   * map_latitude / map_longitude: coordinates kept only if they fall inside the US and its territories
--   * mine_status_group: Operating / Idle / Abandoned
-- The original latitude and longitude stay as reported, so you can always see what was dropped.

with mines as (

    select * from {{ ref('stg_msha__mines') }}

),

flagged as (

    select
        *,

        -- A valid US location: American Samoa (about -14 lat) up to northern Alaska (about 71),
        -- the Aleutians (about -180 lon) across to Puerto Rico (about -65).
        coalesce(
            latitude between -15 and 72
            and longitude between -180 and -64,
            false
        )                                                  as is_valid_location

    from mines

)

select
    *,

    case when is_valid_location then latitude end         as map_latitude,
    case when is_valid_location then longitude end        as map_longitude,

    case
        when mine_status in ('Active', 'Intermittent', 'New Mine') then 'Operating'
        when mine_status in ('Temporarily Idled', 'NonProducing')  then 'Idle'
        when mine_status in ('Abandoned', 'Abandoned and Sealed')  then 'Abandoned'
        else 'Unknown'
    end                                                    as mine_status_group

from flagged