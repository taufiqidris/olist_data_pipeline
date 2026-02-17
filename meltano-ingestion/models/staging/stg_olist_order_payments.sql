with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_order_payments') }}
),

renamed as (
  select
    json_value(data, '$.order_id') as order_id,
    safe_cast(json_value(data, '$.payment_sequential') as int64) as payment_sequential,
    json_value(data, '$.payment_type') as payment_type,
    safe_cast(json_value(data, '$.payment_installments') as int64) as payment_installments,
    safe_cast(json_value(data, '$.payment_value') as numeric) as payment_value,

    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed