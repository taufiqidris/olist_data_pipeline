## Data Architecture

```mermaid
flowchart LR
  A[Kaggle CSV Files] --> B[DuckDB: olist_stage.duckdb]
  B --> C[Meltano EL/ELT]
  C --> D[BigQuery Dataset: olist_raw<br/>Singer-loaded raw tables]
  D --> E[dbt Staging Models<br/>stg_* (JSON extract + type casting)]
  E --> F[dbt Snapshots<br/>SCD2: customers/products]
  E --> G[dbt Marts<br/>dim_* + fct_*]
  F --> G
  G --> H[Python / Pandas Analysis<br/>notebooks, KPIs, insights]