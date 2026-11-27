-- One row per equipment group, plus 'Not recorded' for accidents with no equipment.
-- The synthetic maintenance data will join to this same table later.

with groups as (

    select
        equipment_group,
        bool_or(is_mobile_equipment)   as is_mobile_equipment,
        count(*)                       as msha_equipment_type_count
    from {{ ref('equipment_groups') }}
    group by equipment_group

    union all

    select 'Not recorded', false, 0

)

select * from groups