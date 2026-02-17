{{ config(materialized='table') }}

select
  oi.order_id,
  oi.order_item_id,
  oi.product_id,
  oi.seller_id,
  oi.shipping_limit_date,
  oi.price,
  oi.freight_value,
  (oi.price + oi.freight_value) as item_total_value
from {{ ref('stg_olist_order_items') }} oi
join {{ ref('fct_orders') }} o
  on oi.order_id = o.order_id
join {{ ref('dim_products') }} p
  on oi.product_id = p.product_id
join {{ ref('dim_sellers') }} s
  on oi.seller_id = s.seller_id