WITH customers_1 AS (

  SELECT * 
  
  FROM {{ source('dev.public', 'customers') }}

),

customers AS (

  SELECT * 
  
  FROM {{ source('dev.jsr', 'customers') }}

),

SetOperation_1 AS (

  SELECT * 
  
  FROM customers AS in0
  
  UNION
  
  SELECT * 
  
  FROM customers_1 AS in1

)

SELECT *

FROM SetOperation_1
