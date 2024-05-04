SELECT * FROM pizza_sales;


SELECT SUM(total_price) AS total_revenue FROM pizza_sales;

SELECT  SUM(total_price) / COUNT(DISTINCT order_id) AS avergae_order_value FROM pizza_sales;

SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) AS total_order FROM pizza_sales;

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS average_pizza_per_order FROM pizza_sales;

--Daily trend and DATENAME(DW, column) is used to get the name of the dat from the date in the string format
SELECT DATENAME(DW, order_date) as order_day, COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales GROUP BY DATENAME(DW, order_date); 

--Hourly trend and DATEPART() function is used to retrieve particular datepart of time
SELECT 
DATEPART(HOUR, order_time) as order_hours, 
COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY DATEPART(HOUR, order_time) 
ORDER BY DATEPART(HOUR, order_time); 

--percentage of sales by pizza category
SELECT
pizza_category,
SUM(total_price) AS total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_of_total_sales
FROM pizza_sales 
--WHERE MONTH(order_date) = 1
GROUP BY pizza_category; 

--percentage of sales by pizza size
SELECT
pizza_size,
SUM(total_price) AS total_sales,
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS percentage_of_total_sales
FROM pizza_sales 
--WHERE MONTH(order_date) = 1
GROUP BY pizza_size
ORDER BY percentage_of_total_sales; 


--total pizza sold by pizza category
SELECT
pizza_category,
SUM(quantity) AS total_pizza_sold
FROM pizza_sales 
GROUP BY pizza_category;

--top 5 best sellers w.r.t total pizzas sold
SELECT
TOP 5 pizza_name,
SUM(quantity) AS total_pizza_sold
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC;


--bottom 5 total pizzas sold
SELECT
TOP 5 pizza_name,
SUM(quantity) AS total_pizza_sold
FROM pizza_sales 
GROUP BY pizza_name
ORDER BY SUM(quantity);


