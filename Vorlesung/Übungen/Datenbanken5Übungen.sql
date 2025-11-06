-- -----------------------------------------------
-- Szenario: Relationale Algebra
-- -----------------------------------------------

USE 25_26;

-- 1. Selection:
SELECT Semester, Name FROM Student WHERE Semester = 1;

-- 2. Projektion:
SELECT Semester, Name FROM Student;
-- -- Duplicate?
insert into Student (MatNr, Name, Semester, HS)
values (14,'Peter', 5, 55);
--
SELECT DISTINCT Semester, Name FROM Student;

-- 3. Kreuzprodukt:
SELECT * FROM Student CROSS JOIN Professor;
SELECT * FROM Student, Professoren;

-- 4. Vereinigung (Union):
SELECT PersNr FROM Assistent UNION SELECT PersNr FROM Doktorand; -- (Projektion inklusive)

 -- 5. Differenz (Minus):
-- SELECT * FROM Doktorand MINUS SELECT * FROM Assistenten; -- MINUS steht nicht immer zur Verfügung
SELECT * FROM Doktorand WHERE PersNr NOT IN (SELECT assistent.PersNr FROM Assistent);

-- Franz auch in die Doktorranden:
Insert into angestellter (PersNr, Name) values (421, 'Franz');
insert into Doktorand (PersNr, Thema) values (421, 'Überabzählbar unendliche Teilmengen');
-- --------------------------
SELECT * FROM Assistent WHERE PersNr NOT IN (SELECT PersNr FROM Doktorand); -- > Leer!

-- 6. Umbenneneung:
-- ALTER TABLE Doktorand CHANGE Thema NeuName varchar(50);

-- -----------------------------------------------

-- INNER JOIN:
SELECT p.Name, v.Titel FROM Professor p INNER JOIN Vorlesung v ON p.PersNr = v.gelesenVon;
SELECT p.Name, p.Raum FROM Professor p INNER JOIN Vorlesung v ON p.PersNr = v.gelesenVon;

-- Mehrere Tabellen joinen:
SELECT p.Name as ProfName, v.Titel as VorlTitel, a.Name Assi FROM Professor p
INNER JOIN Vorlesung v ON p.PersNr = v.gelesenVon
INNER JOIN Assistent a  on a.istVorgesetzter = p.PersNr
where v.Titel = 'Maßtheorie';

-- LEFT OUTER JOIN:
SELECT * FROM Professor p LEFT OUTER JOIN Vorlesung v ON p.PersNr = v.gelesenVon;

-- RIGHT OUTER JOIN:
-- SELECT * FROM Professoren p RIGHT OUTER JOIN Vorlesung v ON p.PersNr = v.gelesenVon;

-- FULL OUTER JOIN (in MySQL mit 2 Joins)
SELECT * FROM Professor p LEFT OUTER JOIN Vorlesung v ON p.PersNr = v.gelesenVon
UNION
SELECT * FROM Professor p RIGHT OUTER JOIN Vorlesung v ON p.PersNr = v.gelesenVon;

-- NATURAL JOIN:
create table Senior
(MatNr integer primary key,
Name varchar(50) not null,
Semester integer);

alter table Senior add HSNr integer not null;
alter table Senior add constraint Senior_Hochschule_FK foreign key (HSNr) references Hochschule (HSNr);
ALTER TABLE Senior CHANGE HSNr HSNr integer null;

insert into Senior (MatNr, Name, Semester, HSNr)
values (100,'Se1', 1, 11);

insert into Senior (MatNr, Name, Semester, HSNr)
values (102,'Se2', 1, 11);

insert into Senior (MatNr, Name, Semester, HSNr)
values (103,'Paul', 1, 11);

-- Natural Join
SELECT * FROM Hochschule NATURAL JOIN Senior;

-- INTERSECTION (Schnittmenge)
SELECT Name FROM Mann INTERSECT SELECT Name FROM Professoren;

-- Gruppierung und Aggregatfunktion
SELECT Semester as Semester, COUNT(*) as Anzahl FROM Student group by Semester;
SELECT Semester as Semester, COUNT(*) as Anzahl FROM Student group by Semester;

-- Sortierung
SELECT * FROM Student order by Name;