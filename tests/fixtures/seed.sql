DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  category VARCHAR(50) NOT NULL
);

INSERT INTO products (id, name, price, category) VALUES
  (1, 'Widget A', 10.00, 'tools'),
  (2, 'Widget B', 12.50, 'tools'),
  (3, 'Cable X',  5.90,  'cables'),
  (4, 'Cable Y',  8.10,  'cables'),
  (5, 'Adapter',  7.00,  'accessories');
