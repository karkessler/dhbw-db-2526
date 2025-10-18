DROP TABLE IF EXISTS Hoeren;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Hochschule;
DROP TABLE IF EXISTS Vorlesung;

CREATE TABLE Hochschule
(HSNr INTEGER PRIMARY KEY,
Bezeichnung VARCHAR(50) NOT NULL,
Ort VARCHAR(50),
PLZ INTEGER UNIQUE);

CREATE TABLE Vorlesung
(VorlNr INTEGER PRIMARY KEY,
Titel VARCHAR(50),
SWS INTEGER);

CREATE TABLE Student
(MatNr INTEGER PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Semester INTEGER,
HS INTEGER NOT NULL,
FOREIGN KEY (HS) REFERENCES Hochschule(HSNr));

CREATE TABLE Hoeren
(MatNr INTEGER,
VorlNr INTEGER,
FOREIGN KEY Hoeren_Student_FK (MatNr) REFERENCES Student (MatNr),
FOREIGN KEY Hoeren_Vorlesung_FK (VorlNr) REFERENCES Vorlesung (VorlNr),
PRIMARY KEY (MatNr, VorlNr)
);


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

INSERT INTO Vorlesung (VorlNr, Titel, SWS)
VALUES (123, 'Funktionalanalysis', 4);
INSERT INTO Vorlesung (VorlNr, Titel, SWS)
VALUES (456, 'Maßtheorie', 6);
INSERT INTO Vorlesung (VorlNr, Titel, SWS)
VALUES (789, 'Partielle DGL', 4);

INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (1,'Paul', 1, 11);
INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (2,'Schmitt ', 8, 22  );
INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (3,'Meier', 4, 22);
INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (4,'Meier', 4, 33);

INSERT INTO Hoeren (MatNr, VorlNr) VALUES (4, 123);

SELECT * FROM Student;
SELECT * FROM Hochschule;
SELECT * FROM Vorlesung;