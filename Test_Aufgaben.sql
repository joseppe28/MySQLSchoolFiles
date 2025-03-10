-- ---------------------------------------
-- Test
-- Name:	Josef Meßner
-- Datum: 	27.11.2023
-- ---------------------------------------

use 2bhwii;

Create table if not exists Fahrzeuge(
    FNR int auto_increment Primary Key,
    Hersteller varchar(50),
    Modell varchar(50),
    BauJahr Year,
    Listenpreis Decimal(10, 2),
    Elektro varchar(1)
);

Insert Into Fahrzeuge
    (Hersteller, Modell, BauJahr, Listenpreis, Elektro)
Values
    ('VW', 'Touran', 2019, 42790.50, 'n'),
    ('Audi', 'Q8 Sportback', 2023, 63258.10, 'y'),
    ('Ford', 'Explorer', 2021, 91575.70, 'y'),
    ('Audi', 'A4 Avant', 2017, 43394.20, 'n');

Insert Into Fahrzeuge
    (Hersteller, Modell, Listenpreis, Elektro)
Values
    ('Skoda', 'Enyaq', 64634.70, 'y');

Alter Table Fahrzeuge change Listenpreis Preis int;

Select Modell from fahrzeuge where 
    Elektro = 'n'
Or(
    BauJahr >= 2019
And
    Baujahr <= 2021
);

Select Modell, BauJahr from Fahrzeuge where 
(
    Hersteller = 'Ford'
Or 
    Hersteller = 'VW'
)
And 
    Modell Like '%sport%';

Select * from Fahrzeuge where Baujahr IS NULL; 