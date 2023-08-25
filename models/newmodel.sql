{{
  config({    
    "materialized": "materialized_view"
  })
}}

WITH listing AS (

  SELECT * 
  
  FROM {{ source('sample_data_dev.tickit', 'listing') }}

),

Limit_1_1 AS (

  SELECT * 
  
  FROM listing AS in0
  
  LIMIT 10000

),

Filter_1_1 AS (

  SELECT * 
  
  FROM Limit_1_1 AS in0
  
  WHERE true

),

Reformat_1_1 AS (

  SELECT 
    listid AS listid,
    sellerid AS sellerid,
    eventid AS eventid,
    dateid AS dateid,
    priceperticket AS priceperticket,
    totalprice AS totalprice,
    numtickets AS numtickets,
    listtime AS listtime,
    {{ jaffle_shop.generic_round() }} AS c_function
  
  FROM Filter_1_1 AS in0

),

Aggregate_1_1 AS (

  SELECT * 
  
  FROM Reformat_1_1 AS in0

),

listing_3 AS (

  SELECT * 
  
  FROM {{ source('dev.public', 'listing') }}

),

Limit_1 AS (

  SELECT * 
  
  FROM listing_3 AS in0
  
  LIMIT 10000

),

Filter_1 AS (

  SELECT * 
  
  FROM Limit_1 AS in0
  
  WHERE true

),

Reformat_1 AS (

  SELECT 
    listid AS listid,
    sellerid AS sellerid,
    eventid AS eventid,
    dateid AS dateid,
    numtickets AS numtickets,
    priceperticket AS priceperticket,
    totalprice AS totalprice,
    listtime AS listtime,
    {{ jaffle_shop.generic_round() }} AS c_function
  
  FROM Filter_1 AS in0

),

Macro_1_1 AS (

  {{ jaffle_shop.select_distinct_columns(table = 'Reformat_1_1', col = 'listid') }}

),

Macro_1 AS (

  {{ jaffle_shop.select_distinct_columns(table = 'Reformat_1', col = 'listid') }}

),

listing_union AS (

  SELECT * 
  
  FROM Macro_1 AS in0
  
  UNION ALL
  
  SELECT * 
  
  FROM Macro_1_1 AS in1

),

Aggregate_1 AS (

  SELECT * 
  
  FROM Reformat_1 AS in0

)

SELECT *

FROM listing_union
