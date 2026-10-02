USE sales_analysis;


-- =========================================
-- 1. View all customers
-- =========================================

SELECT *
FROM customers;


-- =========================================
-- 2. View customers and their cities
-- =========================================

SELECT customer_name, city
FROM customers;


-- =========================================
-- 3. Find customers from Bangalore
-- =========================================

SELECT customer_name, city
FROM customers
WHERE city = 'Bangalore';


-- =========================================
-- 4. Find customers from Mysore
-- =========================================

SELECT customer_name, city
FROM customers
WHERE city = 'Mysore';


-- =========================================
-- 5. Products sorted by highest price
-- =========================================

SELECT product_name, category, price
FROM products
ORDER BY price DESC;


-- =========================================
-- 6. Products sorted by lowest price
-- =========================================

SELECT product_name, category, price
FROM products
ORDER BY price ASC;


-- =========================================
-- 7. Top 3 most expensive products
-- =========================================

SELECT product_name, category, price
FROM products
ORDER BY price DESC
LIMIT 3;


-- =========================================
-- 8. Count total customers
-- =========================================

SELECT COUNT(*) AS total_customers
FROM customers;


-- =========================================
-- 9. Count total orders
-- =========================================

SELECT COUNT(*) AS total_orders
FROM orders;


-- =========================================
-- 10. Calculate total sales
-- =========================================

SELECT SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id;


-- =========================================
-- 11. Sales by product
-- =========================================

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;


-- =========================================
-- 12. Sales by category
-- =========================================

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;


-- =========================================
-- 13. Average order value
-- =========================================

SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(p.price * od.quantity) AS order_total
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    GROUP BY o.order_id
) AS order_values;


-- =========================================
-- 14. Products with sales greater than 5000
-- =========================================

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(p.price * od.quantity) > 5000
ORDER BY total_sales DESC;


-- =========================================
-- 15. Number of orders by customer
-- =========================================

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;


-- =========================================
-- 16. Total spending by customer
-- Only completed orders
-- =========================================

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;


-- =========================================
-- 17. Customers who spent more than 20000
-- =========================================

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(p.price * od.quantity) > 20000
ORDER BY total_spent DESC;


-- =========================================
-- 18. Customers with no orders
-- =========================================

SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- =========================================
-- 19. Categorize orders using CASE
-- =========================================

SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status = 'Completed' THEN 'Successful'
        WHEN order_status = 'Pending' THEN 'In Progress'
        WHEN order_status = 'Cancelled' THEN 'Unsuccessful'
        ELSE 'Unknown'
    END AS order_category
FROM orders;


-- =========================================
-- 20. Products priced above average
-- =========================================

SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;