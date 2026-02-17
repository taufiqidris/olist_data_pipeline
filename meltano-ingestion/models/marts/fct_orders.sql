{{ config(materialized='table') }}

select
  o.order_id,
  o.customer_id,
  o.order_status,
  o.order_purchase_timestamp,
  o.order_approved_at,
  o.order_delivered_carrier_date,
  o.order_delivered_customer_date,
  o.order_estimated_delivery_date,

  timestamp_diff(o.order_approved_at, o.order_purchase_timestamp, hour) as hrs_to_approve,
  timestamp_diff(o.order_delivered_customer_date, o.order_purchase_timestamp, day) as days_to_deliver,
  timestamp_diff(o.order_estimated_delivery_date, o.order_delivered_customer_date, day) as days_early_late_vs_estimated
from {{ ref('stg_olist_orders') }} o
join {{ ref('dim_customers') }} c
  on o.customer_id = c.customer_id