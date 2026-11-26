{#
  Trim spaces and turn empty text, or MSHA's placeholders for "missing", into a real NULL.
  Usage: {{ clean_text('current_mine_name') }}
#}
{% macro clean_text(column) -%}
    case
        when upper(trim({{ column }})) in ('', 'NO VALUE FOUND', '?')
            then null
        else trim({{ column }})
    end
{%- endmacro %}