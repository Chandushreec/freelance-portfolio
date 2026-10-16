CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(100)
);
INSERT INTO customers (customer_id, customer_name, city, email)
VALUES
(101, 'Arun Kumar', 'Bangalore', 'arun.kumar@gmail.com'),
(102, 'Priya Sharma', 'Mysore', 'priya.sharma@gmail.com'),
(103, 'Rahul Verma', 'Chennai', 'rahul.verma@gmail.com'),
(104, 'Sneha Patel', 'Mumbai', 'sneha.patel@gmail.com'),
(105, 'Kiran Das', 'Hyderabad', 'kiran.das@gmail.com'),
(106, 'Anita Singh', 'Bangalore', 'anita.singh@gmail.com'),
(107, 'Vijay Kumar', 'Mysore', 'vijay.kumar@gmail.com'),
(108, 'Meena Joshi', 'Pune', 'meena.joshi@gmail.com'),
(109, 'Ravi Shetty', 'Mangalore', 'ravi.shetty@gmail.com'),
(110, 'Pooja Nair', 'Kochi', 'pooja.nair@gmail.com');

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO products (product_id, product_name, category, price)
VALUES
(201, 'Laptop', 'Electronics', 65000.00),
(202, 'Smartphone', 'Electronics', 30000.00),
(203, 'Headphones', 'Accessories', 2500.00),
(204, 'Keyboard', 'Accessories', 1500.00),
(205, 'Mouse', 'Accessories', 800.00),
(206, 'Monitor', 'Electronics', 18000.00),
(207, 'Printer', 'Electronics', 12000.00),
(208, 'USB Cable', 'Accessories', 500.00),
(209, 'Webcam', 'Electronics', 3500.00),
(210, 'Laptop Bag', 'Accessories', 2000.00);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders (order_id, customer_id, order_date, order_status)
VALUES
(1001, 101, '2026-01-05', 'Completed'),
(1002, 102, '2026-01-08', 'Completed'),
(1003, 103, '2026-01-12', 'Pending'),
(1004, 104, '2026-01-15', 'Completed'),
(1005, 105, '2026-01-20', 'Cancelled'),
(1006, 101, '2026-02-02', 'Completed'),
(1007, 106, '2026-02-05', 'Completed'),
(1008, 107, '2026-02-10', 'Pending'),
(1009, 108, '2026-02-14', 'Completed'),
(1010, 109, '2026-02-18', 'Completed'),
(1011, 110, '2026-02-22', 'Completed'),
(1012, 102, '2026-03-01', 'Completed'),
(1013, 103, '2026-03-05', 'Cancelled'),
(1014, 105, '2026-03-10', 'Completed'),
(1015, 101, '2026-03-15', 'Completed');

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO order_details (order_detail_id, order_id, product_id, quantity)
VALUES
(1, 1001, 201, 1),
(2, 1002, 203, 2),
(3, 1003, 202, 1),
(4, 1004, 206, 1),
(5, 1005, 205, 3),
(6, 1006, 204, 2),
(7, 1007, 207, 1),
(8, 1008, 208, 4),
(9, 1009, 209, 1),
(10, 1010, 210, 2),
(11, 1011, 201, 1),
(12, 1012, 202, 1),
(13, 1013, 203, 1),
(14, 1014, 206, 2),
(15, 1015, 205, 2),
(16, 1001, 205, 2),
(17, 1004, 208, 3),
(18, 1006, 210, 1),
(19, 1007, 203, 2),
(20, 1014, 204, 1);

SHOW TABLES;
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT COUNT(*) AS total_products
FROM products;
SELECT COUNT(*) AS total_orders
FROM orders;
SELECT COUNT(*) AS total_order_details
FROM order_details;
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

SELECT
    SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM order_details od
JOIN products p
    ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;

SELECT
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT
    c.customer_name,
    p.product_name,
    od.quantity,
    p.price,
    (p.price * od.quantity) AS line_total
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
ORDER BY c.customer_name;

SELECT
    AVG(price) AS average_product_price
FROM products;

SELECT
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 1;

SELECT
    product_name,
    price
FROM products
ORDER BY price ASC
LIMIT 1;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    SUM(p.price * od.quantity) AS completed_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed';

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS completed_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
ORDER BY completed_spending DESC;

SELECT
    AVG(order_total) AS average_order_value
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

SELECT
    o.order_id,
    SUM(p.price * od.quantity) AS order_total
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_id
ORDER BY order_total DESC
LIMIT 1;

SELECT
    c.city,
    SUM(p.price * od.quantity) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    p.category,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;

SELECT
    p.category,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_name
HAVING SUM(p.price * od.quantity) > 20000
ORDER BY total_spending DESC;

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 1;

SELECT
    AVG(order_quantity) AS average_quantity_per_order
FROM (
    SELECT
        order_id,
        SUM(quantity) AS order_quantity
    FROM order_details
    GROUP BY order_id
) AS order_quantities;

SELECT
    product_name,
    price
FROM products
ORDER BY price DESC
LIMIT 1;

SELECT
    product_name,
    price
FROM products
ORDER BY price ASC
LIMIT 1;

SELECT
    AVG(price) AS average_product_price
FROM products;

SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
)
ORDER BY price DESC;

SELECT
    o.order_id,
    SUM(p.price * od.quantity) AS order_total
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_id
ORDER BY order_total DESC;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    SUM(p.price * od.quantity) AS completed_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed';

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS completed_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
ORDER BY completed_spending DESC;

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders
GROUP BY order_status
ORDER BY percentage DESC;

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(p.price * od.quantity) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

SELECT
    SUM(quantity) AS total_quantity_sold
FROM order_details;

SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT
    o.order_status,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_status
ORDER BY total_sales DESC;

SELECT
    AVG(order_total) AS average_completed_order_value
FROM (
    SELECT
        o.order_id,
        SUM(p.price * od.quantity) AS order_total
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.order_id
) AS completed_orders;

SELECT
    o.order_id,
    SUM(p.price * od.quantity) AS order_total
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY o.order_id
ORDER BY order_total DESC
LIMIT 1;

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 3;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 3;

SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;

SELECT
    p.category,
    o.order_status,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
JOIN orders o
    ON od.order_id = o.order_id
GROUP BY p.category, o.order_status
ORDER BY p.category, total_sales DESC;

SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

SELECT
    c.city,
    SUM(p.price * od.quantity) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    category,
    AVG(price) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

SELECT
    category,
    product_name,
    price
FROM products p
WHERE price = (
    SELECT MIN(p2.price)
    FROM products p2
    WHERE p2.category = p.category
)
ORDER BY price ASC;

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

SELECT
    category,
    COUNT(*) AS total_products
FROM products
GROUP BY category
ORDER BY total_products DESC;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS completed_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_name
ORDER BY completed_orders DESC;

SELECT
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
    AND o.order_status = 'Completed'
WHERE o.order_id IS NULL;

SELECT
    ROUND(
        COUNT(CASE WHEN order_status = 'Completed' THEN 1 END)
        * 100.0 / COUNT(*),
        2
    ) AS completed_order_percentage
FROM orders;

SELECT
    ROUND(
        COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END)
        * 100.0 / COUNT(*),
        2
    ) AS cancelled_order_percentage
FROM orders;

SELECT
    ROUND(
        COUNT(CASE WHEN order_status = 'Pending' THEN 1 END)
        * 100.0 / COUNT(*),
        2
    ) AS pending_order_percentage
FROM orders;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * od.quantity) AS completed_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    p.category,
    SUM(p.price * od.quantity) AS total_sales
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.category
ORDER BY total_sales ASC
LIMIT 1;

SELECT
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

SELECT
    c.customer_id,
    c.customer_name,
    SUM(p.price * od.quantity) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

SELECT
    AVG(customer_revenue) AS average_revenue_per_customer
FROM (
    SELECT
        c.customer_id,
        SUM(p.price * od.quantity) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    GROUP BY c.customer_id
) AS customer_sales;

SELECT
    AVG(total_orders) AS average_orders_per_customer
FROM (
    SELECT
        c.customer_id,
        COUNT(o.order_id) AS total_orders
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
) AS customer_orders;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

SELECT
    category,
    ROUND(AVG(price), 2) AS average_price
FROM products
GROUP BY category
ORDER BY average_price DESC;

SELECT
    category,
    product_name,
    price
FROM products p
WHERE price = (
    SELECT MAX(p2.price)
    FROM products p2
    WHERE p2.category = p.category
)
ORDER BY price DESC;

SELECT
    category,
    product_name,
    price
FROM products p
WHERE price = (
    SELECT MIN(p2.price)
    FROM products p2
    WHERE p2.category = p.category
)
ORDER BY price ASC;

SELECT
    c.customer_name,
    SUM(od.quantity) AS total_quantity_purchased
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY total_quantity_purchased DESC;

SELECT
    c.customer_name,
    SUM(od.quantity) AS total_quantity_purchased
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY total_quantity_purchased DESC
LIMIT 1;

SELECT
    c.city,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    SUM(p.price * od.quantity) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC;

SELECT
    c.city,
    ROUND(SUM(p.price * od.quantity) / COUNT(DISTINCT c.customer_id), 2) AS average_customer_spending
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY average_customer_spending DESC;

SELECT
    c.city,
    SUM(p.price * od.quantity) AS total_sales
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.city
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY sales_month
ORDER BY total_sales DESC
LIMIT 1;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY sales_month
ORDER BY total_sales ASC
LIMIT 1;

SELECT
    COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'Completed';

SELECT
    COUNT(*) AS pending_orders
FROM orders
WHERE order_status = 'Pending';

SELECT
    COUNT(*) AS cancelled_orders
FROM orders
WHERE order_status = 'Cancelled';

SELECT
    SUM(p.price * od.quantity) AS pending_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Pending';

SELECT
    SUM(p.price * od.quantity) AS cancelled_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
WHERE o.order_status = 'Cancelled';

SELECT
    ROUND(
        SUM(CASE WHEN o.order_status = 'Completed'
                 THEN p.price * od.quantity ELSE 0 END)
        * 100.0
        / SUM(p.price * od.quantity),
        2
    ) AS completed_sales_percentage
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id;

SELECT
    ROUND(
        SUM(CASE WHEN o.order_status = 'Pending'
                 THEN p.price * od.quantity ELSE 0 END)
        * 100.0
        / SUM(p.price * od.quantity),
        2
    ) AS pending_sales_percentage
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id;

SELECT
    ROUND(
        SUM(CASE WHEN o.order_status = 'Cancelled'
                 THEN p.price * od.quantity ELSE 0 END)
        * 100.0
        / SUM(p.price * od.quantity),
        2
    ) AS cancelled_sales_percentage
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id;

SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.price * od.quantity) AS total_sales
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_status
ORDER BY total_sales DESC;

SELECT
    o.order_status,
    ROUND(SUM(p.price * od.quantity) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_status
ORDER BY average_order_value DESC;

SELECT
    o.order_status,
    ROUND(SUM(p.price * od.quantity) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY o.order_status
ORDER BY average_order_value DESC;

SELECT
    category,
    product_name,
    total_sales
FROM (
    SELECT
        p.category,
        p.product_name,
        SUM(p.price * od.quantity) AS total_sales,
        RANK() OVER (
            PARTITION BY p.category
            ORDER BY SUM(p.price * od.quantity) DESC
        ) AS sales_rank
    FROM products p
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY p.category, p.product_name
) AS ranked_products
WHERE sales_rank = 1
ORDER BY total_sales DESC;

SELECT
    category,
    product_name,
    total_sales
FROM (
    SELECT
        p.category,
        p.product_name,
        SUM(p.price * od.quantity) AS total_sales,
        RANK() OVER (
            PARTITION BY p.category
            ORDER BY SUM(p.price * od.quantity) DESC
        ) AS sales_rank
    FROM products p
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY p.category, p.product_name
) AS ranked_products
WHERE sales_rank = 1
ORDER BY total_sales DESC;

SELECT
    city,
    customer_name,
    total_spending
FROM (
    SELECT
        c.city,
        c.customer_name,
        SUM(p.price * od.quantity) AS total_spending,
        RANK() OVER (
            PARTITION BY c.city
            ORDER BY SUM(p.price * od.quantity) DESC
        ) AS spending_rank
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    GROUP BY c.city, c.customer_name
) AS ranked_customers
WHERE spending_rank = 1
ORDER BY total_spending DESC;

SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    ROUND(
        SUM(p.price * od.quantity) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    sales_month,
    order_id,
    order_total
FROM (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        o.order_id,
        SUM(p.price * od.quantity) AS order_total,
        RANK() OVER (
            PARTITION BY DATE_FORMAT(o.order_date, '%Y-%m')
            ORDER BY SUM(p.price * od.quantity) DESC
        ) AS order_rank
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN products p
        ON od.product_id = p.product_id
    GROUP BY
        DATE_FORMAT(o.order_date, '%Y-%m'),
        o.order_id
) AS monthly_orders
WHERE order_rank = 1
ORDER BY sales_month;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales,
    ROUND(
        SUM(p.price * od.quantity) * 100.0 /
        (SELECT SUM(p2.price * od2.quantity)
         FROM products p2
         JOIN order_details od2
             ON p2.product_id = od2.product_id),
        2
    ) AS sales_percentage
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS total_sales,
    ROUND(
        SUM(p.price * od.quantity) * 100.0 /
        (SELECT SUM(p2.price * od2.quantity)
         FROM products p2
         JOIN order_details od2
             ON p2.product_id = od2.product_id),
        2
    ) AS sales_percentage
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 3;

SELECT
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spending,
    ROUND(
        SUM(p.price * od.quantity) * 100.0 /
        (SELECT SUM(p2.price * od2.quantity)
         FROM products p2
         JOIN order_details od2
             ON p2.product_id = od2.product_id),
        2
    ) AS spending_percentage
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
JOIN products p
    ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spending DESC
LIMIT 3;

SELECT
    COUNT(DISTINCT product_id) AS unique_products_ordered
FROM order_details;

SELECT
    c.customer_name,
    COUNT(DISTINCT od.product_id) AS unique_products_purchased
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_details od
    ON o.order_id = od.order_id
GROUP BY c.customer_name
ORDER BY unique_products_purchased DESC;

SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT SUM(quantity) FROM order_details) AS total_units_sold,
    (SELECT SUM(p.price * od.quantity)
     FROM products p
     JOIN order_details od
         ON p.product_id = od.product_id) AS total_sales,
    (SELECT COUNT(*)
     FROM orders
     WHERE order_status = 'Completed') AS completed_orders;

     