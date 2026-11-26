{#
  Turn Y/N style flags into true/false. Anything else becomes NULL.
  Usage: {{ yes_no_to_boolean('portable_operation') }}
#}
{% macro yes_no_to_boolean(column) -%}
    case upper(trim({{ column }}))
        when 'Y' then true
        when 'YES' then true
        when 'N' then false
        when 'NO' then false
    end
{%- endmacro %}