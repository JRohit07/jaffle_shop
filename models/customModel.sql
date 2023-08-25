WITH listing AS (

  SELECT * 
  
  FROM {{ source('sample_data_dev.tickit', 'listing') }}

),

listing_3 AS (

  SELECT * 
  
  FROM {{ source('dev.public', 'listing') }}

),

listing_union AS (

  SELECT * 
  
  FROM listing_3 AS in0
  
  UNION ALL
  
  SELECT * 
  
  FROM listing AS in1

)

SELECT *

FROM listing_union
