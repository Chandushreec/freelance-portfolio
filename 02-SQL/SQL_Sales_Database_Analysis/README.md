# SQL Sales Database Analysis

## Project Overview

This project is a SQL-based sales database analysis project created using MySQL.

The project demonstrates how to create a relational sales database, store customer, product, order, and order-detail information, and analyze the data using SQL queries.

## Tools & Technologies

- MySQL Server 8.4
- MySQL Workbench
- SQL
- GitHub

## Database Structure

The database is named `sales_analysis` and contains four tables:

### 1. Customers
Stores customer information such as:
- Customer ID
- Customer Name
- City
- Email

### 2. Products
Stores product information such as:
- Product ID
- Product Name
- Category
- Price

### 3. Orders
Stores order information such as:
- Order ID
- Customer ID
- Order Date
- Order Status

### 4. Order Details
Stores products included in each order, including:
- Order Detail ID
- Order ID
- Product ID
- Quantity

The tables use primary keys and foreign keys to maintain relationships between the data.

## SQL Concepts Demonstrated

This project demonstrates:

- SELECT
- WHERE
- ORDER BY
- ASC and DESC
- LIMIT
- COUNT()
- SUM()
- AVG()
- GROUP BY
- HAVING
- INNER JOIN
- LEFT JOIN
- CASE statements
- Subqueries
- Primary Keys
- Foreign Keys

## Analysis Performed

The SQL queries analyze:

- Customer information
- Customers by city
- Product prices
- Top-priced products
- Total customers and orders
- Total sales
- Sales by product
- Sales by category
- Average order value
- Products with sales above a selected threshold
- Number of orders by customer
- Customer spending on completed orders
- Customers with spending above a selected threshold
- Customers with no orders
- Order status categories
- Products priced above the average product price

## Project Files

### `database.sql`
Contains the database creation script, table definitions, and sample data.

### `analysis_queries.sql`
Contains the SQL queries used to analyze the sales database.

## Purpose

This project was created as a portfolio project to demonstrate practical SQL and data analysis skills, including database creation, relational data handling, joins, aggregations, filtering, and business-oriented analysis.

## Note

The SQL scripts are intended to be used with MySQL. The database setup script should be run on a fresh database environment when recreating the project.
