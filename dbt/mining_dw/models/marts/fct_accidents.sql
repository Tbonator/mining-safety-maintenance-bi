-- One row per accident report. Keys point to dim_date, dim_mine and dim_equipment_group.
-- The _sort columns let Power BI and QlikView order bands correctly instead of alphabetically.

with accidents as (

    select * from {{ ref('int_accidents__classified') }}

)

select
    -- keys
    document_no,
    cast(to_char(accident_date, 'YYYYMMDD') as integer)    as accident_date_key,
    mine_id,
    equipment_group,

    -- when
    accident_date,
    coalesce(calendar_year, extract(year from accident_date)::int)       as calendar_year,
    coalesce(calendar_quarter, extract(quarter from accident_date)::int) as calendar_quarter,

    -- severity
    severity_group,
    case severity_group
        when 'Fatal'                  then 1
        when 'Permanent disability'   then 2
        when 'Days away from work'    then 3
        when 'Restricted duty'        then 4
        when 'Medical treatment only' then 5
        when 'Occupational illness'   then 6
        when 'First aid and other'    then 7
        when 'Accident, no injury'    then 8
        when 'Natural causes'         then 9
        when 'Non-employee'           then 10
        else 11
    end                                                    as severity_sort,
    is_fatal,
    is_injury,
    is_nfdl_injury,
    is_contractor_injury,

    -- measures
    coalesce(injury_count, 0)                              as injury_count,
    coalesce(days_lost, 0)                                 as days_lost,
    coalesce(days_restricted, 0)                           as days_restricted,

    -- equipment detail
    is_equipment_recorded,
    is_mobile_equipment,
    equipment_type,
    equipment_manufacturer,

    -- what happened
    accident_type,
    classification,
    activity,
    occupation,
    body_part,
    nature_of_injury,
    subunit,

    -- the person
    mine_experience_band,
    case mine_experience_band
        when 'Under 1 year'  then 1
        when '1 to 5 years'  then 2
        when '5 to 10 years' then 3
        when '10+ years'     then 4
        else 5
    end                                                    as mine_experience_band_sort

from accidents