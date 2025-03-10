-- ---------------------------------------
-- Versteigerung
-- Name:	Josef Meßner
-- Datum: 	26.02.2024
-- ---------------------------------------

Create database if not exists Versteigerung;
use Versteigerung;

Create Table Benutzer(
    BID int Primary Key auto_increment,
    Email varchar(255) unique not null,
    VN varchar(50) not null,
    NN varchar(50) not null,
    Passwort varchar(50) not null
);

Create Table Artikel(
    AID int Primary Key,
    BID int unique not null,
    Bezeichnung varchar(50) not null,
    Beschreibung varchar(3000),
    Start datetime not null default(now()),
    Ende datetime not null,
    Frei tinyint not null default(0),
    Startpreis decimal(12, 2) not null,

    constraint StartEnde CHECK(Start < Ende)
);

Create Table Gebote(
    GID int Primary Key auto_increment,
    BID int not null,
    AID int not null,
    ZP datetime not null default(now()),
    Preis decimal(12,2) not null,

    constraint UArtikelMitPreis unique(AID, Preis),
    constraint UBenutzerArtikelZeit unique(BID, AID, ZP)
);

Alter Table Artikel add constraint ArtikelBenutzer Foreign Key(BID) References Benutzer(BID);

-- Alter Table Artikel drop foreign Key ArtikelBenutzer;

Alter Table Gebote add constraint GeboteBenutzer Foreign Key(BID) References Benutzer(BID);
Alter Table Gebote add constraint GeboteArtikel Foreign Key(AID) References Artikel(AID);

Select max(Preis) from Gebote where AID = 27;

select AID, max(Preis) from Gebote Group By AID Having max(Preis) > 1000 Order BY  max(Preis)desc;

select AID, max(Preis) as P from Gebote Group By AID Having P > 1000 Order BY  P desc;
-- 2 ist der max(Preis) 1 wäre AID
select AID, max(Preis) as P from Gebote Group By AID Having 2 > 1000 Order BY  2 desc;

Select BID, count(*) from Artikel Group By BID;

Select VN, NN, Bezeichnung, a.BID from Benutzer as b join Artikel as a  on b.BID = a.BID 

Select VN, NN, Bezeichnung, BID from Benutzer b Join Artikel a using(BID)

Select VN, NN, Preis from Benutzer b Join Gebot g on b.BID = g.BID where AID = 33;

Select VN, NN, Preis, Bezeichnung from Benutzer b Join Gebot g on b.BID = g.BID Join Artikel a on g.AID = a.AID where g.AID = 33;

-- kommt nach refrences 
-- on delete set null/ cascade/ set default/ restrict
-- bei resctrict wird nichts ausgeführt wenn ein Fehler vorhanden ist(Am Anfang Überprüft) 
-- bei no action führt zuerst Änderungen durch und Überprüft am Ende
