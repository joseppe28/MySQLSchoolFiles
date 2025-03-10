-- Welcger Spieler der ein Tor geschoßen hat, hat die meisten Karten erhalten

-- Inline View für Torschützen:

Select * from Person 
    Join Manschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Tor using(SpielID, KaderID);

-- Karten pro Torschützen

select PersonenID, Vorname, Nachname, count(KartenID) as Anzahl from Person 
    Join (
        Select * from Person 
            Join Manschaftskader using(PersonenID) 
            Join Aufgestellt using(KaderID)
            Join Tor using(SpielID, KaderID);
    ) as Torschuetzen using(PersonenID)
    Join Manschaftskader using(PersonenID)
    Join Aufgestellt using(SpielID)
    Join Strafe using(SpielID, KaderID)
    group by PersonenID, Vorname, Nachname; 

-- MAX aus 2 

Select Max(Anzahl) as Maximum from (
    select Vorname, Nachname, count(KartenID) as Anzahl from Person 
    Join (
        Select * from Person 
            Join Manschaftskader using(PersonenID)
            Join Aufgestellt using(KaderID)
            Join Tor using(SpielID, KaderID);
    ) as Torschuetzen using(PersonenID)  
    Join Manschaftskader using(PersonenID)
    Join Aufgestellt using(SpielID)
    Join Strafe using(SpielID, KaderID);
    ) as AnzahlKarten;

-- Aus 2: Anzahl = MAX

Select Vorname, Nachname, Torschuetzen.Anzahl from(
    select Vorname, Nachname, count(KartenID) as Anzahl from Person 
    Join (
        Select * from Person 
            Join Manschaftskader using(PersonenID)
            Join Aufgestellt using(KaderID)
            Join Tor using(SpielID, KaderID)
    )
    Join Manschaftskader using(PersonenID)
    Join Aufgestellt using(SpielID)
    Join Strafe using(SpielID, KaderID)
    ) as Torschuetzen
    Join (
        Select PersonenID, Max(Anzahl) as Maximum from (
            select Vorname, Nachname, count(KartenID) as Anzahl from Person 
        Join (
            Select * from Person 
            Join Manschaftskader using(PersonenID)
            Join Aufgestellt using(KaderID)
            Join Tor using(SpielID, KaderID)
        ) as Torschuetzen using(PersonenID)
        Join Manschaftskader using(PersonenID)
        Join Aufgestellt using(SpielID)
        Join Strafe using(SpielID, KaderID)
        ) as AnzahlKarten;
    ) as KartenAnzahl using(PersonenID)
    where Torschuetzen.Anzahl = KartenAnzahl.Maximum;


-- Welcher Schiedsrichter hat die meisten Spieler ausgeschloßen

-- Alle Schiedsrichter
Select Vorname, Nachname, SchiedsrichterNR, SpielID from Schiedsrichter
    Join Spielleitung using(SchiedsrichterNR),
    Join SchiedsrichterFunktion using(FunktionsID)
where Bezeichnung = "Schiedsrichter";

-- Anzahl der Karten/ausgeschloßene Spieler

Select Vorname, Nachname, SchiedsrichterNR, count(*) as Anzahl from (
    Select Vorname, Nachname, SchiedsrichterNR from Schiedsrichter
        Join Spielleitung using(SchiedsrichterNR),
        Join SchiedsrichterFunktion using(FunktionsID)
    where Bezeichnung = "Schiedsrichter"
    ) as Schiedsrichter
    Join Spiel using(SpielID),
    Join Aufgestellt using(SpielID),
    Join Strafe using(KaderID, SpielID),
    Join Karte as k using(KartenID)

    where k.farbe IN('Rot', 'Gelbrot')
    Group By Vorname, Nachname, SchiedsrichterNR;

-- Maximum der Karten anzahl holen

Select Max(Anzahl) as max from (

Select Vorname, Nachname, SchiedsrichterNR, count(*) as Anzahl from (
    Select Vorname, Nachname, SchiedsrichterNR from Schiedsrichter
        Join Spielleitung using(SchiedsrichterNR),
        Join SchiedsrichterFunktion using(FunktionsID)
    where Bezeichnung = "Schiedsrichter"
    ) as Schiedsrichter
    Join Spiel using(SpielID),
    Join Aufgestellt using(SpielID),
    Join Strafe using(KaderID, SpielID),
    Join Karte as k using(KartenID)

    where k.farbe IN('Rot', 'Gelbrot')
    Group By Vorname, Nachname, SchiedsrichterNR;
)


Select Vorname, Nachname, Anzahl from (

  Select Vorname, Nachname, SchiedsrichterNR, count(*) as Anzahl from (
    Select Vorname, Nachname, SchiedsrichterNR from Schiedsrichter
        Join Spielleitung using(SchiedsrichterNR),
        Join SchiedsrichterFunktion using(FunktionsID)
    where Bezeichnung = "Schiedsrichter"
    ) as Schiedsrichter
    Join Spiel using(SpielID),
    Join Aufgestellt using(SpielID),
    Join Strafe using(KaderID, SpielID),
    Join Karte as k using(KartenID)

    where k.farbe IN('Rot', 'Gelbrot')
    Group By Vorname, Nachname, SchiedsrichterNR;  
) as AnzahlKarten
-- Checken wer das Maximum hat 
having Anzahl = (
    Select Max(Anzahl) as max from (

    Select Vorname, Nachname, SchiedsrichterNR, count(*) as Anzahl from (
    Select Vorname, Nachname, SchiedsrichterNR from Schiedsrichter
        Join Spielleitung using(SchiedsrichterNR),
        Join SchiedsrichterFunktion using(FunktionsID)
    where Bezeichnung = "Schiedsrichter"
    ) as Schiedsrichter
    Join Spiel using(SpielID),
    Join Aufgestellt using(SpielID),
    Join Strafe using(KaderID, SpielID),
    Join Karte as k using(KartenID)

    where k.farbe IN('Rot', 'Gelbrot')
    Group By Vorname, Nachname, SchiedsrichterNR;
)
) as MaxAnzahl

-- Welcher Schiedrichter die nie Spielleiter war, war am häufigsten im Einsatz

-- Alle Schiedrichter die Spielleiter waren

select SchiedsrichterNR from Schiedrichter as sr 
    Join Spielleitung using(SchiedsrichterNR)
    Join SchiedsrichterFunktion using(FunktionsID)
where Bezeichnung = 'Spielleiter';

-- Anzahl der Spiele als nie Spielleiter

select sr.*, count(*) as Anzahl
from Schiedrichter as sr 
    Join Spielleiter using(SchiedsrichterNR)
    Join Spiel using(SpielID)
where sr.SchiedsrichterNR NOT IN(
    select SchiedsrichterNR from Schiedrichter as sr 
        Join Spielleitung using(SchiedsrichterNR)
        Join SchiedsrichterFunktion using(FunktionsID)
    where Bezeichnung = 'Spielleiter'
)
group by Vorname, Nachname, SchiedsrichterNR; 

-- Max von dieser Anzahl

Select max(Anzahl) from(
    select sr.*, count(*) as Anzahl
    from Schiedrichter as sr 
        Join Spielleiter using(SchiedsrichterNR)
        Join Spiel using(SpielID)
    where sr.SchiedsrichterNR NOT IN(
        select SchiedsrichterNR from Schiedrichter as sr 
            Join Spielleitung using(SchiedsrichterNR)
            Join SchiedsrichterFunktion using(FunktionsID)
        where Bezeichnung = 'Spielleiter'
        )
    group by Vorname, Nachname, SchiedsrichterNR
);

-- Schiedsrichter ausgeben

select sr.*, count(*) as Anzahl
from Schiedrichter as sr 
    Join Spielleiter using(SchiedsrichterNR)
    Join Spiel using(SpielID)
where sr.SchiedsrichterNR NOT IN(
    select distinct SchiedsrichterNR from Schiedrichter as sr 
        Join Spielleitung using(SchiedsrichterNR)
        Join SchiedsrichterFunktion using(FunktionsID)
    where Bezeichnung = 'Spielleiter'
)
group by Vorname, Nachname, SchiedsrichterNR
having count(*) = (
    Select max(Anzahl) as max from(
    select sr.*, count(*) as Anzahl
    from Schiedrichter as sr 
        Join Spielleiter using(SchiedsrichterNR)
        Join Spiel using(SpielID)
    where sr.SchiedsrichterNR NOT IN(
        select SchiedsrichterNR from Schiedrichter as sr 
            Join Spielleitung using(SchiedsrichterNR)
            Join SchiedsrichterFunktion using(FunktionsID)
        where Bezeichnung = 'Spielleiter'
        )
    group by Vorname, Nachname, SchiedsrichterNR
)
);


-- Wie viele Siege erhielten die Mannschaften

-- Siege heim 

select MannschaftsID, count(*) as anzahlH
from Mannschaft m Join Spiel s On (MannschaftsID = HeimmannschaftsID)
where Heimtore > Gästetore
group by MannschaftsID;

-- Siege gast

select MannschaftsID, count(*) as anzahlG
from Mannschaft m Join Spiel s On (MannschaftsID = GastmannschaftsID)
where Gästetore > Heimtore
group by MannschaftsID;


-- Gesamt anzahl
-- stimmt nicht ganz bräuchte left join und ifNull
select m.*, anzahlH + anzahlG from Mannschaft m 
    join (
        select MannschaftsID, count(*) as anzahlH
        from Mannschaft m Join Spiel s On (MannschaftsID = HeimmannschaftsID)
        where Heimtore > Gästetore
        group by MannschaftsID;
    ) as SiegeHeim using(MannschaftsID)

    Join(
        select MannschaftsID, count(*) as anzahlG
        from Mannschaft m Join Spiel s On (MannschaftsID = GastmannschaftsID)
        where Gästetore > Heimtore
        group by MannschaftsID;
    ) as SiegeGast using(MannschaftsID);

-- Punkte pro Mannschaft bei Unentschieden = 1, Sieg = 3

-- Anderen Inline Views sehe oben

-- unentschieden Heim

select HeimmannschaftsID, count(*) as AUH from Spiel
where heimtore = Gästetore
group by HeimmannschaftsID;

-- unentschiden Gast

select GastmannschaftsID, count(*)as AUG from Spiel
where heimtore = Gästetore
group by GastmannschaftsID;

-- Lösung

select m.*, (IFNULL(anzahlH, 0) + IFNULL(anzahlG,0)) * 3 + IFNULL(AUG,0) + IFNULL(AUH,0) from Mannschaft m 
    left join (
        select MannschaftsID, count(*) as anzahlH
        from Mannschaft m Join Spiel s On (MannschaftsID = HeimmannschaftsID)
        where Heimtore > Gästetore
        group by MannschaftsID;
    ) as SiegeHeim using(MannschaftsID)

    left Join(
        select MannschaftsID, count(*) as anzahlG
        from Mannschaft m Join Spiel s On (MannschaftsID = GastmannschaftsID)
        where Gästetore > Heimtore
        group by MannschaftsID;
    ) as SiegeGast using(MannschaftsID);

    left Join(
        select HeimmannschaftsID, count(*) as AUH from Spiel
        where heimtore = Gästetore
        group by HeimmannschaftsID;
    ) as UnentschiedenHeim ON(MannschaftsID = HeimmannschaftsID)

    left Join(
        select GastmannschaftsID, count(*)as AUG from Spiel
        where heimtore = Gästetore
        group by GastmannschaftsID;
    ) as UnentschiedenGast ON(MannschaftsID = GastmannschaftsID)

-- Karten pro Spieler 

select PersonenID, count(*) as R
from Person Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Strafe using(KaderID, SpielID)
    Join Karte using(KartenID)
    where farbe = 'Rot'
Group BY PersonenID;

select PersonenID, count(*) as G
from Person Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Strafe using(KaderID, SpielID)
    Join Karte using(KartenID)
    where farbe = 'Gelb'
Group BY PersonenID;

select PersonenID, count(*) as RG
from Person Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Strafe using(KaderID, SpielID)
    Join Karte using(KartenID)
    where farbe = 'GelbRot'
Group BY PersonenID;

Select p.*, R.R + G.G + (RG.RG * 2)
from Person as p 
    left Join (
        select PersonenID, count(*) as R
        from Person Join Mannschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
        Join Strafe using(KaderID, SpielID)
        Join Karte using(KartenID)
        where farbe = 'Rot'
        Group BY PersonenID;
    ) as R using PersonenID
    left Join(
        select PersonenID, count(*) as R
        from Person Join Mannschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
        Join Strafe using(KaderID, SpielID)
        Join Karte using(KartenID)
        where farbe = 'Rot'
        Group BY PersonenID;
    ) as G using PersonenID
    left Join(
        select PersonenID, count(*) as RG
        from Person Join Mannschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
        Join Strafe using(KaderID, SpielID)
        Join Karte using(KartenID)
        where farbe = 'GelbRot'
        Group BY PersonenID; 
    )as RG using PersonenID
    where R.R IS NOT NULL
    AND G.G IS NOT NULL
    AND RG.RG IS NOT NULL;

-- Anzahl Spielleiter und Linienrichter

Select SchiedsrichterNR, count(*) as ASPL
from Schiedrichter 
    Join Spielleiter using(SchiedsrichterNR)
    Join SchiedsrichterFunktion using(FunktionsID)
where Bezeichnung = 'Spielleiter'
group by SchiedsrichterNR;

Select SchiedsrichterNR, count(*) as ALR
from Schiedrichter 
    Join Spielleiter using(SchiedsrichterNR)
    Join SchiedsrichterFunktion using(FunktionsID)
where Bezeichnung = 'Linienrichter'
group by SchiedsrichterNR;

select s.*, IFNULL(ASPL, 0) as SpielleiterAnzahl, IFNULL(ALR, 0) as LinienrichterAnzahl
from Schiedrichter as s
    left Join(
        Select SchiedsrichterNR, count(*) as ASPL
        from Schiedrichter 
        Join Spielleiter using(SchiedsrichterNR)
        Join SchiedsrichterFunktion using(FunktionsID)
        where Bezeichnung = 'Spielleiter'
        group by SchiedsrichterNR;
    ) as Spielleiter using(SchiedsrichterNR)
    left Join(
        Select SchiedsrichterNR, count(*) as ALR
        from Schiedrichter 
        Join Spielleiter using(SchiedsrichterNR)
        Join SchiedsrichterFunktion using(FunktionsID)
        where Bezeichnung = 'Linienrichter'
        group by SchiedsrichterNR;        
    ) as Linienrichter using(SchiedsrichterNR);

-- Wenn man die Schiedrichter die nie Spielleiter oder Linenrichter waren nicht sehen will

Select s.*,  SpielleiterAnzahl, LinienrichterAnzahl from
from schiedrichter as s Join(
    Abfrage oben
) as AnzahlPos using(SchiedsrichterNR)
where SpielleiterAnzahl > 0
And LinienrichterAnzahl > 0;


-- Spieler ohne Tore und Karten


-- Spieler mit Tor
select PersonenID from Person 
    Join Manschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Tore using(KaderID, SpielID);


--Spieler mit Karten
select PersonenID from Person 
    Join Manschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Strafe using(KaderID, SpielID);

-- Spieler ohne Tore und Karten

Select p.* from Person as p
    where PersonenID NOT IN(
        select PersonenID from Person 
        Join Manschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
        Join Tore using(KaderID, SpielID)
    )
    AND
    PersonenID NOT IN(
        select PersonenID from Person 
        Join Manschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
        Join Strafe using(KaderID, SpielID)
    )


-- Anzahl Manschaft Kader, das größte und kleinste

Select MannschaftsID, count(*) as AK
from Mannschaft as m
    Join Mannschaftskader using(MannschaftsID)
    Join Person using(PersonenID)
group by MannschaftsID;

Select Max(AK) 
from Mannschaft as m
    Join (Select MannschaftsID, count(*) as AK
        from Mannschaft as m
        Join Mannschaftskader using(MannschaftsID)
        Join Person using(PersonenID) 
        group by MannschaftsID) as Anzahl using(MannschaftsID)


Select MannschaftsID, , Mannschaftsname, count(*) as Anzahl 
from Mannschaft as m
    Join Mannschaftskader using(MannschaftsID)
    Join Person using(PersonenID)
group by MannschaftsID, Mannschaftsname
having count(*) as Anzahl = (
    Select Max(AK) 
    from Mannschaft as m
    Join (Select MannschaftsID, count(*) as AK
    from Mannschaft as m
    Join Mannschaftskader using(MannschaftsID)
    Join Person using(PersonenID) 
    group by MannschaftsID) as Anzahl using(MannschaftsID)
)





-- Die richtige Lösung auf der Cloud
-- alle Aktiven Spieler mit anzahl der Tore

select p.PersonenID, MannschaftsID, count(*) anzahl
from Person as p Join Mannschaftskader as mk using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Tore using(KaderID, SpielID)
where mk.bis IS NULL Or mk.bis > Now()
group by PersonenID, MannschaftsID;




-- Wer hat die meisten Heimniederlagen 

-- Anzahl der Heimniederlagen

select distinct(HeimmannschaftsID), count(*) as Anzahl from Spiel
    where Heimtore < Gasttore
    group by HeimmannschaftsID;

-- das Maximum finden

Select max(Anzahl) from (
    select distinct(HeimmannschaftsID), count(*) as Anzahl from Spiel
    where Heimtore < Gasttore
    group by HeimmannschaftsID;
)

-- Die Mannschaft mit dem Minimum ausgeben

select Mannschaftsname, MannschaftsID, Anzahl
from (
    select distinct(HeimmannschaftsID), count(*) as Anzahl from Spiel
    where Heimtore < Gasttore
    group by HeimmannschaftsID;    
) as Niederlagen
Join Mannschaft on(HeimmannschaftsID = MannschaftsID)
group by Mannschaftsname, MannschaftsID, Anzahl
having Anzahl = (
    Select max(Anzahl) from (
        select distinct(HeimmannschaftsID), count(*) as Anzahl from Spiel
        where Heimtore < Gasttore
        group by HeimmannschaftsID;
    )
);



-- In welchem Ort gab es die meisten Unentschieden

-- Max Anzahl

Select max(Anzahl) from (
    select Ort, StadionID, count(*) as Anzahl from Stadion
    Join Spiel using(StadionID)
    where heimtore = Gästetore
    group by Ort, StadionID
);


--Lösung

select Ort, StadionID, count(*) as Anzahl from Stadion
    Join Spiel using(StadionID)
    where heimtore = Gästetore
group by Ort, StadionID

having count(*) = (
    Select max(Anzahl) from (
        select Ort, StadionID, count(*) as Anzahl from Stadion
        Join Spiel using(StadionID)
        where heimtore = Gästetore
        group by Ort, StadionID
    ) as maxAnzahl
);



-- Welcher Spieler wurde am häufigsten eingesetzt


select vorname, Nachname, PersonenID, count(*) as Anzahl from Person 
    Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
group by vorname, Nachname, PersonenID;

-- Max Anzahl
select max(Anzahl) from(
    select vorname, Nachname, PersonenID, count(*) as Anzahl from Person 
        Join Mannschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
    group by vorname, Nachname, PersonenID;    
);

-- Lösung

select vorname, Nachname, PersonenID, count(*) as Anzahl from Person 
    Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
group by vorname, Nachname, PersonenID

having count(*) = (
    select max(Anzahl) from(
        select vorname, Nachname, PersonenID, count(*) as Anzahl from Person 
            Join Mannschaftskader using(PersonenID)
            Join Aufgestellt using(KaderID)
        group by vorname, Nachname, PersonenID;    
    ) as maximal
);

-- Welche Mannschaft hatte die meisten Abgänge im letzten Jahr --> Year(now()) liefert aktuelles Jahr


select Mannschaftsname, count(*) as Anzahl
from Mannschaft Join Mannschaftskader using(MannschaftsID)
    where Year(bisDat) < Year(now()) -1
    and Year(bisDat) > Year(now()) -2
group by Mannschaftsname;

Select max(Anzahl) from(
    select Mannschaftsname, count(*) as Anzahl
    from Mannschaft Join Mannschaftskader using(MannschaftsID)
        where Year(bisDat) < Year(now()) -1
        and Year(bisDat) > Year(now()) -2
    group by Mannschaftsname;   
);

-- Lösung

select Mannschaftsname, count(*) as Anzahl
from Mannschaft Join Mannschaftskader using(MannschaftsID)
    where Year(bisDat) < Year(now()) -1
    and Year(bisDat) > Year(now()) -2
group by Mannschaftsname
having count(*) = (
    Select max(Anzahl) from(
        select Mannschaftsname, count(*) as Anzahl
        from Mannschaft Join Mannschaftskader using(MannschaftsID)
            where Year(bisDat) < Year(now()) -1
            and Year(bisDat) > Year(now()) -2
        group by Mannschaftsname;   
    ) as maxAnzahl
);

-- Welcher Torwart am häufigsten ausgeschlossen (Rote Karte)

--Alle Torwarte mit Karte

Select Vorname, Nachname, count(*) as Anzahl
from Person 
    Join Vereinsfunktion using(FunktionsID)
    Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Strafe using(KaderID, SpielID)
    Join Karte using(KartenID)
where Bezeichnung = 'Torwart'
and Farbe in('Rot', 'Gelbrot')
group by Vorname, Nachname;

-- Max 

Select max(Anzahl) from (
    Select Vorname, Nachname, count(*) as Anzahl
    from Person 
        Join Vereinsfunktion using(FunktionsID)
        Join Mannschaftskader using(PersonenID)
        Join Aufgestellt using(KaderID)
        Join Strafe using(KaderID, SpielID)
        Join Karte using(KartenID)
    where Bezeichnung = 'Torwart'
    and Farbe in('Rot', 'Gelbrot')
    group by Vorname, Nachname;
)

--Lösung


Select Vorname, Nachname, count(*) as Anzahl
from Person 
    Join Vereinsfunktion using(FunktionsID)
    Join Mannschaftskader using(PersonenID)
    Join Aufgestellt using(KaderID)
    Join Strafe using(KaderID, SpielID)
    Join Karte using(KartenID)
where Bezeichnung = 'Torwart'
and Farbe in('Rot', 'Gelbrot')
group by Vorname, Nachname
having count(*) = (
    Select max(Anzahl) from (
        Select Vorname, Nachname, count(*) as Anzahl
        from Person 
            Join Vereinsfunktion using(FunktionsID)
            Join Mannschaftskader using(PersonenID)
            Join Aufgestellt using(KaderID)
            Join Strafe using(KaderID, SpielID)
            Join Karte using(KartenID)
        where Bezeichnung = 'Torwart'
        and Farbe in('Rot', 'Gelbrot')
        group by Vorname, Nachname;
    )as maxAnzahl
)

-- Spieler, anzahl aufgestellt, Anzahl Tore (aufgestellt > 0)

-- Anzahl der aufgestellt

select PersonenID, count(*) as aufAnzahl 
from Person 
    Join Mannschaftskader using(PersonenID)
    Join aufgestellt using(KaderID)
group by PersonenID
having count(*) > 0;



-- anzahl Tore

select PersonenID, count(*) as ToreAnzahl 
from Person 
    Join Mannschaftskader using(PersonenID)
    Join aufgestellt using(KaderID)
    Join Tore using(KaderID, SpielID)
group by PersonenID;


-- Lösung

Select vorname, Nachname, aufAnzahl, IFNULL(ToreAnzahl, 0) from Person
    Join (
        select PersonenID, count(*) as aufAnzahl 
        from Person 
            Join Mannschaftskader using(PersonenID)
            Join aufgestellt using(KaderID)
        group by PersonenID
        having count(*) > 0;    
    ) as anzahlAufgestellt using(PersonenID)
    Left Join (
        select PersonenID, count(*) as ToreAnzahl 
        from Person 
            Join Mannschaftskader using(PersonenID)
            Join aufgestellt using(KaderID)
            Join Tore using(KaderID, SpielID)
        group by PersonenID;
    ) as anzahlTore using(PersonenID);


-- Mannschaft, toreVerhältnis (erzielte und erhaltene)

Select HeimmannschaftsID, sum(heimtore) from Spiel
group by HeimmannschaftsID;;

Select HeimmannschaftsID, sum(Gästetore) from Spiel
group by HeimmannschaftsID;

Select GastmannschaftsID, sum(heimtore) from Spiel
group by GastmannschaftsID;

Select GastmannschaftsID, sum(Gästetore) from Spiel
group by GastmannschaftsID;

-- Lösung

select Mannschaftsname, (heimerzielt.heimtore + gasterzielt.Gästetore) / (heimerhalten.Gästetore + gasterhalten.heimtore) as Verhältnis
from Mannschaft
    join(Select HeimmannschaftsID, sum(heimtore) from Spiel group by HeimmannschaftsID;) as heimerzielt on (MannschaftsID = HeimmannschaftsID)
    join(Select HeimmannschaftsID, sum(Gästetore) from Spiel group by HeimmannschaftsID;) as heimerhalten on(MannschaftsID = GastmannschaftsID)
    join(Select GastmannschaftsID, sum(heimtore) from Spiel group by GastmannschaftsID) as gasterhalten on(MannschaftsID = GastmannschaftsID)
    join(Select GastmannschaftsID, sum(Gästetore) from Spiel group by GastmannschaftsID) as gasterzielt on(MannschaftsID = GastmannschaftsID);


-- Welche Spieler haben nie ein Tor erzeilt und nie eine Karte erhalten


select PersonenID from Person 
    join MannschaftsID using(PersonenID)
    join aufgestellt using(KaderID)
    join Tor using(KaderID, SpielID);

select PersonenID from Person 
    join MannschaftsID using(PersonenID)
    join aufgestellt using(KaderID)
    join Strafe using(KaderID, SpielID)
    join Karte using(KartenID);

Select Vorname, Nachname from Person
    where PersonenID NOT IN(select PersonenID from Person 
                            join MannschaftsID using(PersonenID)
                            join aufgestellt using(KaderID)
                            join Tor using(KaderID, SpielID))

    AND PersonenID NOT In(select PersonenID from Person 
                           join MannschaftsID using(PersonenID)
                           join aufgestellt using(KaderID)
                           join Strafe using(KaderID, SpielID)
                           join Karte using(KartenID));

-- Welche Vereine haben heuer noch nicht in Wien gespielt

Select GastmannschaftsID
from Spiel
    Join(Stadion) using(StadionID)
where Ort = 'Wien'
and Year(datum) = Year(now());

Select HeimmannschaftsID
from Spiel
    Join(Stadion) using(StadionID)
where Ort = 'Wien'
and Year(datum) = Year(now());

select Mannschaftsname from Mannschaft
    where MannschaftsID not IN (
        Select GastmannschaftsID
        from Spiel
        Join(Stadion) using(StadionID)
        where Ort = 'Wien'
        and Year(datum) = Year(now())  
    )
    and 
    MannschaftsID not In(
        Select HeimmannschaftsID
        from Spiel
        Join(Stadion) using(StadionID)
        where Ort = 'Wien'
        and Year(datum) = Year(now())
    );

