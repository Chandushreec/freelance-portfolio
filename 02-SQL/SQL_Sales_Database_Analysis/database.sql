-- ============================================
-- SQL Sales Database Analysis
-- Database Setup Script
-- ============================================

CREATE DATABASE IF NOT EXISTS sales_analysis;

USE sales_analysis;


-- ============================================
-- 1. Customers Table
-- ============================================

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


-- ============================================
-- 2. Products Table
-- ============================================

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


-- ============================================
-- 3. Orders Table
-- ============================================

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


-- ============================================
-- 4. Order Details Table
-- ============================================

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