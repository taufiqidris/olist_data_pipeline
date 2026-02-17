{{ config(materialized='table') }}

-- Sellers dimension (no snapshot yet -> built from staging current state)
select
  seller_id,
  seller_zip_code_prefix,
  seller_city,
  seller_state
from {{ ref('stg_olist_sellers') }}