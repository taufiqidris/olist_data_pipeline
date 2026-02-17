{{ config(materialized='table') }}

select
  p.order_id,
  p.payment_sequential,
  p.payment_type,
  p.payment_installments,
  p.payment_value
from {{ ref('stg_olist_order_payments') }} p
join {{ ref('fct_orders') }} o
  on p.order_id = o.order_id