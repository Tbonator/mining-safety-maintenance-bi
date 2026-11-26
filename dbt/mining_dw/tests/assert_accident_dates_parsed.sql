-- safe_to_date turns anything it can't read into NULL, which hides problems.
-- This test finds accident dates that were filled in raw but came out NULL,
-- so a new date format in the source never slips through unnoticed.
{{ config(severity='warn') }}

select
    s.document_no,
    r.accident_dt as raw_value
from {{ ref('stg_msha__accidents') }} as s
join {{ source('msha', 'msha_accidents') }} as r
    on r.document_no = s.document_no
where s.accident_date is null
  and nullif(trim(r.accident_dt), '') is not null