{% macro select_distinct_columns(table, col) %}
select * from {{table}} where {{col}} < 300
{% endmacro %}

 