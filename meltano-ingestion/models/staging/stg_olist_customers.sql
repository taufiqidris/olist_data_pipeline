with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_customers') }}
),

renamed as (
  select
    json_value(data, '$.customer_id') as customer_id,
    json_value(data, '$.customer_unique_id') as customer_unique_id,
    json_value(data, '$.customer_zip_code_prefix') as customer_zip_code_prefix,
    json_value(data, '$.customer_city') as customer_city,
    json_value(data, '$.customer_state') as customer_state,

    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed