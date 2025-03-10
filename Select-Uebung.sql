-- ---------------------------------------
-- Übungsaufgaben Select
-- Name:	Josef Messner
-- Datum: 	23.10.23
-- ---------------------------------------

-- 1.) Zeige alle Artikel an, die in Regal Nummer 2 liegen.
Select * From lagerbestand where regalnr = 2;

-- 2.) Schnäppchenalarm! Zeigen alle Artikel an, deren Verkaufspreis unter 80 Euro liegt.
Select * From lagerbestand where verkaufspreis < 80;

-- 3.) Zeige den Namen aller Artikel an, deren Einkaufspreis mehr als 50 Euro beträgt.
Select Artikelname From lagerbestand where Einkaufspreis > 50;

-- 4.) Erzeugen eine Liste aller Armbanduhren (nur Artikelname und Verkaufspreis ausgeben)
Select Artikelname, Verkaufspreis From lagerbestand where Artikelname like '%Armbanduhr%';

-- 5.) Erzeuge eine Liste aller Armbanduhren, deren Verkaufspreis mehr als 130 Euro beträgt (nur Artikelname und Verkaufspreis ausgeben).
Select Artikelname, Verkaufspreis From lagerbestand where 
Artikelname Like '%Armbanduhr%'
And
Verkaufspreis > 130;

-- 6.) Erzeugen Sie eine Liste aller Armbanduhren, deren Preis weniger als 250 Euro beträgt und die vom Lieferanten mit der Nummer 5 geliefert werden (nur Artikelname und Verkaufspreis ausgeben).
Select Artikelname, Verkaufspreis From lagerbestand where
Artikelname Like '%Armbanduhr%'
And
Verkaufspreis < 250
And
lieferant = 5;

-- 7.) Gib alle Lieferanten aus, welche die Gesellschaftsform einer GmbH haben
Select name From lieferanten where name Like '%Gmbh';

-- 8.) Gib den Namen sowie die Postleitzahl der Lieferanten mit Sitz in Wien oder Villach aus.
select name, plz From lieferanten where
ort = 'Wien'
Or
ort = 'Villach';

-- 9.) Erzeuge eine Liste aller Lieferanten mit der Gesellschaftsform einer AG mit einer Postleitzahl größer 6000.
select name from lieferanten where 
name like '%AG'
And
plz > 6000; 

-- 10.) Gib alle Artikel aus der Kategorie Outdoor aus, deren Einkaufspreis größer EUR 15 aber weniger als EUR 35 ist (nur Name und Einkaufspreis ausgeben).
Select artikelname, einkaufspreis from lagerbestand where 
kategorie = 'Outdoor'
And
einkaufspreis > 15
And
einkaufspreis < 35;