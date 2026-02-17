{% snapshot snap_olist_products %}

{{
  config(
    target_schema='olist_snapshots',
    unique_key='product_id',
    strategy='check',
    check_cols=[
      'product_category_name',
      'product_weight_g',
      'product_length_cm',
      'product_height_cm',
      'product_width_cm'
    ]
  )
}}

select
  product_id,
  product_category_name,
  product_weight_g,
  product_length_cm,
  product_height_cm,
  product_width_cm
from {{ ref('stg_olist_products') }}

{% endsnapshot %}