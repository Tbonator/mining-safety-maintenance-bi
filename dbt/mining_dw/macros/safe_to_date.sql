{#
  Parse a date written as MM/DD/YYYY or YYYY-MM-DD, or return NULL.
  Anything else (blanks, '?', bad dates) becomes NULL instead of crashing the model.
  The test assert_accident_dates_parsed reports non-blank values that ended up NULL.
  Usage: {{ safe_to_date('accident_dt') }}
#}
{% macro safe_to_date(column) -%}
    case
        when trim({{ column }}) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
            then to_date(trim({{ column }}), 'MM/DD/YYYY')
        when trim({{ column }}) ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}'
            then to_date(left(trim({{ column }}), 10), 'YYYY-MM-DD')
    end
{%- endmacro %}