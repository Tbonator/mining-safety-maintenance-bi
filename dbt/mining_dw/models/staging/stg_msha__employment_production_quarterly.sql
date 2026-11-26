-- Staging model for MSHA quarterly employment and production:
-- one row per mine, subunit and calendar quarter.

with source as (

    select * from {{ source('msha', 'msha_employment_production_quarterly') }}

),

renamed as (

    select
        -- keys
        cast(trim(mine_id) as bigint)                               as mine_id,
        {{ clean_text('subunit_cd') }}                              as subunit_code,
        {{ clean_text('subunit') }}                                 as subunit,
        {{ safe_to_number('cal_yr', 'integer') }}                   as calendar_year,
        {{ safe_to_number('cal_qtr', 'integer') }}                  as calendar_quarter,
        {{ safe_to_number('fiscal_yr', 'integer') }}                as fiscal_year,
        {{ safe_to_number('fiscal_qtr', 'integer') }}               as fiscal_quarter,

        -- descriptive
        {{ clean_text('curr_mine_nm') }}                            as mine_name,
        {{ clean_text('state') }}                                   as state_code,
        {{ clean_text('coal_metal_ind') }}                          as coal_metal_ind,

        -- measures
        {{ safe_to_number('avg_employee_cnt') }}                    as avg_employee_count,
        {{ safe_to_number('hours_worked') }}                        as hours_worked,
        {{ safe_to_number('coal_production') }}                     as coal_production_tons,

        -- lineage
        _source_file                                                as source_file

    from source

)

select * from renamed