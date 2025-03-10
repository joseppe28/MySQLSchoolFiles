--DDL (man braucht gewisse Rechte, um sie anzulegen)
Create View ToreVonSpielern as Select PersonenID, vorname, nachname, count (*) as Toranzahl From Personen join Manschaftskader using (PersonenID)
			       join aufgestellt using (kaderID)
       Join tor using (SpielID, KaderID);

Select max(toranzahl) from toreVonSpielern ()


Select max(toranzahl) from ( -- Inline View:
                             -- jede Spalte braucht einen gültigen SQL-Namen (immer alias bei count etc.)
    Select PersonenID, vorname, nachname, count (*) as Toranzahl From Personen 
              join Manschaftskader using (PersonenID)
		join aufgestellt using (kaderID)
              Join tor using (SpielID, KaderID);
) as toreVonSpielern -- Jeder Inline-View braucht einen Namen

-- Welcher Spieler hat am meisten Karten erhalten

Create View KartenAnzahl as Select count(*) as Karten, PersonenID, vorname, nachname from Spieler
       join Manschaftskader using(PersonenID)
       join aufgestellt using(KaderID)
       join Strafe using(SpielID, KaderID)
group by PersonenID, vorname, nachname;

Select max(Karten), vorname, nachname from KartenAnzahl

Select max(Karten) from(
       Select count(*) as Karten, PersonenID, vorname, nachname from Spieler
              join Manschaftskader using(PersonenID)
              join aufgestellt using(KaderID)
              join Strafe using(SpielID, KaderID)
       group by PersonenID, vorname, nachname           
) as KartenAnzahl

Select count(*) as Karten, PersonenID, vorname, nachname from Spieler
       join Manschaftskader using(PersonenID)
       join aufgestellt using(KaderID)
       join Strafe using(SpielID, KaderID)
group by PersonenID, vorname, nachname
Having count(*) = (select max(Karten) from KartenAnzahl);

Select Vorname, nachname, PersonenID, count(*) as Karten from KartenAnzahl
Where Karten = (Select max(karten) from KartenAnzahl)

-- =======================================================
-- Welcher Schiedsrichter hat am meisten Spiele geleitet
-- =======================================================

create view SchiedsrichterAnzahl as Select SchiedsrichterNR, vorname, nachname, count(*) as Anzahl from Schiedsrichter
       Join Spielleitung using(SchiedsrichterNR)
       Join Schiedsrichterfunktion using(FunktionsID)
where Bezeichung = 'Spielleiter'
group by SchiedsrichterNR, vorname, nachname;

Select * from SchiedsrichterAnzahl where Anzahl = (Select max(Anzahl) from SchiedsrichterAnzahl);


-- In welchem Stadion fallen die meisten Tore

Create View TorAnzahl as
select StadionID, Stadionname, sum(Heimtore + GästeTore) as Tore
from Stadion Join Spiel using(StadionID)
group by StadionID, Stadionname;

select * from TorAnzahl where Tore = (select max(Tore) from TorAnzahl);

-- welcher Verein hat den Höchsten aktiven Kader

create View aktiveSpieler as
Select Mannschaftsname, count(*) as Anzahl
from Mannschaft join Mannschaftskader using(MannschaftsID)
where bis is null or bis > now()
group by MannschaftsID, Mannschaftsname;

select * from aktiveSpieler where Anzahl = (select max(Anzahl) from aktiveSpieler);




-- Welcher Spieler der keine Karte erhalten hat, hat die meisten Tore


select PersonenID from Person
       join Mannschaftskader using(PersonenID)
       join aufgestellt using(KaderID)
       join Strafe using(KaderID, SpielID);



create View SpielerOhneKarteMitTor as
select Vorname, Nachname, count(*) as Tore
from Person join Mannschaftskader using(PersonenID)
       join aufgestellt using(KaderID)
       join Tor using(KaderID, SpielID)
where PersonenID NOT IN(
              select PersonenID from Person
              join Mannschaftskader using(PersonenID)
              join aufgestellt using(KaderID)
              join Strafe using(KaderID, SpielID)
              )
group by Vorname, Nachname, PersonenID;

select * from SpielerOhneKarteMitTor where Tore = (Select max(Tore) from SpielerOhneKarteMitTor);



Create View SiegeHeim as
select MannschaftsID, count(*) as Punkte from Mannschaft join Spiel ON(MannschaftsID = heimmannschaftsID) where Heimtore > GästeTore
group by MannschaftsID;

Create View SiegeGast as
select MannschaftsID, count(*) as Punkte from Mannschaft join Spiel ON(MannschaftsID = GästeMannschaftsID) where Heimtore < GästeTore
group by MannschaftsID;

Create View GleichstandHeim as
select MannschaftsID, count(*) as Punkte from Mannschaft join Spiel ON(MannschaftsID = heimmannschaftsID) where Heimtore = GästeTore
group by MannschaftsID;

Create View GleichstandGast as
select MannschaftsID, count(*) as Punkte from Mannschaft join Spiel ON(MannschaftsID = GästeMannschaftsID) where Heimtore = GästeTore
group by MannschaftsID;


Select MannschaftsID, 
       IFNULL(hs.Punkte, 0) * 3 + 
       IFNULL(gs.Punkte, 0) * 3 + 
       IFNULL(us.Punkte, 0) + 
       IFNULL(ug.Punkte, 0) AS Punkte
from Mannschaft where MannschaftsID Left join SiegeHeim as hs using(MannschaftsID)
       Left join SiegeGast as gs using(MannschaftsID) -- Alle Einträge von der linken Tabelle behalten
       left join GleichstandHeim as us using(MannschaftsID) -- Man kann auch Left OUTER Join schreiben macht das gleiche 
       Left join GleichstandGast as ug using(MannschaftsID)




Create View KartenAnzahl as
select count(*) as Anzahl, PersonenID  from Person 
       Join Mannschaftskader using(PersonenID)
       Join aufgestellt using(KaderID)
       Join Strafe using(KaderID, SpielID)
group by PersonenID;

Create View TorAnzahl as
select count(*) as Anzahl, PersonenID  from Person 
       Join Mannschaftskader using(PersonenID)
       Join aufgestellt using(KaderID)
       Join Tor using(KaderID, SpielID)
group by PersonenID;


select Vorname, Nachname, IFNULL(t.Anzahl, 0) as Tore, IFNULL(k.Anzahl, 0) as karten from Person
       Left Join Toranzahl as t using(PersonenID) 
       left Join KartenAnzahl as k using(PersonenID);


create View Heimsiege as
select StadionID, count(*) as Anzahl from Spiel where Heimtore > GästeTore group by StadionID;

create View Gästesiege as
select StadionID, count(*) as Anzahl from Spiel where Heimtore < GästeTore group by StadionID;

create View Unentschieden as
select StadionID, count(*) as Anzahl from Spiel where Heimtore = GästeTore group by StadionID;

Select Stadionname, IFNULL(h.Anzahl, 0) as Heimsiege, IFNULL(g.Anzahl, 0) as Gästesiege, IFNULL(u.Anzahl) as Unentschieden from Stadion
       Left Join Heimsiege as h using(StadionID)
       Left Join Gästesiege as g using(StadionID)
       Left Join Unentschieden as u using(StadionID);


-- Mannschaften und ihr Torverhältnis

Create View AnzahlHeimTore as
Select heimmannschaftsID, sum(Heimtore) as anzahl, sum(GästeTore) as anzahlGegen as  from Spiel
group by heimmannschaftsID;

Create View AnzahlGästeTore as
Select GästeMannschaftsID, sum(GästeTore) as anzahl, sum(Heimtore) as anzahlheim from Spiel
group by GästeMannschaftsID;


select Mannschaftsname, ifNull(h.anzahl, 0) + ifNull(g.anzahl, 0) as Tore, ifNull(g.anzahlheim, 0) + ifNull(h.anzahlGegen, 0) as GegenTore from Mannschaft
       Left join AnzahlHeimTore as h ON(MannschaftsID = heimmannschaftsID)
       Left join AnzahlGästeTore as g ON(MannschaftsID = GästeMannschaftsID);

-- ==========================================
-- Mannschaften, AnzahlRote, #AnzahlGelbe
-- GelbRot --> als Rot zählen
-- ==========================================

Create View Rote as
Select MannschaftsID, count(*) as Anzahl from Mannschaft
       join Mannschaftskader using(MannschaftsID)
       join aufgestellt using(KaderID)
       join Strafe using(KaderID, SpielID)
       join Karte using(KartenID)
where Farbe IN('Rot', 'GelbRot')
Group BY MannschaftsID;

Create View Gelbe as
Select MannschaftsID, count(*) as Anzahl from Mannschaft
       join Mannschaftskader using(MannschaftsID)
       join aufgestellt using(KaderID)
       join Strafe using(KaderID, SpielID)
       join Karte using(KartenID)
where Farbe IN('Gelb')
Group BY MannschaftsID;

Select Mannschaftsname, IFNULL(r.Anzahl, 0) as Rote, IFNULL(g.Anzahl, 0) as Gelbe from Mannschaft
       Left join rote r using(MannschaftsID)
       Left join gelbe g using(MannschaftsID);

-- cool so viel orange
Select from as join using On Create In Not And Or Delete Update IFNULL IS Null now where Group By Having Insert Into table 


Create View Spielleiter as 
Select SchiedsrichterNR count(*) as Anzahl from Spielleitung
       join Schiedsrichterfunktion using(FunktionsID)
where Bezeichnung = 'Spielleiter'
Group BY SchiedsrichterNR;

Create View Linienrichter as 
Select SchiedsrichterNR count(*) as Anzahl from Spielleitung
       join Schiedsrichterfunktion using(FunktionsID)
where Bezeichnung = 'Linienrichter'
Group BY SchiedsrichterNR;

Create View VAR as 
Select SchiedsrichterNR count(*) as Anzahl from Spielleitung
       join Schiedsrichterfunktion using(FunktionsID)
where Bezeichnung = 'VAR'
Group BY SchiedsrichterNR;

select vorname, nachname, IFNULL(s.anzahl, 0) as Spielleiter, IFNULL(l.anzahl, 0) as Linienrichter, IFNULL(v.anzahl, 0) as VAR from Schiedsrichter
       Left join Spielleiter s using(SchiedsrichterNR)
       Left join Linienrichter l using(SchiedsrichterNR)
       Left join VAR v using(SchiedsrichterNR);

-- Anzahl Einsätze, Anzhal Tore, Anzahl Karten

Create View Spiele as
Select PersonenID, count(*) as Anzahl from MannschaftsID
       join aufgestellt using(KaderID)
group by PersonenID;


Create View Tore as
Select PersonenID, count(*) as Anzahl from MannschaftsID
       join aufgestellt using(KaderID)
       join Tor using(KaderID, SpielID)
group by PersonenID;

Create View Karten as
Select PersonenID, count(*) as Anzahl from MannschaftsID
       join aufgestellt using(KaderID)
       join Strafe using(KaderID, SpielID)
group by PersonenID;

Select vorname, Nachname, IFNULL(s.Anzahl, 0) as Spiele, IFNULL(t.Anzahl,0) as Tore, IFNULL(k.Anzahl, 0) as Karten from Person
       Left Join Spiele s using(PersonenID)
       Left Join Tore t using(PersonenID)
       LEft Join Karten k using(PersonenID);