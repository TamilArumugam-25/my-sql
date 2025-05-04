CREATE DATABASE ecommerce;
-- Use the database
USE ecommerce;
-- Customers Table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- Products Table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    description TEXT
);

-- Orders Table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Insert Sample Data

INSERT INTO customers (name, email, address) VALUES
('John Doe', 'john@example.com', '1234 Elm Street'),
('Jane Smith', 'jane@example.com', '5678 Oak Avenue'),
('Alice Johnson', 'alice@example.com', '9102 Pine Road');

INSERT INTO products (name, price, description) VALUES
('Product A', 50.00, 'This is product A'),
('Product B', 30.00, 'This is product B'),
('Product C', 20.00, 'This is product C');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-04-01', 100.00),
(2, '2025-04-05', 150.00),
(1, '2025-04-10', 75.00),
(3, '2025-04-12', 200.00);
