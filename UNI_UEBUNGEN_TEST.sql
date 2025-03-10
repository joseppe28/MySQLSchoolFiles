-- ---------------------------------------
-- Übungen für Test
-- Name:	Josef Meßner
-- Datum: 	20.11.23
-- ---------------------------------------

Create database if not exists UNI;
use UNI;

drop table if exists Professoren;
Show tables;

Create Table Professoren (
        PersNrP int,
        Name varchar(50),
        Rang varchar(10),
        Raum varchar(10)
);

Insert into Professoren
    (PersNrP, Name, Rang, Raum)
Values
    (2125, 'Schmidt', 'C4', '226');


drop Table if exists Assistenten;

Create Table Assistenten (
    PersNrA int,
    Fachgebiet varchar(50),
    Boss int
);

ALTER TABLE Assistenten add Name varchar(50) after PersNrA;

Insert Into Assistenten
    (PersNrA, Name, Fachgebiet, Boss)
Values
    (3008, 'Smith', 'Fachtheorie', 2125);

Create Table Studenten(
    MatrNr varchar(10),
    Name varchar(50),
    Semester int
);

Alter Table Studenten Change MatrNr MatrNr int; 

Insert Into Studenten Values (29557, 'Huber', 2);

Create Table vorlesungen (
    VorlNr int,
    Bezeichnung varchar(50),
    SWS int, 
    gelesen_von int,
    aktiv date
);

Alter Table Vorlesungen change Bezeichnung Titel varchar(50);

Alter Table Vorlesungen drop aktiv;

Insert Into Vorlesungen Values (5122, 'Der Glaube Versetzt Berge', 4, 2134);

Select Name, PersNrP from Professoren where Rang = 'C4';

Select Name from Professoren where PersNrP > 5040;

Select PersNrA, Name from Assistenten where Boss = 2126;

Select name from Assistenten where Fachgebiet like '%Kepler%';

Select name from Studenten where name like 'F%';

Select Titel from Vorlesungen where 
    SWS = 4
Or
    gelesen_von = 2125;

Select name from Assistenten where
    Fachgebiet like '%en%'
AND
    Boss = 2127;

Select Titel from Vorlesungen where
    Titel like '%theorie'
Or
    SWS = 2;

Select Titel, VorlNr from Vorlesungen where
    titel not like '%theorie%'
AND
    SWS = 3;

Select PersNrP, name from Professoren where
    Raum > 228
AND
    Rang = 'C3';

Select Titel from Vorlesungen where 
    gelesen_von > 2126
AND
    gelesen_von < 2137;