drop table IF EXISTS Hören;
drop table IF EXISTS studenten;
drop table IF EXISTS Hochschulen;
drop table IF EXISTS Vorlesungen;

create table Hochschulen
(HSNr integer primary key,
Bezeichnung varchar(50) not null,
Ort varchar(50),
PLZ integer unique);

create table Vorlesungen
(VorlNr integer primary key,
Titel varchar(50),
SWS integer);

create table Studenten
(MatNr integer primary key,
Name varchar(50) not null,
Semester integer,
HS integer not null,
FOREIGN KEY (HS) REFERENCES Hochschulen(HSNr));

create table Hören
(MatNr integer,
VorlNr integer,
foreign key Hören_Studenten_FK (MatNr) references Studenten (MatNr),
foreign key Hören_Vorlesungen_FK (VorlNr) references Vorlesungen (VorlNr),
primary key (MatNr, VorlNr)
);


insert into Hochschulen (HSNr, Bezeichnung, Ort, PLZ)
values (11,'DHBW Stuttgart', 'Stuttgart', 70245);
insert into Hochschulen (HSNr, Bezeichnung, Ort, PLZ)
values (22,'DHBW Heilbronn', 'Heilbronn', 76584);
insert into Hochschulen (HSNr, Bezeichnung, Ort, PLZ)
values (33,'TU Darmstadt', 'Darmstadt', 60125);
insert into Hochschulen (HSNr, Bezeichnung, Ort, PLZ)
values (44,'Hochschule Bayern', 'München', 87312);
insert into Hochschulen (HSNr, Bezeichnung, Ort, PLZ)
values (55,'Hochschule Franken', 'Nürnberg', 90285);
insert into Hochschulen (HSNr, Bezeichnung, Ort, PLZ)
values (66,'Hochschule Hessen', 'Frankfurt', 60123);

insert into Vorlesungen (VorlNr, Titel, SWS)
values (123, 'Funktionalanalysis', 4);
insert into Vorlesungen (VorlNr, Titel, SWS)
values (456, 'Maßtheorie', 6);
insert into Vorlesungen (VorlNr, Titel, SWS)
values (789, 'Partielle DGL', 4);

insert into Studenten (MatNr, Name, Semester, HS)
values (1,'Paul', 1, 11);
insert into Studenten (MatNr, Name, Semester, HS)
values (2,'Schmitt ', 8, 22  );
insert into Studenten (MatNr, Name, Semester, HS)
values (3,'Meier', 4, 22);
insert into Studenten (MatNr, Name, Semester, HS)
values (4,'Meier', 4, 33);

insert into Hören (MatNr, VorlNr) values (4, 123);

select * from studenten;
select * from Hochschulen;
select * from Vorlesungen;