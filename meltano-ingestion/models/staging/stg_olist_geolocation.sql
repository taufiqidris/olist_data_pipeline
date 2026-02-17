with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_geolocation') }}
),

renamed as (
  select
    json_value(data, '$.geolocation_zip_code_prefix') as geolocation_zip_code_prefix,
    safe_cast(json_value(data, '$.geolocation_lat') as float64) as geolocation_lat,
    safe_cast(json_value(data, '$.geolocation_lng') as float64) as geolocation_lng,
    json_value(data, '$.geolocation_city') as geolocation_city,
    json_value(data, '$.geolocation_state') as geolocation_state,

    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed