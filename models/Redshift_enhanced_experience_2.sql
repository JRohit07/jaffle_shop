WITH customers AS (

  SELECT * 
  
  FROM {{ ref('customers')}}

),

orders AS (

  SELECT * 
  
  FROM {{ ref('orders')}}

),

Redshift_enhanced_experience_1 AS (

  SELECT * 
  
  FROM {{ ref('Redshift_enhanced_experience_1')}}

),

by_credit_card_amount_order_date AS (

  SELECT 
    Redshift_enhanced_experience_1.status AS status,
    Redshift_enhanced_experience_1.customer_lifetime_value AS customer_lifetime_value,
    Redshift_enhanced_experience_1.bank_transfer_amount AS bank_transfer_amount,
    Redshift_enhanced_experience_1.credit_card_amount AS credit_card_amount,
    Redshift_enhanced_experience_1.order_date AS order_date,
    Redshift_enhanced_experience_1.customer_id AS customer_id,
    Redshift_enhanced_experience_1.first_name AS first_name,
    Redshift_enhanced_experience_1.first_order AS first_order,
    Redshift_enhanced_experience_1.gift_card_amount AS gift_card_amount,
    Redshift_enhanced_experience_1.coupon_amount AS coupon_amount,
    Redshift_enhanced_experience_1.number_of_orders AS number_of_orders,
    Redshift_enhanced_experience_1.amount AS amount,
    Redshift_enhanced_experience_1.most_recent_order AS most_recent_order,
    Redshift_enhanced_experience_1.last_name AS last_name,
    Redshift_enhanced_experience_1.order_id AS order_id
  
  FROM Redshift_enhanced_experience_1
  INNER JOIN orders
     ON Redshift_enhanced_experience_1.credit_card_amount = orders.credit_card_amount
    AND Redshift_enhanced_experience_1.order_date = orders.order_date
    AND Redshift_enhanced_experience_1.gift_card_amount = orders.gift_card_amount
    AND Redshift_enhanced_experience_1.customer_id = orders.customer_id
    AND Redshift_enhanced_experience_1.status = orders.status
    AND Redshift_enhanced_experience_1.bank_transfer_amount = orders.bank_transfer_amount
    AND Redshift_enhanced_experience_1.order_id = orders.order_id
    AND Redshift_enhanced_experience_1.amount = orders.amount
    AND Redshift_enhanced_experience_1.coupon_amount = orders.coupon_amount

),

stg_customers AS (

  SELECT * 
  
  FROM {{ ref('stg_customers')}}

),

by_customer_id_first_name AS (

  SELECT 
    customers.number_of_orders AS number_of_orders,
    customers.first_order AS first_order,
    customers.customer_lifetime_value AS customer_lifetime_value,
    customers.most_recent_order AS most_recent_order,
    customers.customer_id AS customer_id,
    customers.first_name AS first_name,
    customers.last_name AS last_name
  
  FROM customers
  INNER JOIN stg_customers
     ON customers.customer_id = stg_customers.customer_id
    AND customers.first_name = stg_customers.first_name
    AND customers.last_name = stg_customers.last_name

),

join_by_customer_id_and_credit_card AS (

  SELECT 
    in0.number_of_orders AS number_of_orders,
    in0.first_order AS first_order,
    in1.first_name AS first_name,
    in0.last_name AS last_name,
    in1.order_id AS order_id
  
  FROM by_customer_id_first_name AS in0
  INNER JOIN by_credit_card_amount_order_date AS in1
     ON in0.customer_id = in1.customer_id

)

SELECT *

FROM join_by_customer_id_and_credit_card
