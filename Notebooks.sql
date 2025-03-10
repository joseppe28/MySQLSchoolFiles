-- ---------------------------------------
-- Megabooks Übung
-- Name:	Josef Meßner
-- Datum: 	15.1.24
-- ---------------------------------------

Create Database if not exists Megabooks;

use Megabooks;

Create Table if not exists notebooks(
    ID int Primary Key AUTO_INCREMENT,
    Hersteller varchar(50),
    Modell varchar(50),
    Preis decimal(8,2),
    Bestand int,
    Modelljahr year
);

Insert Into notebooks (Hersteller, Modell, Preis, Bestand, Modelljahr)
Values
    ('Lenovo', 'ThinkPad Z16', 3487.00, 20, 2019),
    ('HP', 'EliteBook 630', 1052.00, 10, 2018),
    ('Acer', 'Swift3', NULL, 20, 2020),
    ('Lenovo', 'IdeaPad Flex5', 789.00, 30, 2020),
    ('Asus', 'Zenbook Pro', 2678.00, 15, 2021);

Select Count(*) from notebooks;

Select Count(preis) from notebooks;

Select count(preis) AS Anzahl from notebooks;

Select count(DISTINCT Hersteller) As Hersteller from notebooks;

Select Hersteller As Marke from notebooks;

Select count(preis) AS 'Anzahl Notebooks mit Preis' from notebooks;

Select MAX(preis) AS 'Hoechster Preis' from notebooks where Modelljahr > 2019;

Select MIN(Bestand) AS 'Niedrigster Bestand' from notebooks where preis >= 1200.00;

Select SUM(preis) AS 'Summe' from notebooks where Modell like '%book%';

Select AVG(preis) As 'durchschnittlicher Preis' from notebooks where Bestand between 10 and 19;
 
Select Hersteller, SUM(Bestand)  from notebooks Group By Hersteller;

Select Modelljahr, AVG(preis) from notebooks Group BY Modelljahr;

Select Hersteller, SUM(Bestand) As 'Bestand von Notebooks' from notebooks GROUP BY Hersteller ORDER BY SUM(Bestand) DESC;

Select Hersteller, MAX(preis) AS 'Hoechster Preis' from notebooks GROUP BY Hersteller ORDER BY MAX(preis) ASC;

Select Modelljahr, SUM(Bestand) AS 'Anzahl' from notebooks Group By Modelljahr Having SUM(Bestand) >= 20;

Select Modelljahr, SUM(Preis) AS 'Preis' from notebooks where Bestand > 10 Group By Modelljahr;