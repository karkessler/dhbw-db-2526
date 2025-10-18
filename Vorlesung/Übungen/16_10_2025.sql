drop table IF EXISTS Hoeren;
drop table IF EXISTS Student;
drop table IF EXISTS Hochschule;
drop table IF EXISTS Vorlesung;

create table Hochschule
(HSNr integer primary key,
Bezeichnung varchar(50) not null,
Ort varchar(50),
PLZ integer unique);

create table Vorlesung
(VorlNr integer primary key,
Titel varchar(50),
SWS integer);

create table Student
(MatNr integer primary key,
Name varchar(50) not null,
Semester integer,
HS integer not null,
FOREIGN KEY (HS) REFERENCES Hochschule(HSNr));

create table Hoeren
(MatNr integer,
VorlNr integer,
foreign key Hoeren_Student_FK (MatNr) references Student (MatNr),
foreign key Hoeren_Vorlesung_FK (VorlNr) references Vorlesung (VorlNr),
primary key (MatNr, VorlNr)
);


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

insert into Vorlesung (VorlNr, Titel, SWS)
values (123, 'Funktionalanalysis', 4);
insert into Vorlesung (VorlNr, Titel, SWS)
values (456, 'Maßtheorie', 6);
insert into Vorlesung (VorlNr, Titel, SWS)
values (789, 'Partielle DGL', 4);

insert into Student (MatNr, Name, Semester, HS)
values (1,'Paul', 1, 11);
insert into Student (MatNr, Name, Semester, HS)
values (2,'Schmitt ', 8, 22  );
insert into Student (MatNr, Name, Semester, HS)
values (3,'Meier', 4, 22);
insert into Student (MatNr, Name, Semester, HS)
values (4,'Meier', 4, 33);

insert into Hoeren (MatNr, VorlNr) values (4, 123);

select * from Student;
select * from Hochschule;
select * from Vorlesung;