create database Restaurant;

use Restaurant;

-- Let's first find out some KPIs of the business
-- 1. Total Revenue generated:
SELECT SUM(total_price) AS Total_Revenue 
FROM pizza;

-- 2. Average Order Value:
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_OrderValue 
FROM pizza;

-- 3. Total Pizzas Sold: 
SELECT SUM(quantity) AS Total_pizzas_sold 
FROM pizza;

-- 4. Total Orders:
SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza;

-- 5. Average pizzas per order:
SELECT CAST(SUM(quantity)/COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Pizza_per_Order 
FROM pizza;

-- 6. Daily trend for Total Orders:
-- First let's convert order_date datatype to DATE
UPDATE pizza
set order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE pizza
MODIFY order_date DATE;

SELECT DAYNAME(order_date) as order_day, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza  
GROUP BY DAYNAME(order_date)
ORDER BY 2 DESC;
-- We can see that Friday has highest sales

-- 7. Monthly trend for Total Orders:
SELECT MONTHNAME(order_date) AS Order_Month, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza
GROUP BY MONTHNAME(order_date)
ORDER BY 2 DESC;
-- WE can see that July has highest sales

-- 8. Percentage of Sales by Pizza category
SELECT pizza_category, CAST(sum(total_price)*100/ (SELECT sum(total_price) FROM pizza) AS DECIMAL(5,2)) AS Total_Sale
FROM pizza
GROUP BY pizza_category;

-- 9. Percentage of Sales by pizza size for July month
SELECT pizza_size, CAST(sum(total_price)*100/ (SELECT sum(total_price) FROM pizza WHERE MONTH(order_date) = 7) AS DECIMAL(5,2)) AS Total_Sale
FROM pizza
WHERE MONTH(order_date) = 7
GROUP BY pizza_size;

-- 10. Top 5 best sellers by Revenue.
SELECT pizza_name, sum(total_price) AS Total_Revenue
FROM pizza
GROUP BY pizza_name
ORDER BY 2 DESC LIMIT 5;

-- 11. Find Bottom 5 pizzas by Quantity ordered
SELECT pizza_name, sum(quantity) as Total_Quantity
FROM pizza
GROUP BY pizza_name
ORDER BY 2 LIMIT 5;

-- 12. Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza
Group BY pizza_name
ORDER BY 2 DESC LIMIT 5;
