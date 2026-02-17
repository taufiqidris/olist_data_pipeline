with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_orders') }}
),

renamed as (
  select
    json_value(data, '$.order_id') as order_id,
    json_value(data, '$.customer_id') as customer_id,
    json_value(data, '$.order_status') as order_status,

    safe_cast(json_value(data, '$.order_purchase_timestamp') as timestamp) as order_purchase_timestamp,
    safe_cast(json_value(data, '$.order_approved_at') as timestamp) as order_approved_at,
    safe_cast(json_value(data, '$.order_delivered_carrier_date') as timestamp) as order_delivered_carrier_date,
    safe_cast(json_value(data, '$.order_delivered_customer_date') as timestamp) as order_delivered_customer_date,
    safe_cast(json_value(data, '$.order_estimated_delivery_date') as timestamp) as order_estimated_delivery_date,

    -- keep Singer metadata for lineage/debugging
    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed
