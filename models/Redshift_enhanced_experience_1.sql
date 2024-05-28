WITH customers_1 AS (

  SELECT * 
  
  FROM {{ ref('customers')}}

),

Reformat_1 AS (

  SELECT 
    customer_id AS customer_id,
    first_name AS first_name,
    last_name AS last_name,
    first_order AS first_order,
    most_recent_order AS most_recent_order,
    number_of_orders AS number_of_orders,
    customer_lifetime_value AS customer_lifetime_value
  
  FROM customers_1 AS in0

),

Limit_1 AS (

  SELECT * 
  
  FROM Reformat_1 AS in0
  
  LIMIT 60

),

orders AS (

  SELECT * 
  
  FROM {{ ref('orders')}}

),

by_customer_id AS (

  SELECT 
    customers_1.first_name AS first_name,
    customers_1.last_name AS last_name,
    customers_1.first_order AS first_order,
    customers_1.most_recent_order AS most_recent_order,
    customers_1.number_of_orders AS number_of_orders,
    customers_1.customer_lifetime_value AS customer_lifetime_value,
    orders.credit_card_amount AS credit_card_amount,
    orders.order_date AS order_date,
    orders.gift_card_amount AS gift_card_amount,
    orders.customer_id AS customer_id,
    orders.status AS status,
    orders.bank_transfer_amount AS bank_transfer_amount,
    orders.order_id AS order_id,
    orders.amount AS amount,
    orders.coupon_amount AS coupon_amount
  
  FROM orders
  INNER JOIN Limit_1 AS customers_1
     ON orders.customer_id = customers_1.customer_id

)

SELECT *

FROM by_customer_id
