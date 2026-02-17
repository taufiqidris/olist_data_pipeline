{{ config(materialized='table') }}

-- Current-state customer dimension from snapshot
select
  customer_id,
  customer_unique_id,
  customer_zip_code_prefix,
  customer_city,
  customer_state,

  dbt_valid_from,
  dbt_valid_to
from {{ ref('snap_olist_customers') }}
where dbt_valid_to is null