-- Staging model for MSHA mines: one row per mine.
-- Job: rename, cast and tidy. One row in, one row out. No joins, no business logic.

with source as (

    select * from {{ source('msha', 'msha_mines') }}

),

renamed as (

    select
        -- key
        cast(trim(mine_id) as bigint)                               as mine_id,

        -- mine
        {{ clean_text('current_mine_name') }}                       as mine_name,
        {{ clean_text('coal_metal_ind') }}                          as coal_metal_ind,
        {{ clean_text('current_mine_type') }}                       as mine_type,
        {{ clean_text('current_mine_status') }}                     as mine_status,
        {{ safe_to_date('current_status_dt') }}                     as mine_status_date,

        -- ownership
        {{ clean_text('current_controller_id') }}                   as controller_id,
        {{ clean_text('current_controller_name') }}                 as controller_name,
        {{ safe_to_date('current_controller_begin_dt') }}           as controller_begin_date,
        {{ clean_text('current_operator_id') }}                     as operator_id,
        {{ clean_text('current_operator_name') }}                   as operator_name,
        {{ clean_text('company_type') }}                            as company_type,

        -- location
        {{ clean_text('state') }}                                   as state_code,
        {{ clean_text('fips_cnty_cd') }}                            as county_fips_code,
        {{ clean_text('fips_cnty_nm') }}                            as county_name,
        {{ clean_text('nearest_town') }}                            as nearest_town,
        {{ safe_to_number('latitude') }}                            as latitude,
        {{ safe_to_number('longitude') }}                           as longitude,

        -- MSHA office
        {{ clean_text('district') }}                                as msha_district,
        {{ clean_text('office_cd') }}                               as msha_office_code,
        {{ clean_text('office_name') }}                             as msha_office_name,

        -- what the mine produces
        {{ clean_text('primary_sic_cd') }}                          as primary_sic_code,
        {{ clean_text('primary_sic') }}                             as primary_sic,
        {{ clean_text('secondary_sic_cd') }}                        as secondary_sic_code,
        {{ clean_text('secondary_sic') }}                           as secondary_sic,
        {{ clean_text('primary_canvass') }}                         as primary_canvass,
        {{ clean_text('secondary_canvass') }}                       as secondary_canvass,

        -- operations
        {{ yes_no_to_boolean('portable_operation') }}               as is_portable_operation,
        {{ safe_to_number('days_per_week', 'integer') }}            as days_per_week,
        {{ safe_to_number('hours_per_shift') }}                     as hours_per_shift,
        {{ safe_to_number('prod_shifts_per_day', 'integer') }}      as production_shifts_per_day,
        {{ safe_to_number('maint_shifts_per_day', 'integer') }}     as maintenance_shifts_per_day,
        {{ safe_to_number('no_employees', 'integer') }}             as employee_count,

        -- lineage
        _source_file                                                as source_file

    from source

)

select * from renamed