-- Hours worked and production per mine per quarter, summed across subunits
-- (pit, mill, office and so on). This is the denominator for injury rates.

with employment as (

    select * from {{ ref('stg_msha__employment_production_quarterly') }}

),

mine_quarter as (

    select
        mine_id,
        calendar_year,
        calendar_quarter,
        max(coal_metal_ind)                    as coal_metal_ind,
        count(*)                               as subunit_count,
        sum(avg_employee_count)                as avg_employee_count,
        sum(hours_worked)                      as hours_worked,
        sum(coal_production_tons)              as coal_production_tons
    from employment
    group by mine_id, calendar_year, calendar_quarter

)

select * from mine_quarter