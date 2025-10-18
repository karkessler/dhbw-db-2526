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
create table Student 
(MatNr integer not null,
Name varchar(50) not null,
Semester integer);
-- ------------------------
insert into Student (MatNr, Name, Semester)
values (1,'Paul', 1);
insert into Student (MatNr, Name, Semester)
values (2,'Schmitt ', 8);
insert into Student (MatNr, Name, Semester)
values (3,'Meier', 4);
-- ------------------------
insert into Student (MatNr, Name, Semester)
values (3,'Meier', 4); -- Problem: Redundanzen möglich
--------------------------
alter table Student add constraint Id_Student primary key (MatNr);
--------------------------
delete from Student where Name = 'Meier' -- Problem: wie kann ich Student Meier löschen?
-- ALTER TABLE Student ADD ID INT AUTO_INCREMENT PRIMARY KEY;
-- DELETE FROM Student WHERE ID = 5;
-- oder: DELETE FROM Student WHERE Name = 'Meier' LIMIT 1;
-- ------------------------
drop table Student;
-- ------------------------
create table Student 
(MatNr integer primary key, 
Name varchar(50) not null,
Semester integer);
-- ------------------------
create table Hochschule 
(HSNr integer primary key,
Bezeichnung varchar(50) not null,
Ort varchar(50),
PLZ integer unique); -- darf in der Tabelle nur 1x vorhanden sein
-- ------------------------
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (11,'DHBW Stuttgart', 'Stuttgart', 70245);
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (22,'DHBW Heilbronn', 'Heilbronn', 76584);
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (33,'TU Darmstadt', 'Darmstadt', 60125);
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (44,'Hochschule Bayern', 'München', 87312);
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (55,'Hochschule Franken', 'Nürnberg', 90285);
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (66,'Hochschule Hessen', 'Frankfurt', 60123);
-- ------------------------
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (22,'TU München', 'München', 83124); -- geht ja/nein?
-- ------------------------
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (77,'TU München', 'München', 87312); -- geht ja/nein?
-- ------------------------
insert into Hochschule (HSNr, Bezeichnung, Ort, PLZ)
values (77,'TU München', 'München', 87313); -- geht ja/nein?
-- ------------------------
-- --> Problem: wie implementiere ich die Beziehung 'besucht'?
alter table Student add constraint Student_Hochschule_FK foreign key (besuchtHS) references Hochschule (HSNr) -- immer auf der n-Seite, sonst Redundanzen
-- ------------------------
alter table Student add besuchtHS integer not null; 
-- -- eigentlich: alter table Student modify besuchtHS integer null (da 1:n und nicht c:n)
-- ------------------------
-- im Editor auf 11/22/33 setzen (Apply klicken)
-- ------------------------
alter table Student add constraint Student_Hochschule_FK foreign key (besuchtHS) references Hochschule (HSNr) 
-- ------------------------
insert into Student (MatNr, Name, Semester)
values (4,'Peter', 5); -- Problem kein Default   
insert into Student (MatNr, Name, Semester, besuchtHS)
values (4,'Peter', 5, 99);
insert into Student (MatNr, Name, Semester, besuchtHS)
values (4,'Peter', 5, 33);    
-- ------------------------
create table Professoren 
(PersNr integer primary key,
Name varchar(50) not null,
Rang varchar(50),
Raum integer unique);
-- ------------------------
insert into Professoren (PersNr, Name, Rang, Raum)
values (12,'Oswald', 'Assi', 001);    
insert into Professoren (PersNr, Name, Rang, Raum)
values (13,'Heinz', 'Boss', 001);    
insert into Professoren (PersNr, Name, Rang, Raum)
values (13,'Heinz', 'Boss', 002);    
-- ------------------------
drop table Vorlesung;
-- ------------------------
create table Vorlesung 
(VorlNr integer primary key,
Titel varchar(50),
SWS integer,
gelesenVon integer not null); -- für die Beziehung 'lesen'
-- ------------------------
alter table Vorlesung add constraint Vorlesung_Professoren_FK foreign key (gelesenVon) references Professoren (PersNr)
--------------------------
insert into Vorlesung (VorlNr, Titel, SWS, gelesenVon)
values (123, 'Funktionalanalysis', 4, 13);    
insert into Vorlesung (VorlNr, Titel, SWS, gelesenVon)
values (456, 'Maßtheorie', 6, 13);    
insert into Vorlesung (VorlNr, Titel, SWS, gelesenVon)
values (456, 'Maßtheorie', 6, 12);    
-- ------------------------
insert into Vorlesung (VorlNr, Titel, SWS, gelesenVon)
values (789, 'Partielle DGL', 4, 12);     
-- ------------------------
create table Hören 
(MatNr integer, VorlNr integer,
foreign key Hören_Student_FK (MatNr) references Student (MatNr),
foreign key Hören_Vorlesung_FK (VorlNr) references Vorlesung (VorlNr)); -- Nicht hierarchische Beziehung in Mapping-Tabelle auslagern
-- ------------------------
insert into Hören (MatNr, VorlNr) values (4, 123);
insert into Hören (MatNr, VorlNr) values (4, 123);
insert into Hören (MatNr, VorlNr) values (4, 123); -- Problem: kann man wiederholen
-- ------------------------
create table Hören 
(MatNr integer, 
VorlNr integer,
foreign key Hören_Student_FK (MatNr) references Student (MatNr),
foreign key Hören_Vorlesung_FK (VorlNr) references Vorlesung (VorlNr),
primary key (MatNr, VorlNr)
);

-- 12.10.2023

-- ------------------------
insert into Hören (MatNr, VorlNr) values (4, 123);
-- ------------------------
insert into Hören (MatNr, VorlNr) values (4, 123);
insert into Hören (MatNr, VorlNr) values (1, 123);
insert into Hören (MatNr, VorlNr) values (2, 123);
insert into Hören (MatNr, VorlNr) values (2, 789);
insert into Hören (MatNr, VorlNr) values (2, 789); -- Kann der Student die Vorlesung doppelt hören?
-- ------------------------
create table Assistenten 
(PersNr integer primary key, 
Name varchar(30) not null,
Fachgebiet varchar(30),
istVorgesetzter integer,
foreign key Assistenten_Professoren_FK (istVorgesetzter) references Professoren (PersNr));
-- ------------------------
insert into Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) values (99, 'Franz', 'Wahrscheinlichkeitstheorie', 4548); ---> Falscher Vorgesetzte
insert into Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) values (98, 'Franz', 'Wahrscheinlichkeitstheorie', 13);
insert into Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) values (99, 'Franz', 'Wahrscheinlichkeitstheorie', 13); ---> 2 Vorgesetzte?
insert into Assistenten (PersNr, Name, Fachgebiet, istVorgesetzter) values (98, 'Franz', 'Wahrscheinlichkeitstheorie', 13); ---> Prof hat mehrere Assis?
-- ------------------------
create table Angestellte  -- Obertyp
(PersNr integer primary key, 
Name varchar(30) not null
)
-- ------------------------
create table Doktoranden  -- Untertyp
(PersNr integer primary key, 
Name varchar(30) not null,
Thema varchar(100),
foreign key Doktoranden_Angestellte_FK (PersNr) references Angestellte (PersNr)
)
-- -----------------------
insert into Doktoranden (PersNr, Name, Thema) values (56, 'Merke', 'Die Nichtfortsetzbarkeit von Potenzreihen') -- Es gibt noch keine Angestellten
--------------------------
insert into Angestellte (PersNr, Name) values (69, 'Doktorand') 
-- ------------------------
insert into Doktoranden (PersNr, Name, Thema) values (69, 'Merke', 'Die Nichtfortsetzbarkeit von Potenzreihen') 
-- ------------------------
create table Autos
(AutoNr integer primary key, 
Marke varchar(20) not null,
Typ varchar(20),
Baujahr integer
)
-- -----------------------
insert into Autos (AutoNr, Marke, Typ, Baujahr) values (87, 'VW', 'Golf', 2008);
insert into Autos (AutoNr, Marke, Typ, Baujahr) values (89, 'Opel', 'Astra', 2008);
insert into Autos (AutoNr, Marke, Typ, Baujahr) values (90, 'Honda', 'Civic', 2020);
insert into Autos (AutoNr, Marke, Typ, Baujahr) values (91, 'Fiat', 'Punto', 2012);
-- ------------------------
create table Fahrzeughalter -- da c:mc nicht hierarchische Beziehung
(MatNr integer,
AutoNr integer,
foreign key Fahrzeughalter_MatrNummer_FK (MatNr) references Student (MatNr),
foreign key Fahrzeughalter_Autonummer_FK (AutoNr) references Autos (AutoNr)
)
-- ------------------------
insert into Fahrzeughalter (MatNr, AutoNr) values (22222, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (22222, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (22222, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (22222, 87);
-- ------------------------
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 87) ;
-- ------------------------
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 87); -- Student besitzt Auto mehrfach
-- ------------------------
drop table Fahrzeughalter;
-- ------------------------
create table Fahrzeughalter
(MatNr integer,
AutoNr integer,
foreign key Fahrzeughalter_MatrNummer_FK (MatNr) references Student (MatNr),
foreign key Fahrzeughalter_Autonummer_FK (AutoNr) references Autos (AutoNr),
primary key (AutoNr)
)
-- ------------------------
insert into Fahrzeughalter (MatNr, AutoNr) values (22222, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 87);
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 88);
insert into Fahrzeughalter (MatNr, AutoNr) values (1, 89);
insert into Fahrzeughalter (MatNr, AutoNr) values (2, 89);
insert into Fahrzeughalter (MatNr, AutoNr) values (2, 90);
insert into Fahrzeughalter (MatNr, AutoNr) values (2, 91);
insert into Fahrzeughalter (MatNr, AutoNr) values (3, 91); -- AutoNr ist PK
-- ------------------------