-- Accidents with business rules applied, so every dashboard uses the same definitions:
--   * severity_group and injury flags, from MSHA's degree of injury
--   * equipment_group, from the equipment_groups seed
--   * experience band of the injured person at this mine

with accidents as (

    select * from {{ ref('stg_msha__accidents') }}

),

equipment_groups as (

    select * from {{ ref('equipment_groups') }}

),

classified as (

    select
        accidents.*,

        -- severity
        case degree_of_injury
            when 'FATALITY'                       then 'Fatal'
            when 'PERM TOT OR PERM PRTL DISABLTY' then 'Permanent disability'
            when 'DAYS AWAY FROM WORK ONLY'       then 'Days away from work'
            when 'DYS AWY FRM WRK & RESTRCTD ACT' then 'Days away from work'
            when 'DAYS RESTRICTED ACTIVITY ONLY'  then 'Restricted duty'
            when 'NO DYS AWY FRM WRK,NO RSTR ACT' then 'Medical treatment only'
            when 'OCCUPATNAL ILLNESS NOT DEG 1-6' then 'Occupational illness'
            when 'ACCIDENT ONLY'                  then 'Accident, no injury'
            when 'ALL OTHER CASES (INCL 1ST AID)' then 'First aid and other'
            when 'INJURIES DUE TO NATURAL CAUSES' then 'Natural causes'
            when 'INJURIES INVOLVNG NONEMPLOYEES' then 'Non-employee'
            else 'Not recorded'
        end                                                as severity_group,

        coalesce(degree_of_injury = 'FATALITY', false)     as is_fatal,

        -- An injury to an employee: fatal, permanent disability, days away,
        -- restricted duty or medical treatment. Excludes accidents with no injury,
        -- illnesses, natural causes, non-employees and first aid.
        coalesce(degree_of_injury in (
            'FATALITY',
            'PERM TOT OR PERM PRTL DISABLTY',
            'DAYS AWAY FROM WORK ONLY',
            'DYS AWY FRM WRK & RESTRCTD ACT',
            'DAYS RESTRICTED ACTIVITY ONLY',
            'NO DYS AWY FRM WRK,NO RSTR ACT'
        ), false)                                          as is_injury,

        -- Non-fatal days lost (NFDL): days away from work and/or restricted duty
        coalesce(degree_of_injury in (
            'DAYS AWAY FROM WORK ONLY',
            'DYS AWY FRM WRK & RESTRCTD ACT',
            'DAYS RESTRICTED ACTIVITY ONLY'
        ), false)                                          as is_nfdl_injury,

        -- equipment
        coalesce(equipment_groups.equipment_group, 'Not recorded') as equipment_group,
        coalesce(equipment_groups.is_mobile_equipment, false)      as is_mobile_equipment,
        accidents.equipment_type is not null                       as is_equipment_recorded,

        -- experience of the injured person at this mine
        case
            when mine_experience_years is null then 'Not recorded'
            when mine_experience_years < 1     then 'Under 1 year'
            when mine_experience_years < 5     then '1 to 5 years'
            when mine_experience_years < 10    then '5 to 10 years'
            else '10+ years'
        end                                                as mine_experience_band

    from accidents
    left join equipment_groups
        on accidents.equipment_type = equipment_groups.equipment_type

)

select * from classified