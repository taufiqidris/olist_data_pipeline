{{ config(materialized='table') }}

-- Geolocation can have duplicates per zip prefix in Olist.
-- We'll aggregate to a single (zip_prefix) "representative" lat/lng (avg).
select
  geolocation_zip_code_prefix,
  avg(geolocation_lat) as geolocation_lat,
  avg(geolocation_lng) as geolocation_lng,
  any_value(geolocation_city) as geolocation_city,
  any_value(geolocation_state) as geolocation_state
from {{ ref('stg_olist_geolocation') }}
group by 1