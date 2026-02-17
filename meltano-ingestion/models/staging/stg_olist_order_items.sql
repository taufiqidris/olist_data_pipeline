with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_order_items') }}
),

renamed as (
  select
    json_value(data, '$.order_id') as order_id,
    safe_cast(json_value(data, '$.order_item_id') as int64) as order_item_id,
    json_value(data, '$.product_id') as product_id,
    json_value(data, '$.seller_id') as seller_id,
    safe_cast(json_value(data, '$.shipping_limit_date') as timestamp) as shipping_limit_date,
    safe_cast(json_value(data, '$.price') as numeric) as price,
    safe_cast(json_value(data, '$.freight_value') as numeric) as freight_value,

    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed