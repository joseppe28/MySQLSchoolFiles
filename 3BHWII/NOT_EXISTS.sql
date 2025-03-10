-- Spieler ohne Tore und Karten

Select * from Person as P
    Join Mannschaftskader mk USING(PersonenID)
where NOT EXISTS(Select 1 from Tor t where t.KaderID = mk.KaderID)
AND 
NOT EXISTS(Select 1 from Strafe sf where sf.KaderID = mk.KaderID)


-- Welche Schiedsrichter waren NIE Spielleiter

Select * from Schiedsrichter as s
Where NOT EXISTS(Select 1 from Spielleiter spl 
    Join SchiedsrichterFunktion sf USING(FunktionsID)
    Where spl.SchiedsrichterNR = s.SchiedsrichterNR
    AND Bezeichnung = "Spielleiter");                          


-- Welche Gastmannschaften haben heuer noch nicht im Tivoli gespielt

Select * from Mannschaft as m 
where NOT EXISTS(Select 1 from Spiel 
        Join Stadion USING(StadionID)
    where GastmannschaftsID = m.MannschaftsID
    and Stadionname = "Tivoli"
    and Year(Datum) = Year(Now));




Select 
Mannschaftsname, 
(select Count(*) from Spiel where Heimtore > Gästetore and HeimmannschaftsID = m.MannschaftsID) as ANZAHL
from Spiel Join Mannschaft m ON(HeimmannschaftsID = MannschaftsID);


-- Mannschaft, Torverhältnis 

Select Mannschaftsname,
(
(select sum(heimtore) from Spiel where HeimmannschaftsID = m.MannschaftsID) 
+
(select sum(Gästetore) from Spiel where GastmannschaftsID = m.MannschaftsID) 
) as erzielt
,
(
(select sum(Gästetore) from Spiel where HeimmannschaftsID = m.MannschaftsID) 
+
(select sum(heimtore) from Spiel where GastmannschaftsID = m.MannschaftsID) 
) as erhalten

from Mannschaft m;

-- Spieler Anzahl Vereine

Select 
Vorname,
Nachname,
(
    Select Count(distinct MannschaftsID) from Mannschaftskader mk where mk.PersonenID = p.PersonenID
) as Anzahl
from Person p;

