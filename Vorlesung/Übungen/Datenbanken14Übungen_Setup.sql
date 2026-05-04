-- =========================================================
-- SETUP: Datenbank + Tabellen + Testdaten
-- Einmal ausführen
-- =========================================================

DROP DATABASE IF EXISTS dhbw_optimierung_demo;
CREATE DATABASE dhbw_optimierung_demo CHARACTER SET utf8mb4;
USE dhbw_optimierung_demo;

SET SESSION cte_max_recursion_depth = 100000;

-- Tabellen
CREATE TABLE customers (
    customer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    status ENUM('active','inactive') DEFAULT 'active'
);

CREATE TABLE orders (
    order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNSIGNED,
    order_date DATE,
    status ENUM('new','paid','shipped','cancelled'),
    total DECIMAL(10,2),
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10,2)
);

-- Daten (kleiner halten für Demo!)
INSERT INTO customers (name, city)
SELECT CONCAT('Kunde ', n), 'Stuttgart'
FROM (
    WITH RECURSIVE seq AS (
        SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n < 1000
    ) SELECT n FROM seq
) s;

INSERT INTO products (product_name, category_id, price)
SELECT CONCAT('Produkt ', n), 1, RAND()*100
FROM (
    WITH RECURSIVE seq AS (
        SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n < 5000
    ) SELECT n FROM seq
) s;

INSERT INTO orders (customer_id, order_date, status, total, amount)
SELECT
    1 + (n % 1000),
    DATE_ADD('2022-01-01', INTERVAL n DAY),
    'shipped',
    RAND()*1000,
    RAND()*1000
FROM (
    WITH RECURSIVE seq AS (
        SELECT 1 n UNION ALL SELECT n+1 FROM seq WHERE n < 20000
    ) SELECT n FROM seq
) s;

ANALYZE TABLE customers, orders, products;