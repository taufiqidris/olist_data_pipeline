{% snapshot snap_olist_customers %}

{{
  config(
    target_schema='olist_snapshots',
    unique_key='customer_id',
    strategy='check',
    check_cols=[
      'customer_unique_id',
      'customer_zip_code_prefix',
      'customer_city',
      'customer_state'
    ]
  )
}}

select
  customer_id,
  customer_unique_id,
  customer_zip_code_prefix,
  customer_city,
  customer_state
from {{ ref('stg_olist_customers') }}

{% endsnapshot %}