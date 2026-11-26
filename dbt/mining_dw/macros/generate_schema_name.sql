{#
  By default dbt builds custom schemas as <target schema>_<custom schema>,
  for example staging_marts. This override uses the custom schema name as-is,
  so models land in raw / staging / intermediate / marts exactly.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}