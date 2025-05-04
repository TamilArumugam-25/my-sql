
-- Step 1: Create the Database
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Step 2: Create Tables

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- Products Table
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    description TEXT
);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Step 3: Insert Sample Data

INSERT INTO customers (name, email, address) VALUES
('John Doe', 'john@example.com', '1234 Elm Street'),
('Jane Smith', 'jane@example.com', '5678 Oak Avenue'),
('Alice Johnson', 'alice@example.com', '9102 Pine Road');

INSERT INTO products (name, price, description) VALUES
('Product A', 50.00, 'This is product A'),
('Product B', 30.00, 'This is product B'),
('Product C', 20.00, 'This is product C');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, CURDATE() - INTERVAL 10 DAY, 100.00),
(2, CURDATE() - INTERVAL 5 DAY, 150.00),
(1, CURDATE() - INTERVAL 20 DAY, 75.00),
(3, CURDATE() - INTERVAL 40 DAY, 200.00);


-- 1. Customers who placed an order in last 30 days
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

-- 2. Total order amount by each customer
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id;

-- 3. Update price of Product C to 45.00
UPDATE products SET price = 45.00 WHERE name = 'Product C';

-- 4. Add discount column to products
ALTER TABLE products ADD COLUMN discount DECIMAL(5,2) DEFAULT 0.00;

-- 5. Top 3 most expensive products
SELECT * FROM products ORDER BY price DESC LIMIT 3;

-- 6. Names of customers who ordered Product A
-- First, we normalize with order_items
CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert order items sample
INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 3, 4);

-- Now, query customers who ordered Product A
SELECT DISTINCT c.name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Product A';

-- 7. Customer name and order date (join orders and customers)
SELECT c.name, o.order_date
FROM customers c
JOIN orders o ON c.id = o.customer_id;

-- 8. Orders with total amount > 150
SELECT * FROM orders WHERE total_amount > 150;

-- 9. Retrieve average total of all orders
SELECT AVG(total_amount) AS average_order_total FROM orders;
