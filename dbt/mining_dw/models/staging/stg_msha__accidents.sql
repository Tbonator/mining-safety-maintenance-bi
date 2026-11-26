-- Staging model for MSHA accidents: one row per accident, injury or illness report.

with source as (

    select * from {{ source('msha', 'msha_accidents') }}

),

renamed as (

    select
        -- keys
        {{ clean_text('document_no') }}                             as document_no,
        cast(trim(mine_id) as bigint)                               as mine_id,
        {{ clean_text('subunit_cd') }}                              as subunit_code,
        {{ clean_text('subunit') }}                                 as subunit,

        -- who ran the mine at the time
        {{ clean_text('controller_id') }}                           as controller_id,
        {{ clean_text('controller_name') }}                         as controller_name,
        {{ clean_text('operator_id') }}                             as operator_id,
        {{ clean_text('operator_name') }}                           as operator_name,
        {{ clean_text('contractor_id') }}                           as contractor_id,

        -- when
        {{ safe_to_date('accident_dt') }}                           as accident_date,
        {{ safe_to_number('cal_yr', 'integer') }}                   as calendar_year,
        {{ safe_to_number('cal_qtr', 'integer') }}                  as calendar_quarter,
        {{ safe_to_number('fiscal_yr', 'integer') }}                as fiscal_year,
        {{ safe_to_number('fiscal_qtr', 'integer') }}               as fiscal_quarter,
        {{ clean_text('accident_time') }}                           as accident_time,
        {{ clean_text('shift_begin_time') }}                        as shift_begin_time,

        -- where
        {{ clean_text('fips_state_cd') }}                           as state_fips_code,
        {{ clean_text('ug_location') }}                             as underground_location,
        {{ clean_text('ug_mining_method') }}                        as underground_mining_method,

        -- equipment involved
        {{ clean_text('mining_equip_cd') }}                         as equipment_code,
        {{ clean_text('mining_equip') }}                            as equipment_type,
        {{ clean_text('equip_mfr_cd') }}                            as equipment_manufacturer_code,
        {{ clean_text('equip_mfr_name') }}                          as equipment_manufacturer,
        {{ clean_text('equip_model_no') }}                          as equipment_model_no,

        -- what happened
        {{ clean_text('classification_cd') }}                       as classification_code,
        {{ clean_text('classification') }}                          as classification,
        {{ clean_text('accident_type_cd') }}                        as accident_type_code,
        {{ clean_text('accident_type') }}                           as accident_type,
        {{ clean_text('activity_cd') }}                             as activity_code,
        {{ clean_text('activity') }}                                as activity,
        {{ clean_text('injury_source') }}                           as injury_source,
        {{ clean_text('nature_injury') }}                           as nature_of_injury,
        {{ clean_text('inj_body_part') }}                           as body_part,
        {{ clean_text('narrative') }}                               as narrative,

        -- severity
        {{ clean_text('degree_injury_cd') }}                        as degree_of_injury_code,
        {{ clean_text('degree_injury') }}                           as degree_of_injury,
        {{ safe_to_number('no_injuries', 'integer') }}              as injury_count,
        {{ safe_to_number('days_lost', 'integer') }}                as days_lost,
        {{ safe_to_number('days_restrict', 'integer') }}            as days_restricted,
        {{ safe_to_number('schedule_charge', 'integer') }}          as schedule_charge_days,
        {{ safe_to_date('return_to_work_dt') }}                     as return_to_work_date,

        -- the person
        {{ clean_text('occupation_cd') }}                           as occupation_code,
        {{ clean_text('occupation') }}                              as occupation,
        {{ safe_to_number('tot_exper') }}                           as total_experience_years,
        {{ safe_to_number('mine_exper') }}                          as mine_experience_years,
        {{ safe_to_number('job_exper') }}                           as job_experience_years,

        -- follow-up
        {{ clean_text('immed_notify') }}                            as immediate_notification,
        {{ safe_to_date('invest_begin_dt') }}                       as investigation_begin_date,
        {{ clean_text('closed_doc_no') }}                           as closed_doc_no,
        {{ clean_text('coal_metal_ind') }}                          as coal_metal_ind,

        -- lineage
        _source_file                                                as source_file

    from source

)

select * from renamed