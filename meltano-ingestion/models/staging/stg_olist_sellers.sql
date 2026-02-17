with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_sellers') }}
),

renamed as (
  select
    json_value(data, '$.seller_id') as seller_id,
    json_value(data, '$.seller_zip_code_prefix') as seller_zip_code_prefix,
    json_value(data, '$.seller_city') as seller_city,
    json_value(data, '$.seller_state') as seller_state,

    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed