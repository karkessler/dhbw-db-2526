USE dhbw_optimierung_demo;

-- =========================================================
-- DEMO 1: Abfrage ohne Index
-- Erwartung: MySQL muss viele Zeilen lesen.
-- In EXPLAIN ist oft type = ALL sichtbar.
-- =========================================================
EXPLAIN
SELECT * FROM orders
WHERE order_date > '2024-01-01';

-- Index auf die Suchspalte anlegen.
-- Dadurch kann MySQL gezielt nach order_date suchen.
CREATE INDEX idx_order_date ON orders(order_date);

-- Gleiche Abfrage erneut prüfen.
-- Erwartung: Der Index wird verwendet.
-- In EXPLAIN sollte key = idx_order_date erscheinen.
EXPLAIN
SELECT * FROM orders
WHERE order_date > '2024-01-01';


-- =========================================================
-- DEMO 2: Zusammengesetzter Index
-- Suche nach category_id und price.
-- Ohne passenden Index muss MySQL mehr Daten durchsuchen.
-- =========================================================
EXPLAIN
SELECT product_name, price
FROM products
WHERE category_id = 1 AND price > 50;

-- Zusammengesetzter Index:
-- Gleichheitsbedingung zuerst, Bereichsbedingung danach.
CREATE INDEX idx_cat_price ON products(category_id, price);

-- Erwartung: MySQL kann den Index für category_id und price nutzen.
EXPLAIN
SELECT product_name, price
FROM products
WHERE category_id = 1 AND price > 50;


-- =========================================================
-- DEMO 3: Funktion auf Spalte verhindert oft Indexnutzung
-- YEAR(order_date) muss für viele Zeilen berechnet werden.
-- =========================================================
EXPLAIN
SELECT * FROM orders
WHERE YEAR(order_date) = 2024;

-- Besser: Datumsbereich direkt formulieren.
-- So bleibt die Spalte unverändert und der Index ist nutzbar.
EXPLAIN
SELECT * FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';


-- =========================================================
-- DEMO 4: OR-Bedingungen können ungünstig sein
-- Besonders wenn unterschiedliche Spalten betroffen sind.
-- =========================================================
EXPLAIN
SELECT * FROM products
WHERE product_name = 'Produkt 100' OR category_id = 1;

-- Alternative: UNION ALL.
-- Jeder Teil kann separat optimiert werden.
EXPLAIN
SELECT * FROM products
WHERE product_name = 'Produkt 100'
UNION ALL
SELECT * FROM products
WHERE category_id = 1;


-- =========================================================
-- DEMO 5: JOIN-Optimierung
-- Join über Primärschlüssel/Fremdschlüssel.
-- Wichtig: Join-Spalten sollten indiziert sein.
-- =========================================================
EXPLAIN
SELECT c.name, o.total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;


-- =========================================================
-- DEMO 6: Partitionierung
-- Daten werden logisch in Bereiche aufgeteilt.
-- MySQL kann irrelevante Partitionen überspringen.
-- =========================================================
CREATE TABLE log_entries (
    id INT AUTO_INCREMENT,
    log_date DATE NOT NULL,
    PRIMARY KEY(id, log_date)
)
PARTITION BY RANGE COLUMNS(log_date)(
    PARTITION p2024 VALUES LESS THAN ('2025-01-01'),
    PARTITION pmax VALUES LESS THAN (MAXVALUE)
);

-- Erwartung: MySQL liest nur passende Partitionen.
EXPLAIN
SELECT * FROM log_entries
WHERE log_date > '2024-06-01';


-- =========================================================
-- DEMO 7: Prepared Statement
-- SQL-Anweisung und Parameter werden getrennt.
-- Vorteil: Schutz vor SQL Injection und bessere Wiederverwendung.
-- =========================================================
PREPARE stmt FROM 'SELECT * FROM customers WHERE name = ?';

-- Parameter setzen
SET @n = 'Kunde 10';

-- Statement mit Parameter ausführen
EXECUTE stmt USING @n;

-- Prepared Statement wieder freigeben
DEALLOCATE PREPARE stmt;