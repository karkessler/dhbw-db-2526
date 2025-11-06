-- Verschiedene Übungen zu den Vorlesungen

USE 25_26;

DROP TABLE IF EXISTS Hoeren;
DROP TABLE IF EXISTS Vorlesung;
DROP TABLE IF EXISTS Assistent;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Doktorand;
DROP TABLE IF EXISTS Angestellter;
DROP TABLE IF EXISTS Fahrzeughalter;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Auto;
drop table IF EXISTS Senior;
DROP TABLE IF EXISTS Hochschule;

CREATE TABLE Hochschule
(HSNr INTEGER PRIMARY KEY,
Bezeichnung VARCHAR(50) NOT NULL,
Ort VARCHAR(50),
PLZ INTEGER UNIQUE);

CREATE TABLE Vorlesung
(VorlNr INTEGER PRIMARY KEY,
Titel VARCHAR(50),
SWS INTEGER,
gelesenVon integer not null);

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

INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (1,'Paul', 1, 11);
INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (2,'Schmitt ', 8, 22  );
INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (3,'Meier', 4, 22);
INSERT INTO Student (MatNr, Name, Semester, HS)
VALUES (4,'Meier', 4, 33);

SELECT * FROM Student;
SELECT * FROM Hochschule;
SELECT * FROM Vorlesung;

-- 23.10.2025

create table Professor
(PersNr integer primary key,
Name varchar(50) not null,
Rang varchar(50),
Raum integer unique);

insert into Professor (PersNr, Name, Rang, Raum)
values (12,'Gauss', 'Chef', 1);
insert into Professor (PersNr, Name, Rang, Raum)
values (13,'Euler', 'Chef', 3);
insert into Professor (PersNr, Name, Rang, Raum)
values (14,'Lagrange', 'Chef', 7);
insert into Professor (PersNr, Name, Rang, Raum)
values (15,'Epsilon', 'Chef', 9);

INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (123, 'Funktionalanalysis', 4, 12);
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (456, 'Maßtheorie', 6, 13);
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (789, 'Partielle DGL', 4, 12);
INSERT INTO Vorlesung (VorlNr, Titel, SWS, gelesenVon)
VALUES (321, 'Analysis', 4, 15);

INSERT INTO Hoeren (MatNr, VorlNr) VALUES (4, 123);

create table Assistent
(PersNr integer primary key,
Name varchar(30) not null,
Fachgebiet varchar(30),
istVorgesetzter integer,
foreign key Assistent_Professor_FK (istVorgesetzter) references Professor (PersNr));
-- ------------------------
insert into Assistent (PersNr, Name, Fachgebiet, istVorgesetzter) values (99, 'Jacobi', 'Funktionen', 12);
insert into Assistent (PersNr, Name, Fachgebiet, istVorgesetzter) values (98, 'Hesse', 'Matrizen', 13);
-- ------------------------

Select * from Professor;
Select * from Assistent;

create table Angestellter  -- Obertyp
(PersNr integer primary key,
Name varchar(30) not null
);
-- ------------------------
create table Doktorand  -- Untertyp
(PersNr integer primary key,
Thema varchar(100),
foreign key Doktorand_Angestellter_FK (PersNr) references Angestellter (PersNr)
);
-- -----------------------
-- insert into Doktorand (PersNr, Name, Thema) values (56, 'Merke', 'Die Nichtfortsetzbarkeit von Potenzreihen'); -- Es gibt noch keine Angestellten
-- ------------------------
insert into Angestellter (PersNr, Name) values (69, 'Cauchy');
insert into Angestellter (PersNr, Name) values (70, 'Laplace');
insert into Angestellter (PersNr, Name) values (71, 'Hilbert');
-- ------------------------
insert into Doktorand (PersNr, Thema) values (69,  'Die Nichtfortsetzbarkeit von Potenzreihen');
insert into Doktorand (PersNr, Thema) values (70,  'Das Laplace-Experiment');
insert into Doktorand (PersNr, Thema) values (71,  'Axiome und Kongruenz');

select * from Doktorand;
select * from Angestellter;

SELECT d.PersNr, a.Name, d.Thema
FROM Doktorand d
JOIN Angestellter a ON a.PersNr = d.PersNr;

create table Auto
(AutoNr integer primary key,
Marke varchar(20) not null,
Typ varchar(20),
Baujahr integer
);
-- -----------------------
insert into Auto (AutoNr, Marke, Typ, Baujahr) values (87, 'VW', 'Golf', 2008);
insert into Auto (AutoNr, Marke, Typ, Baujahr) values (88, 'Mercdes', '500 SEL', 1974);
insert into Auto (AutoNr, Marke, Typ, Baujahr) values (89, 'Opel', 'Astra', 2008);
insert into Auto (AutoNr, Marke, Typ, Baujahr) values (90, 'Honda', 'Civic', 2020);
insert into Auto (AutoNr, Marke, Typ, Baujahr) values (91, 'Fiat', 'Punto', 2012);

create table Fahrzeughalter
(MatNr integer,
AutoNr integer,
foreign key Fahrzeughalter_MatrNummer_FK (MatNr) references Student (MatNr),
foreign key Fahrzeughalter_Autonummer_FK (AutoNr) references Auto (AutoNr),
primary key (AutoNr)
);

insert into Fahrzeughalter (MatNr, AutoNr) values (1, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 88);
-- insert into Fahrzeughalter (MatNr, AutoNr) values (1, 89);
insert into Fahrzeughalter (MatNr, AutoNr) values (2, 89);
insert into Fahrzeughalter (MatNr, AutoNr) values (2, 90);
insert into Fahrzeughalter (MatNr, AutoNr) values (2, 91);
-- insert into Fahrzeughalter (MatNr, AutoNr) values (3, 91);

SELECT
  s.Name        AS Halter,
  a.Marke,
  a.Typ,
  a.Baujahr
 -- CONCAT(a.Marke, ' ', a.Typ) AS Fahrzeugname
FROM Fahrzeughalter fh
JOIN Student s ON s.MatNr = fh.MatNr
JOIN Auto a    ON a.AutoNr = fh.AutoNr
ORDER BY s.Name, a.Marke, a.Typ;

