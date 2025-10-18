-------------------------------------------------
--- Szenario 1:
--- 1. Student besuchen Hochschule (n:1)
--- 2. Professoren halten Vorlesung (1:n)
--- 3. Student hören Vorlesung (n:m)
--- 4. Assistenen haben Vorgesetzte (n:1)
--- 5. Generalisierung: Doktorand is_a Angestellter 
--- 6. Student kann beliebig viele Autos besitzen, Auto hat entweder keinen oder einen Besitzer
-------------------------------------------------

-- -----------------------------------------------
CREATE TABLE Student 
(MatNr INTEGER NOT NULL,
Name VARCHAR(50) NOT NULL,
Semester INTEGER);
-- ------------------------
INSERT INTO Student (MatNr, Name, Semester)
VALUES (1,'Paul', 1);
INSERT INTO Student (MatNr, Name, Semester)
VALUES (2,'Schmitt ', 8);
INSERT INTO Student (MatNr, Name, Semester)
VALUES (3,'Meier', 4);
-- ------------------------
INSERT INTO Student (MatNr, Name, Semester)
VALUES (3,'Meier', 4); -- Problem: Redundanzen möglich
--------------------------
ALTER TABLE Student ADD CONSTRAINT Id_Student PRIMARY KEY (MatNr);
--------------------------
DELETE FROM Student WHERE Name = 'Meier' -- Problem: wie kann ich Student Meier löschen?
-- ALTER TABLE Student ADD ID INT AUTO_INCREMENT PRIMARY KEY;
-- DELETE FROM Student WHERE ID = 5;
-- oder: DELETE FROM Student WHERE Name = 'Meier' LIMIT 1;
-- ------------------------
DROP TABLE Student;
-- ------------------------
CREATE TABLE Student 
(MatNr INTEGER PRIMARY KEY, 
Name VARCHAR(50) NOT NULL,
Semester INTEGER);
-- ------------------------
CREATE TABLE Hochschule 
(HSNr INTEGER PRIMARY KEY,
Bezeichnung VARCHAR(50) NOT NULL,
Ort VARCHAR(50),
PLZ INTEGER UNIQUE); -- darf in der Tabelle nur 1x vorhanden sein
-- ------------------------
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (11,'DHBW Stuttgart', 'Stuttgart', 70245);
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (22,'DHBW Heilbronn', 'Heilbronn', 76584);
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (33,'TU Darmstadt', 'Darmstadt', 60125);
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (44,'Hochschule Bayern', 'München', 87312);
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (55,'Hochschule Franken', 'Nürnberg', 90285);
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (66,'Hochschule Hessen', 'Frankfurt', 60123);
-- ------------------------
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (22,'TU München', 'München', 83124); -- geht ja/nein?
-- ------------------------
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (77,'TU München', 'München', 87312); -- geht ja/nein?
-- ------------------------
INSERT INTO Hochschule (HSNr, Bezeichnung, Ort, PLZ)
VALUES (77,'TU München', 'München', 87313); -- geht ja/nein?
-- ------------------------
-- --> Problem: wie implementiere ich die Beziehung 'besucht'?
ALTER TABLE Student ADD CONSTRAINT Student_Hochschule_FK FOREIGN KEY (besuchtHS) REFERENCES Hochschule (HSNr) -- immer auf der n-Seite, sonst Redundanzen
-- ------------------------
ALTER TABLE Student ADD besuchtHS INTEGER NOT NULL; 
-- -- eigentlich: ALTER TABLE Student modify besuchtHS INTEGER NULL (da 1:n und nicht c:n)
-- ------------------------
-- im Editor auf 11/22/33 setzen (Apply klicken)
-- ------------------------
ALTER TABLE Student ADD CONSTRAINT Student_Hochschule_FK FOREIGN KEY (besuchtHS) REFERENCES Hochschule (HSNr) 
-- ------------------------
INSERT INTO Student (MatNr, Name, Semester)
VALUES (4,'Peter', 5); -- Problem kein DEFAULT   
INSERT INTO Student (MatNr, Name, Semester, besuchtHS)
VALUES (4,'Peter', 5, 99);
INSERT INTO Student (MatNr, Name, Semester, besuchtHS)
VALUES (4,'Peter', 5, 33);    
-- ------------------------
CREATE TABLE Professoren 
(PersNr INTEGER PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Rang VARCHAR(50),
Raum INTEGER UNIQUE);
-- ------------------------
INSERT INTO Professoren (PersNr, Name, Rang, Raum)
VALUES (12,'Oswald', 'Assi', 001);    
INSERT INTO Professoren (PersNr, Name, Rang, Raum)
VALUES (13,'Heinz', 'Boss', 001);    
INSERT INTO Professoren (PersNr, Name, Rang, Raum)
VALUES (13,'Heinz', 'Boss', 002);    
-- ------------------------
DROP TABLE Vorlesung;
-- ------------------------
CREATE TABLE Vorlesung 
(VorlNr INTEGER PRIMARY KEY,
Titel VARCHAR(50),
SWS INTEGER,
gelesenVon INTEGER NOT NULL); -- für die Beziehung 'lesen'
-- ------------------------
ALTER TABLE Vorlesung ADD CONSTRAINT Vorlesung_Professoren_FK FOREIGN KEY (gelesenVon) REFERENCES Professoren (PersNr)
--------------------------
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (123, 'Funktionalanalysis', 4, 13);    
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (456, 'Maßtheorie', 6, 13);    
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (456, 'Maßtheorie', 6, 12);    
-- ------------------------
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (789, 'Partielle DGL', 4, 12);     
-- ------------------------
CREATE TABLE Hören 
(MatNr INTEGER, VorlNr INTEGER,
FOREIGN KEY Hören_Student_FK (MatNr) REFERENCES Student (MatNr),
FOREIGN KEY Hören_Vorlesung_FK (VorlNr) REFERENCES Vorlesung (VorlNr)); -- Nicht hierarchische Beziehung in Mapping-Tabelle auslagern
-- ------------------------
INSERT INTO Hören (MatNr, VorlNr) VALUES (4, 123);
INSERT INTO Hören (MatNr, VorlNr) VALUES (4, 123);
INSERT INTO Hören (MatNr, VorlNr) VALUES (4, 123); -- Problem: kann man wiederholen
-- ------------------------
CREATE TABLE Hören 
(MatNr INTEGER, 
VorlNr INTEGER,
FOREIGN KEY Hören_Student_FK (MatNr) REFERENCES Student (MatNr),
FOREIGN KEY Hören_Vorlesung_FK (VorlNr) REFERENCES Vorlesung (VorlNr),
PRIMARY KEY (MatNr, VorlNr)
);

-- 12.10.2023

-- ------------------------
INSERT INTO Hören (MatNr, VorlNr) VALUES (4, 123);
-- ------------------------
INSERT INTO Hören (MatNr, VorlNr) VALUES (4, 123);
INSERT INTO Hören (MatNr, VorlNr) VALUES (1, 123);
INSERT INTO Hören (MatNr, VorlNr) VALUES (2, 123);
INSERT INTO Hören (MatNr, VorlNr) VALUES (2, 789);
INSERT INTO Hören (MatNr, VorlNr) VALUES (2, 789); -- Kann der Student die Vorlesung doppelt hören?
-- ------------------------
CREATE TABLE Assistenten 
(PersNr INTEGER PRIMARY KEY, 
Name VARCHAR(30) NOT NULL,
Fachgebiet VARCHAR(30),
istVorgesetzter INTEGER,
FOREIGN KEY Assistenten_Professoren_FK (istVorgesetzter) REFERENCES Professoren (PersNr));
-- ------------------------
INSERT INTO Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) VALUES (99, 'Franz', 'Wahrscheinlichkeitstheorie', 4548); ---> Falscher Vorgesetzte
INSERT INTO Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) VALUES (98, 'Franz', 'Wahrscheinlichkeitstheorie', 13);
INSERT INTO Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) VALUES (99, 'Franz', 'Wahrscheinlichkeitstheorie', 13); ---> 2 Vorgesetzte?
INSERT INTO Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) VALUES (98, 'Franz', 'Wahrscheinlichkeitstheorie', 13); ---> Prof hat mehrere Assis?
-- ------------------------
CREATE TABLE Angestellte  -- Obertyp
(PersNr INTEGER PRIMARY KEY, 
Name VARCHAR(30) NOT NULL
)
-- ------------------------
CREATE TABLE Doktoranden  -- Untertyp
(PersNr INTEGER PRIMARY KEY, 
Name VARCHAR(30) NOT NULL,
Thema VARCHAR(100),
FOREIGN KEY Doktoranden_Angestellte_FK (PersNr) REFERENCES Angestellte (PersNr)
)
-- -----------------------
INSERT INTO Doktoranden (PersNr, Name, Thema) VALUES (56, 'Merke', 'Die Nichtfortsetzbarkeit von Potenzreihen') -- Es gibt noch keine Angestellten
--------------------------
INSERT INTO Angestellte (PersNr, Name) VALUES (69, 'Doktorand') 
-- ------------------------
INSERT INTO Doktoranden (PersNr, Name, Thema) VALUES (69, 'Merke', 'Die Nichtfortsetzbarkeit von Potenzreihen') 
-- ------------------------
CREATE TABLE Autos
(AutoNr INTEGER PRIMARY KEY, 
Marke VARCHAR(20) NOT NULL,
Typ VARCHAR(20),
Baujahr INTEGER
)
-- -----------------------
INSERT INTO Autos (AutoNr, Marke, Typ, Baujahr) VALUES (87, 'VW', 'Golf', 2008);
INSERT INTO Autos (AutoNr, Marke, Typ, Baujahr) VALUES (89, 'Opel', 'Astra', 2008);
INSERT INTO Autos (AutoNr, Marke, Typ, Baujahr) VALUES (90, 'Honda', 'Civic', 2020);
INSERT INTO Autos (AutoNr, Marke, Typ, Baujahr) VALUES (91, 'Fiat', 'Punto', 2012);
-- ------------------------
CREATE TABLE Fahrzeughalter -- da c:mc nicht hierarchische Beziehung
(MatNr INTEGER,
AutoNr INTEGER,
FOREIGN KEY Fahrzeughalter_MatrNummer_FK (MatNr) REFERENCES Student (MatNr),
FOREIGN KEY Fahrzeughalter_Autonummer_FK (AutoNr) REFERENCES Autos (AutoNr)
)
-- ------------------------
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (22222, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (22222, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (22222, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (22222, 87);
-- ------------------------
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 87) ;
-- ------------------------
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 87); -- Student besitzt Auto mehrfach
-- ------------------------
DROP TABLE Fahrzeughalter;
-- ------------------------
CREATE TABLE Fahrzeughalter
(MatNr INTEGER,
AutoNr INTEGER,
FOREIGN KEY Fahrzeughalter_MatrNummer_FK (MatNr) REFERENCES Student (MatNr),
FOREIGN KEY Fahrzeughalter_Autonummer_FK (AutoNr) REFERENCES Autos (AutoNr),
PRIMARY KEY (AutoNr)
)
-- ------------------------
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (22222, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 87);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 88);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (1, 89);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (2, 89);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (2, 90);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (2, 91);
INSERT INTO Fahrzeughalter (MatNr, AutoNr) VALUES (3, 91); -- AutoNr ist PK
-- ------------------------