WITH stg_orders AS (

  SELECT * 
  
  FROM {{ ref('stg_orders')}}

),

customer_order_summary AS (

  SELECT 
    customer_id,
    min(order_date) AS first_order,
    max(order_date) AS most_recent_order,
    count(order_id) AS number_of_orders
  
  FROM stg_orders AS orders
  
  GROUP BY customer_id

),

stg_payments AS (

  SELECT * 
  
  FROM {{ ref('stg_payments')}}

),

total_amount_by_customer AS (

  SELECT 
    stg_orders.customer_id,
    sum(amount) AS total_amount
  
  FROM stg_payments
  LEFT JOIN stg_orders
     ON stg_payments.order_id = stg_orders.order_id
  
  GROUP BY stg_orders.customer_id

),

stg_customers AS (

  SELECT * 
  
  FROM {{ ref('stg_customers')}}

),

customer_lifetime_value AS (

  SELECT 
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order,
    customer_orders.most_recent_order,
    customer_orders.number_of_orders,
    customer_payments.total_amount AS customer_lifetime_value
  
  FROM stg_customers AS customers
  LEFT JOIN customer_order_summary AS customer_orders
     ON customers.customer_id = customer_orders.customer_id
  LEFT JOIN total_amount_by_customer AS customer_payments
     ON customers.customer_id = customer_payments.customer_id

)

SELECT *

FROM customer_lifetime_value
