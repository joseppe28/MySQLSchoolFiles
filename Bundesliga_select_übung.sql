Select SpielDatum,heim.Mannschaftsname, Gast.Mannschaftsname from Spiel as S, 
    JOIN Mannschaft as heim ON S.HeimmannschaftsID = heim.MannschaftsID
    JOIN Manschaft as Gast On S.GästemannschaftsID = Gast.MannschaftsID 
order by 1, 2, 3;
 
Select Nachname, Vorname from Person as P 
    Join Vereinsfunktion as V Using(FunktionsID) where V.bezeichnung = 'Trainer'
order by 1,2;
 
Select P.Nachname, P.Vorname from Mannschaft as M
    JOIN Mannschaftskader as MK USING(MannschaftsID) 
    Join Person as P USING(PersonID)
where Mannschaftsname = 'Sturm Graz'
order by 1, 2;

Select P.Nachname, P.Vorname, V.Bezeichnung as Funktion from Mannschaft as M
    JOIN Mannschaftskader as MK USING(MannschaftsID) 
    Join Person as P USING(PersonID)
    Join Vereinsfunktion as V USING(FunktionsID)
where Mannschaftsname = 'Sturm Graz'
order by 1,2;

Select distinct Nachname, Vorname from Schiedsrichter as S 
    Join Spielleiter as SPL USING(SchiedsrichterNR) 
    Join Schiedsrichterfunktion as SF USING(FunktionsID)
where SF.bezeichnung = 'Schiedsrichter'
order by 1,2;

-- ODER Distinct == Group By Nachname, Vorname

Select Vorname, Nachname, count(*) as Anzahl from Schiedsrichter as S 
    Join Spielleiter as SPL USING(SchiedsrichterNR) 
    Join Schiedsrichterfunktion as SF USING(FunktionsID)
where SF.bezeichnung = 'Schiedsrichter'
group by Nachname, Vorname 
order by 1,2;

Select Vorname, Nachname, count(*) as Anzahl from Schiedsrichter as S 
    Join Spielleiter as SPL USING(SchiedsrichterNR) 
    Join Schiedsrichterfunktion as SF USING(FunktionsID)
where SF.bezeichnung = 'Schiedsrichter'
group by Nachname, Vorname having count(*) > 10
order by 1,2;

Select Nachname, Vorname, count(*) as 'Anzahl der Tore' from person as P 
    Join Mannschaftskader as Mk using(PersonID) 
    Join Aufgestellt as Auf Using(KaderID) 
    Join tor as T using(SpielID, KaderID)
group by Nachname, Vorname;


Select Nachname, Vorname, count(*) as 'Anzhal der Roten Karten' from person as P 
    Join Mannschaftskader as Mk using(PersonID) 
    Join Aufgestellt as Auf Using(KaderID) 
    Join Strafe Using(SpielID, KaderID)
    Join Karte Using(KartenID)
where Farbe = 'Rot'
group by Nachname, Vorname;

Select Mannschaftsname, sum(Heimtore) from Manschaft as M 
    Join Spiel as S ON M.MannschaftsID = S.HeimmannschaftsID 
group by Mannschaftsname 
Order By sum(Heimtore) DESC; 

Select Stadionname, count(*) as 'Anzahl von Spielen' from Stadion as St 
    Join Spiel as Sp using(StadionID) 
group by Stadionname;

select Nachname, Vorname, count(*) as AnzahlSpiele from Person as P 
    join Mannschaftskader as Mk Using(PersonenID)
    join Aufgestellt as A Using(KaderID)
group by Nachname, Vorname, PersonenID;

Select Vorname, Nachname, Mannschaftsname, count(*) as AnzahlBeimVerein from Person as P 
    join Mannschaftskader as Mk USING(PersonenID) 
    join Manschaft as M USING(MannschaftsID)
group by PersonenID, MannschaftsID, Vorname, Nachname, Mannschaftsname Having count(*) >= 2;

Select Mannschaftsname, count(*) as VerloreneSpiele from Manschaft as M 
    Join Spiel as S On M.MannschaftsID = S.GästemannschaftsID
    Join Stadion as St using(StadionID)
where M.Ort = 'Wien' 
    and St.Ort = 'Innsbruck' 
    And S.Heimtore > S.Gästetore
group by Mannschaftsname, MannschaftsID; 

-- wie of wurden spieler von Sturm Graz von welchen Schiedsrichter ausgeschlossen

Select p.vorname, p.nachname, S.vorname, S.nachname, count(*)
from Person as p 
    join Mannschaftskader using(PersonenID)
    join Manschaft using(MannschaftsID)
    join Aufgstellt using(KaderID)
    join Strafe using(KaderID, SpielID)
    join Karte using(KartenID)
    join Spiel using (SpielID)
    join Spielleitung using(SpielID)
    join Schiedsrichter as S using(SchiedsrichterNR)
    join Schiedsrichterfunktion using(FunktionsID)
where Manschaftsname = 'Sturm Graz' 
    and Farbe IN('Rot', 'gelbRot')
    and Bezeichnung = 'Spielleiter'
group by p.vorname, p.nachname, S.vorname, S.nachname, PersonenID, SchiedsrichterNR;

select max(heimtore) from Spiel; --12

select heimmannschaft, Gästemannschaft, datum 
from spiele
where heimtore = (select max(heimtore) from Spiel);

select HeimmannschaftsID from Manschaft as M 
    join Spiel as S on M.MannschaftsID = S.GästemannschaftsID
where M.Mannschaftsname = 'Rapid'
    and datum < now();


select * 
from Mannschaft where MannschaftsID NOT IN(
    select HeimmannschaftsID from Manschaft as M 
        join Spiel as S on M.MannschaftsID = S.GästemannschaftsID
    where M.Mannschaftsname = 'Rapid'
        and datum < now());

Select distinct PersonenID
From Person Join Mannschaftskader using(PersonenID)
    join Aufgestellt using(KaderID)
    join Tore using(SpielID, KaderID);

Select Vorname, Nachname
from Person where PersonenID NOT In(
    Select PersonenID
    From Person Join Mannschaftskader using(PersonenID)
        join Aufgestellt using(KaderID)
        join Tore using(SpielID, KaderID)
);

select min(Zeitpunkt) from Tor;

Select Vorname, Nachname
From Person Join Mannschaftskader using(PersonenID)
    join Aufgestellt using(KaderID)
    join Tor using(SpielID, KaderID)
where zeitpunkt = (select min(Zeitpunkt) from Tor);

Select S.SchiedsrichterNR from Schiedsrichter as S
    join Spielleitung using(SchiedsrichterNR)
    join Schiedsrichterfunktion using(FunktionsID)
where Bezeichung = 'Spielleiter';

Select Vorname, Nachname from Schiedsrichter
where SchiedsrichterNR NOT In(
    Select S.SchiedsrichterNR from Schiedsrichter as S
        join Spielleitung using(SchiedsrichterNR)
        join Schiedsrichterfunktion using(FunktionsID)
    where Bezeichung = 'Spielleiter'
);

Select PersonenID
from Person as p
    join Mannschaftskader using(PersonenID)
    join Aufgestellt using(KaderID)
    join Strafe(KaderID, SpielID)

select Vorname, Nachname, count(*) as Anzahl
from Person as p 
    join Mannschaftskader using(PersonenID)
    join Aufgestellt using(KaderID)
    join Tore using(KaderID, SpielID) -- mit Strafe bekommt man bei Count(*): Tore * Strafe
where PersonenID IN(
    Select distinct PersonenID
    from Person as p
        join Mannschaftskader using(PersonenID)
        join Aufgestellt using(KaderID)
        join Strafe(KaderID, SpielID)
)
group by Vorname, Nachname, PersonenID
Order by Anzahl desc;

select distinct StadionID
from Spiel;

select Stadionname
from Stadion 
where StadionID NOT IN(
    select distinct StadionID
    from Spiel;
);




-- select1
Select PersonenID
from Person p 
    join Mannschaftskader using(PersonenID)
    join Aufgestellt using(KaderID)
    join Strafe using(KaderID, SpielID)
    join Karte using(KartenID)
where Farbe = 'Gelb';

--select2
Select PersonenID
from Person p 
    join Mannschaftskader using(PersonenID)
    join Aufgestellt using(KaderID)
    join Strafe using(KaderID, SpielID)
    join Karte using(KartenID)
where Farbe = 'Rot' ;

from Person 
where PersonenID IN(select1) AND PersonenID IN(select2);

-- die anderen Lösungen sind auf der Cloud



-- Welche Spieler haben nie bei einem Wiener Verein gespielt?

Select distinct PersonenID
from Person P 
    Join Mannschaftskader using(PersonenID)
    Join Manschaft M using (MannschaftsID)
where M.ort = 'Wien';


Select Vorname, Nachname
from Person 
where PersonenID NOT IN(
    Select distinct PersonenID
    from Person P 
        Join Mannschaftskader using(PersonenID)
        Join Manschaft M using (MannschaftsID)
    where M.ort = 'Wien'
);

Select Stadionname, count(*)
from Stadion
    Join Spiel using (StadionID)
where Heimtore > Gästetore
group by StadionID, Stadionname;


Select Stadionname, count(distinct S1.SpielID) as Heimsiege ,count(distinct S2.SpielID) as Heimniederlage
from Stadion St
    Join Spiel S1 ON(ST.StadionID = S1.StadionID)
    Join Spiel S2 ON(ST.StadionID = S2.StadionID)
where 
    S1.heimtore > S1.Gästetore
    AND
    S2.heimtore < S2.Gästetore
group by StadionID;


-- Welche Spieler haben den öfters als 1 mal gewächselt

Select Vorname, Nachname, count(*) as Anzahl
from Person p
    Join Mannschaftskader mk using(PersonenID)
group by PersonenID, vorname, Nachname having count(*) > 2;


Select Vorname, Nachname
from Person p
    Join Join Mannschaftskader mk1 on(P.PersonenID = mk1.PersonenID)
    Join Join Mannschaftskader mk2 on(P.PersonenID = mk2.PersonenID)
    Join Join Mannschaftskader mk3 on(P.PersonenID = mk3.PersonenID)
where mk1.KaderID != mk2.KaderID
    AND
      mk2.KaderID != mk3.KaderID
    AND
      mk1.KaderID != mk3.KaderID



Select *
from Stadion 
Order BY AnzahlPlätze DESC;

Select Stadionname, sum(Heimtore + Gästetore)
from Stadion st Join Spiel USING(StadionID)
Group By StadionID, Stadionname
Order BY sum(Heimtore + Gästetore) DESC;

Select Vorname, Nachname, count(*) - 1 as Wechsel 
from Person p Join Mannschaftskader mk USING(PersonenID)
group by PersonenID, vorname, Nachname
Having count(*) > 3;


Select SpielID from Personen Join Mannschaftskader mk USING(PersonenID)
    join Aufgestellt USING(KaderID) 
    join Strafe USING (KaderID, SpielID)
    join Karte USING(KartenID)
where Farbe = "Rot";


Select SpielID from Personen Join Mannschaftskader mk USING(PersonenID)
    join Aufgestellt USING(KaderID) 
    join Strafe USING (KaderID, SpielID)
    join Karte USING(KartenID)
where Farbe = "RotGelb";



Select Vorname, Nachname from Personen Join Mannschaftskader mk USING(PersonenID)
    join Aufgestellt USING(KaderID) 
    join Tor USING(KaderID, SpielID)
where
    SpielID IN(Select SpielID from Personen Join Mannschaftskader mk USING(PersonenID)
            join Aufgestellt USING(KaderID) 
            join Strafe USING (KaderID, SpielID)
            join Karte USING(KartenID)
        where Farbe IN("Rot", "RotGelb");)
