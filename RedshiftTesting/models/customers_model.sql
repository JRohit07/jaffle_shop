{{
  config({    
    "materialized": "table"
  })
}}

WITH customers AS (

  SELECT * 
  
  FROM {{ source('dev.public', 'customers') }}

),

customers_1 AS (

  SELECT * 
  
  FROM {{ source('dev.public', 'customers') }}

),

SetOperation_1 AS (

  SELECT * 
  
  FROM customers_1 AS in0
  
  UNION
  
  SELECT * 
  
  FROM customers AS in1

)

SELECT *

FROM SetOperation_1
