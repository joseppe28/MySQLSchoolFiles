-- ---------------------------------------
-- Personen
-- Name:	Josef Meßner
-- Datum: 	29.01.24
-- ---------------------------------------

Create database if not exists UE_SQLERW;
use UE_SQLERW;


drop table if exists Personen;
Create table if not exists Personen(
    ID int AUTO_INCREMENT Primary Key,
    Vorname varchar(50),
    Abteilung varchar(50),
    Telefon varchar(50),
    GebDat date,
    Gehalt decimal(8,2),
    PLZ varchar(10),
    Ort varchar(50)
);

describe Personen;

Insert Into Personen (Vorname, Abteilung, Telefon, GebDat, Gehalt, PLZ, Ort)
Values 
    ('Gabi', 'Sekr', '100', '1993-09-26', 3267.50, Null, Null),
    ('Tatiana', 'GF', '202', '2001-03-07', 5484.90, Null, Null),
    ('Manfred', 'GF', '201', '1999-02-24', 4768.10, Null, Null),
    ('Iris', 'Eink', '401', '1996-08-26', 2433.00, Null, Null),
    ('Rene', 'Eink', '402', '1996-12-26', 1472.80, '6500', 'Landeck'),
    ('Elena', 'Mark', '301', '2000-11-28', 2768.56, Null, Null),
    ('Aidar', 'Mark', '301', '1995-08-25', 3126.35, Null, Null),
    ('Oleg', 'Mark', '301', '2005-02-10', 2865.12, Null, Null),
    ('Andreas', 'Entw', '610', '2002-03-23', 3578.48, '6600', 'Reutte'),
    ('Arthur', 'Entw', '612', '2004-12-03', 2584.98, '6500', 'Landeck'),
    ('Gregor', 'Entw', '611', '1992-09-04', 3257.30, '6460', 'Imst'),
    ('Michael', 'Entw', '616', '1994-01-28', 1257.66, '6410', 'Telfs'),
    ('Norbert', 'Entw', '614', '2000-07-10', 3556.56, '6460', 'Imst'),
    ('Roland', 'Entw', '601', '1993-03-02', 2332.34, '6410', 'Telfs'),
    ('Stefan', 'Entw', '613', '1995-09-21', 1234.60, '6020', 'Innsbruck'),
    ('Peter', 'Entw', '601', '1995-01-08', 4533.40, '6020', 'Innsbruck'),
    ('werner', 'Entw', '615', '2004-11-19', 2365.53, '6010', 'Innsbruck');

Alter Table Personen add Nachname varchar(50) after vorname;

Update Personen set Nachname = 'Huber' where Id = 1;
Update Personen set Nachname = 'Zimmermann' where Id = 2;
Update Personen set Nachname = 'Messner' where ID = 3;
Update Personen set Nachname = 'Mueller' where ID = 4;
Update Personen set Nachname = 'Keinz' where ID = 5;

Select Vorname, Ort, Telefon from Personen where Vorname like '%an%';
Select Abteilung, AVG(Gehalt) AS 'Durchschnittlicher Preis' from Personen GROUP BY Abteilung Having Abteilung = 'Entw';

Select Vorname, Abteilung, Gehalt from Personen where Abteilung != 'Entw' Order By Gehalt DESC;

select Vorname, Abteilung from Personen Order By Abteilung DESC, Vorname ASC;

Update Personen set PLZ = '6500', Ort='Landeck' where Abteilung = 'Mark' And PLZ is Null;

Select Vorname, Ort, Gehalt from Personen where Abteilung = 'Entw' And Ort = 'Imst' And Gehalt between 3024 and 3478;

Update Personen set Gehalt = gehalt + 100.00 where Abteilung = 'Eink';

Select Sum(Gehalt) AS 'Summe Gehalt' from Personen where Abteilung In('Mark', 'Eink');

Select Vorname, GebDat from Personen where GebDat between '1995-06-30' and '2002-12-31';

Delete from Personen where PLZ = '6410' and Vorname like '_a%';

Select Distinct Abteilung from Personen Order BY Abteilung ASC;

Select Count(Distinct Abteilung) AS 'Anzahl der Abteilungen' from Personen;