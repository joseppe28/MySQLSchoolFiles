-- ---------------------------------------
-- DML Übung
-- Name:	Josef Meßner
-- Datum: 	04.12.2023
-- ---------------------------------------

drop table if exists Personen;

Create table if not exists Personen (
    ID int AUTO_INCREMENT Primary Key,
    Vorname varchar(50),
    Nachname varchar(50),
    Adresse varchar(50),
    Stadt varchar(50),
    PLZ varchar(10),
    Geschlecht varchar(1),
    Gehalt int
);

Insert Into Personen
    (Vorname, Nachname, Adresse, Stadt, PLZ, Geschlecht, Gehalt)
Values
    ('Petra', 'Müller', 'Langstrasse 26', 'Innsbruck', '6020', 'w', 2500),
    ('Hubert', 'Zauner', 'Schulstrasse 9', 'Reutte', '6600', 'm', 3000),
    ('Christine', 'Lang', 'Obergasse 17', 'Imst', '6460', 'w', 2250),
    ('Lukas', 'Maier', 'Kanzelweg 3', 'Landeck', '6502', 'm', 2600),
    ('Paula', 'Friedel', 'Mühlgasse 36', 'Schwaz', '6130', 'w', 2650),
    ('Leon', 'Eigner', 'Freigasse 23', 'Kufstein', '6330', 'm', 2600);

Select * from personen;
Select Nachname, Gehalt from personen;
update personen Set PLZ = '6500'
    where id = 4;


Select Vorname From Personen where
    Geschlecht = 'w'
AND
    Gehalt > 2500; 

Delete from personen where id = 5;

Update Personen Set Geschlecht='d', Vorname='Leonie'
    where id = 6;

Select Vorname, Nachname from personen where
(
    Adresse like "%gasse%"
Or
    Adresse like "%strasse%"

)
And
(
    Gehalt >= 2450
And
    Gehalt <= 2700
);

Update personen Set Gehalt = Gehalt * 1.087
    where Geschlecht = 'w';

Update personen Set Gehalt = Gehalt * 1.0725
    where Geschlecht != 'w';
