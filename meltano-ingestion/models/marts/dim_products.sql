{{ config(materialized='table') }}

-- Current-state product dimension from snapshot
select
  product_id,
  product_category_name,
  product_weight_g,
  product_length_cm,
  product_height_cm,
  product_width_cm,

  dbt_valid_from,
  dbt_valid_to
from {{ ref('snap_olist_products') }}
where dbt_valid_to is null