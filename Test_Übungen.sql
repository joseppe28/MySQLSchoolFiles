0Select vorname, nachname
from Person p join Vereinsfunktion b USING(FunktionsID)
where Bezeichnung = 'Trainer';

Select Vorname, Nachname
from Schiedsrichter  join Spielleitung USING (SchiedsrichterNR)
    join Schiedsrichterfunktion USING (FunktionsID)
where Bezeichnung ='Spielleiter';

Select Vorname, Nachname, count(*)
from Schiedsrichter  join Spielleitung USING (SchiedsrichterNR)
    join Schiedsrichterfunktion USING (FunktionsID)
where Bezeichnung ='Spielleiter'
group by SchiedsrichterNR, Vorname, Nachname;

select Mannschaftsname count(*)
from Mannschaft m join Spiel s ON m.MannschaftsID = s.GästemannschaftsID
    join Stadion st USING(StadionID)
where m.Ort = 'Wien'
    st.Ort = 'Innsbruck'
    s.Gästetore < s.heimtore
group by MannschaftsID, Mannschaftsname;

select p.vorname, p.nachname, s.vorname, s.nachname, count(*)
from Person p Join Mannschaftskader USING(PersonenID)
    join Mannschaft USING(MannschaftID)
    join Aufgestellt USING(KaderID)
    join Strafe USING(KaderID, SpielID)
    join karte USING(KaderID, SpielID)
    join Spiel using(SpielID)
    join Spielleitung using(SpielID)
    join Schiedsrichter s using(SchiedsrichterNR)
    join Schiedsrichterfunktion using(FunktionsID)
where Manschaftsname = 'Sturm Graz'
    AND
      Farbe IN('Rot', 'GelbRot')
    AND
     Bezeichnung = 'Spielleiter'
Group BY PersonenID, SchiedsrichterNR, p.vorname, p.nachname, s.vorname, s.nachname;


select max(Heimtore) from Spiel;

select SpielID from Spiel where Heimtore = (select max(Heimtore) from Spiel);

Select PersonenID
from Personen p Join Mannschaftskader mk USING(PersonenID)
    Join aufgestellt USING(KaderID)
    Join Tor USING(KaderID, SpielID);

Select * from Personen where PersonenID NOT IN(
    Select PersonenID
        from Personen p Join Mannschaftskader mk USING(PersonenID)
        Join aufgestellt USING(KaderID)
        Join Tor USING(KaderID, SpielID);)

Select p.*
from Person p join Mannschaftskader USING(KaderID)
    join Aufgestellt USING(KaderID)
    join Tor USING(KaderID, SpielID)
    join Strafe USING(KaderID, SpielID)
    join Karte USING(KartenID)
where Farbe In("Rot", "GelbRot")

Select Vorname, Nachname, Count(*) as Anzahl
from Person p join Mannschaftskader mk USING(PersonenID) join Aufgestellt USING(KaderID)
group by PersonenID, Vorname, Nachname 

select count(*)
from Person Join Mannschaftskader mk USING(PersonenID)
Group BY PersonenID, MannschaftID 