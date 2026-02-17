with source as (
  select *
  from {{ source('olist_raw', 'tap_csv_olist_order_reviews') }}
),

renamed as (
  select
    json_value(data, '$.review_id') as review_id,
    json_value(data, '$.order_id') as order_id,
    safe_cast(json_value(data, '$.review_score') as int64) as review_score,
    json_value(data, '$.review_comment_title') as review_comment_title,
    json_value(data, '$.review_comment_message') as review_comment_message,
    safe_cast(json_value(data, '$.review_creation_date') as timestamp) as review_creation_date,
    safe_cast(json_value(data, '$.review_answer_timestamp') as timestamp) as review_answer_timestamp,

    _sdc_extracted_at,
    _sdc_received_at,
    _sdc_batched_at,
    _sdc_deleted_at,
    _sdc_sequence,
    _sdc_table_version
  from source
)

select * from renamed