{#
  Cast text to a number, or NULL if the text isn't a number.
  A plain cast would crash the whole model on one bad value like '?' or 'N/A'.
  Usage: {{ safe_to_number('days_lost', 'integer') }}
#}
{% macro safe_to_number(column, data_type='numeric') -%}
    case
        when trim({{ column }}) ~ '^-?([0-9]+\.?[0-9]*|\.[0-9]+)$'
            then cast(cast(trim({{ column }}) as numeric) as {{ data_type }})
    end
{%- endmacro %}