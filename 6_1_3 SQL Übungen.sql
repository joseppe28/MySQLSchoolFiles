-- ---------------------------------------
-- SQL Übungen
-- Name:	Josef Messner
-- Datum: 	15.01.24
-- ---------------------------------------

Create database if not exists Test2;

use Test2;

Create table if not exists Patienten(
    ID int Primary Key AUTO_INCREMENT,
    Vorname varchar(50),
    Nachname varchar(50),
    GebDat date,
    Kosten decimal(8,2),
    SVNR varchar(10) default(9999),
    KassenID int
);

Insert Into Patienten(Vorname, Nachname, GebDat, Kosten, SVNR, KassenID)
Values
    ('Paula', 'Nagele', '2002-10-15', 249.00, '1254', 1),
    ('Rosa', 'Huber', '1990-02-02', 354.00, '8975', 4),
    ('Josef', 'Lechner', '2004-06-27', 369.00, '1579', 2),
    ('Fritz', 'Huber', '1994-08-08', 414.80, '3587', 3),
    ('Beate', 'Müller', '1992-05-21', 987.00, '1258', 1),
    ('Sonja', 'Kopp', '1974-07-13', 158.80, '6472', 4);

Select Distinct Nachname from Patienten where KassenID = 4 and  Kosten between 250 and 440;

Alter table Patienten add Email char(35);

Select Nachname, Kosten from Patienten where
    KassenID IN(1,3,4)
and
    Nachname Like '_%er'
Order By Kosten DESC;


Select Distinct Nachname from Patienten where
    KassenID IN(1,3,4)
and
    Nachname Like '_%er'
Order By Nachname DESC;

Alter Table Patienten add Diagnose varchar(100);

Insert Into Patienten(SVNR, Nachname, Kosten, Diagnose)
Values
('2367', 'Rodler', 57.20, 'Beinbruch');

Update Patienten SET KassenID = 3, Nachname = 'Lutz', Kosten = 158.40
    where ID = 2;

Delete From Patienten where KassenID = 1 and Nachname like '%b_';

Update Patienten Set Kosten = Kosten * 1.19
    where GebDat > '2003-11-06';