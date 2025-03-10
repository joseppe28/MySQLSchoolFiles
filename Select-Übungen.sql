-- ---------------------------------------
-- Select
-- Name:	Josef Meßner
-- Datum: 	08.01.2024
-- ---------------------------------------


create database if not exists Messner;

use messner;

create table if not exists Mitarbeiter(
    ID int AUTO_INCREMENT Primary Key,
    Nachname varchar(50),
    Vorname varchar(50),
    Geschlecht varchar(1),
    Gehalt decimal(10, 2)
);


Insert Into Mitarbeiter(Nachname, Vorname, Geschlecht, Gehalt) Values
    ("Jäger", "Sabine", "w", 2435.00),
    ("Müller", "Bernhard", "m", 2090.00),
    ("Schulze", "Paul", "m", 3410.00),
    ("Opitz", "Franz", "m", 3675.00),
    ("Maier", "Julia", "w", 1201.00);

Select Nachname, Gehalt from Mitarbeiter where Gehalt > 3000.00;

select Nachname, Gehalt from Mitarbeiter where 
Gehalt > 2095 
AND 
Geschlecht = 'w';


Select Vorname, Nachname from Mitarbeiter where
Gehalt < 2000
OR
Gehalt > 3000;

Select Vorname, Nachname from Mitarbeiter where Vorname IN("Paul", "Julia", "Sabine");
Select Vorname, Nachname from Mitarbeiter where Vorname NOT IN("Paul", "Julia", "Sabine");

Select Vorname, Nachname from Mitarbeiter where Nachname Like 'M%er';
Select * from Mitarbeiter where Nachname Like 'S_____%e';

Select * from Mitarbeiter where Gehalt between 1201 and 2090;

Select * from Mitarbeiter where Gehalt Is NOT NULL;

SELECT DISTINCT Geschlecht from Mitarbeiter;

Select * from Mitarbeiter ORDER BY Nachname ASC;

Select * from Mitarbeiter where Geschlecht = 'w' Order By Gehalt DESC;

Select * from Mitarbeiter Order By Geschlecht, Nachname ASC;
Select * from Mitarbeiter Order By Geschlecht Asc, Nachname DESC;