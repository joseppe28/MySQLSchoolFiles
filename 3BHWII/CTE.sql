-- Spieler Anzahl Aufgestellt, Anzahl Tore

With aufgestellt AS(
    Select Vorname , Nachname, PersonenID, count(*) as anzAuf from Personen 
        Join Mannschaftskader using(PersonenID)
        Join aufgestellt using(KaderID)
    Group BY Vorname , Nachname, PersonenID
),
TORANZAHL AS (
    Select Vorname , Nachname, PersonenID, count(*) as anzTor from Personen 
        Join Mannschaftskader using(PersonenID)
        Join aufgestellt using(KaderID)
        Join Tore using(KaderID, SpielID)    
        Group BY Vorname , Nachname, PersonenID
)
Select Vorname, Nachname, anzAuf, anzTor from Aufgestellt 
JOIN TORANZAHL USING(PersonenID);



WITH NiederlagenZuhause AS(
    select distinct(HeimmannschaftsID), count(*) as Anzahl from Spiel
    where Heimtore < Gasttore
    group by HeimmannschaftsID;
    )
Select HeimmannschaftsID from NiederlagenZuhause where Anzahl = (select MAX(Anzahl) from NiederlagenZuhause);

-- In Welchem Ort gab es die meisten Unentschieden

With AnzahlUnentschieden AS(
select Ort, StadionID, count(*) as Anzahl from Stadion
    Join Spiel using(StadionID)
    where heimtore = Gästetore
group by Ort, StadionID
)
Select Ort, StadionID, Anzahl from AnzahlUnentschieden where Anzahl = (Select max(Anzahl) from AnzahlUnentschieden);

-- Welcher Spieler wurde am häufigsten aufgestellt

With anzahlAufgestellt AS(
select vorname, Nachname, PersonenID, count(*) as Anzahl from Person 
    Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
group by vorname, Nachname, PersonenID
)
Select vorname, Nachname, Anzahl from anzahlAufgestellt where Anzahl = (select MAX(Anzahl) from anzahlAufgestellt);

-- Welche Mannschaft hatte die meisten Abgänge im letztem Jahr

With AnzahlAbgänge AS(
select Mannschaftsname, count(*) as Anzahl
from Mannschaft Join Mannschaftskader using(MannschaftsID)
    where Year(bisDat) < Year(now()) -1
    and Year(bisDat) > Year(now()) -2
group by Mannschaftsname
)
Select Mannschaftsname, Anzahl from AnzahlAbgänge where Anzahl = (Select Max(Anzahl) from AnzahlAbgänge);