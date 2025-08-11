{{ config(materialized='view') }}

SELECT
    CAST(date AS DATE) AS sale_date,
    quarter,
    house_id,
    LOWER(house_type) AS house_type,
    LOWER(sales_type) AS sales_type,
    CAST(year_build AS INT64) AS year_built,
    CAST(purchase_price AS NUMERIC) AS purchase_price,

    -- Percent change column
    CAST(REPLACE(CAST(`%_change_between_offer_and_purchase` AS STRING), '%', '') AS NUMERIC) / 100 
        AS pct_change_offer_purchase,

    CAST(no_rooms AS INT64) AS num_rooms,
    CAST(sqm AS NUMERIC) AS sqm,
    CAST(sqm_price AS NUMERIC) AS sqm_price,
    address,
    zip_code,
    city,
    area,
    region,

    -- Percent columns
    CAST(REPLACE(CAST(`nom_interest_rate%` AS STRING), '%', '') AS NUMERIC) / 100 
        AS nom_interest_rate,

    CAST(REPLACE(CAST(`dk_ann_infl_rate%` AS STRING), '%', '') AS NUMERIC) / 100 
        AS dk_ann_infl_rate,

    CAST(REPLACE(CAST(`yield_on_mortgage_credit_bonds%` AS STRING), '%', '') AS NUMERIC) / 100 
        AS yield_on_mortgage_credit_bonds

FROM {{ source('real_estate', 'Housing') }}
