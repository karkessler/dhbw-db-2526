-------------------------------------------------
--- Szenario 2: c-c:
--- 1. Männer sind mit Frauen verheiratet oder nicht. 
--- 2. Männer und Frauen können nur einmal gleichzeitig verheiratet sein
-------------------------------------------------

-- -----------------------------------------------
CREATE TABLE Männer 
(MaNr INTEGER NOT NULL PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Vorname VARCHAR(50) NOT NULL);
-- ------------------------
CREATE TABLE Frauen 
(FrNr INTEGER NOT NULL PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Vorname VARCHAR(50) NOT NULL);
-- ------------------------
CREATE TABLE Ehepaar 
(MaNr INTEGER NOT NULL,
FrNr INTEGER NOT NULL,
FOREIGN KEY Ehepaar_Männer_FK (MaNr) REFERENCES Männer (MaNr),
FOREIGN KEY Ehepaar_Frauen_FK (FrNr) REFERENCES Frauen (FrNr),
PRIMARY KEY (MaNr, FrNr));
-- ------------------------
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (1,'Jan', 'Müller');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (2,'Peter', 'Meier');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (3,'Jürgen', 'Sturm');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (4,'Jens', 'Stark');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (5,'Kurt', 'Schmitt');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (6,'Oswald', 'Peterson');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (7,'Thomas', 'Schneider');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (8,'Axel', 'Mertens');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (9,'Michael', 'Hoffmeister');
INSERT INTO Männer (MaNr, Name, Vorname) 
VALUES (10,'Jonas', 'Meerbad');
-- ------------------------
INSERT INTO Frauen (FrNr, Name, Vorname) 
VALUES (11,'Julia', 'Bürkle');
INSERT INTO Frauen (FrNr, Name, Vorname) 
VALUES (22,'Iris', 'Mittermeier');
INSERT INTO Frauen (FrNr, Name, Vorname) 
VALUES (33,'Petra', 'Schnelle');
INSERT INTO Frauen (FrNr, Name, Vorname) 
VALUES (44,'Ruth', 'Stöhr');
INSERT INTO Frauen (FrNr, Name, Vorname) 
VALUES (55,'Michaela', 'Herb');
-- ------------------------
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (1, 1); -- was bedeutet das?
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (1, 2); -- was bedeutet das?
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (1, 55) -- was bedeutet das?
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (1, 55) -- was bedeutet das?
DELETE FROM Ehepaar WHERE MaNr = 1 AND FrNr = 55
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (2, 55) 
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (2, 55) 
-- -------------------------
CREATE TABLE Ehepaar 
(MaNr INTEGER NOT NULL,
FrNr INTEGER NOT NULL,
FOREIGN KEY Ehepaar_Männer_FK (MaNr) REFERENCES Männer (MaNr),
FOREIGN KEY Ehepaar_Frauen_FK (FrNr) REFERENCES Frauen (FrNr),
PRIMARY KEY (MaNr, FrNr));
-- --------------------------
CREATE TABLE Ehepaar 
(MaNr INTEGER NOT NULL,
FrNr INTEGER NOT NULL,
FOREIGN KEY Ehepaar_Frauen_FK (FrNr) REFERENCES Frauen (FrNr),
PRIMARY KEY (MaNr));
-- -- FOREIGN KEY Ehepaar_Frauen_FK (FrNr) REFERENCES Frauen (FrNr) ON DELETE cascade, ---> löscht hier Reference, wenn Frau in Frauen gelöscht
----------------------------
-- CREATE TABLE Ehepaar 
-- (MaNr INTEGER NOT NULL,
-- FrNr INTEGER NOT NULL,
-- FOREIGN KEY Ehepaar_Männer_FK (MaNr) REFERENCES Männer (MaNr),
-- FOREIGN KEY Ehepaar_Frauen_FK (FrNr) REFERENCES Frauen (FrNr),
-- PRIMARY KEY (MaNr, FrNr));
-- ALTER TABLE Ehepaar modify column FrNr INTEGER UNIQUE;
-- ALTER TABLE Ehepaar modify column MaNr INTEGER UNIQUE;
----------------------------
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (2, 55) -- was bedeutet das?
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (2, 44) -- was bedeutet das?
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (2, 11) -- was bedeutet das?
INSERT INTO Ehepaar (MaNr, FrNr) VALUES (3, 11) 