-- Every equipment type in the accidents data must have a group in the equipment_groups seed.
-- If MSHA adds a new equipment type, this test fails and tells you which one to add to the CSV.
select distinct a.equipment_type
from {{ ref('stg_msha__accidents') }} as a
left join {{ ref('equipment_groups') }} as g
    on a.equipment_type = g.equipment_type
where a.equipment_type is not null
  and g.equipment_type is null