-- Staging model for MSHA mines.
-- Job: rename, cast and tidy. One row in, one row out. No joins, no business logic.

with source as (

    select * from {{ source('msha', 'msha_mines') }}

),

renamed as (

    select
        cast(mine_id as bigint)                  as mine_id,
        nullif(trim(current_mine_name), '')      as mine_name,
        nullif(trim(current_mine_status), '')    as mine_status,
        nullif(trim(state), '')                  as state_code
    from source

)

select * from renamed