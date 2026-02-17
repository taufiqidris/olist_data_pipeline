{{ config(materialized='table') }}

select
  r.review_id,
  r.order_id,
  r.review_score,
  r.review_comment_title,
  r.review_comment_message,
  r.review_creation_date,
  r.review_answer_timestamp
from {{ ref('stg_olist_order_reviews') }} r
join {{ ref('fct_orders') }} o
  on r.order_id = o.order_id