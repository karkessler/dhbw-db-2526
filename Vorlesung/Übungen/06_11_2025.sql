-- Relationale Division

USE 25_26;

DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Produkt;

CREATE TABLE Kunde (
  Kunde VARCHAR(50),
  Produkt VARCHAR(50)
);

INSERT INTO Kunde (Kunde, Produkt) VALUES
('Alice', 'Laptop'),
('Alice', 'Smartphone'),
('Bob', 'Laptop'),
('Bob', 'Tablet'),
('Carol', 'Laptop'),
('Carol', 'Smartphone'),
('Carol', 'Tablet');

CREATE TABLE Produkt (
  Produkt VARCHAR(50)
);

INSERT INTO Produkt (Produkt) VALUES
('Laptop'),
('Smartphone');

SELECT DISTINCT K1.Kunde as Kunde_1
FROM Kunde AS K1
WHERE NOT EXISTS (
    SELECT Produkt.Produkt
    FROM Produkt
    WHERE NOT EXISTS (
        SELECT 1
        FROM Kunde AS K2
        WHERE K2.Kunde = K1.Kunde
          AND K2.Produkt = Produkt.Produkt
    )
);

WITH
-- π_Kunde(B)
kunden AS (
  SELECT DISTINCT Kunde FROM Kunde
),

-- (π_Kunde(B) × P)   -- kartesisches Produkt
soll AS (
  SELECT k.Kunde, p.Produkt
  FROM kunden k
  CROSS JOIN Produkt p
),

-- (π_Kunde(B) × P) − B
fehlend AS (
  SELECT Kunde, Produkt FROM soll
  EXCEPT
  SELECT Kunde, Produkt FROM Kunde
),

-- π_Kunde( fehlend )   -- Kunden, denen etwas fehlt
fehlerkunden AS (
  SELECT DISTINCT Kunde FROM fehlend
),

-- π_Kunde(B) − π_Kunde( fehlend )
ergebnis AS (
  SELECT Kunde FROM kunden
  EXCEPT
  SELECT Kunde FROM fehlerkunden
)
SELECT * FROM ergebnis
ORDER BY Kunde;


