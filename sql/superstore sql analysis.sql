SELECT * FROM superstore.order;

SHOW DATABASES;

USE superstore;
SELECT * FROM `order`;

CREATE TABLE customers (
  customer_id VARCHAR(20) PRIMARY KEY,
  name VARCHAR(100),
  city VARCHAR(50),
  state VARCHAR(50),
  region VARCHAR(50)
);
INSERT INTO customers (customer_id, name, city, state, region)
SELECT 
  `Customer ID`, 
  MAX(`Customer Name`), 
  MAX(`City`), 
  MAX(`State`), 
  MAX(`Region`)
FROM `order`
GROUP BY `Customer ID`;

SELECT o.`Order ID`, o.`Order Date`, c.customer_id, c.name, o.sales, o.profit
FROM `order` o
JOIN customers c ON o.`Customer ID` = c.customer_id
LIMIT 1000;

DESCRIBE `order`;


SELECT region, 
       SUM(sales) AS total_sales, 
       SUM(profit) AS total_profit
FROM `order`
WHERE sales > 0
GROUP BY region
ORDER BY total_sales DESC;

SELECT o.`Order ID`, o.`Order Date`, c.name, o.sales, o.profit
FROM `order` o
INNER JOIN customers c ON o.`Customer ID` = c.customer_id;

SELECT o.`Order ID`, o.`Order Date`, c.name, o.sales
FROM `order` o
LEFT JOIN customers c ON o.`Customer ID` = c.customer_id;

SELECT c.name, o.`Order ID`, o.sales
FROM `order` o
RIGHT JOIN customers c ON o.`Customer ID` = c.customer_id;

SELECT name, total_sales
FROM (
  SELECT c.name, SUM(o.sales) AS total_sales
  FROM `order` o
  JOIN customers c ON o.`Customer ID` = c.customer_id
  GROUP BY c.name
) AS customer_sales
ORDER BY total_sales DESC
LIMIT 5;


SELECT segment, 
       AVG(profit) AS avg_profit, 
       SUM(sales) AS total_sales
FROM `order`
GROUP BY segment;


CREATE OR REPLACE VIEW high_value_orders AS
SELECT `Order ID`, `Customer ID`, sales, profit
FROM `order`
WHERE sales > 1000;

