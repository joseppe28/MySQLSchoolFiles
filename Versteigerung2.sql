-- ---------------------------------------
-- Versteigerung
-- Name:	Josef Meßner
-- Datum: 	4.03.2024
-- ---------------------------------------

Create database if not exists Versteigerung;
use Versteigerung;

Create Table Benutzer(
    BID int Primary Key auto_increment,
    Email varchar(255) unique not null,
    VN varchar(50) not null,
    NN varchar(50) not null,
    Passwort varchar(50) not null,
    status varchar(100) not null default('aktiv')
);

Create Table stornoStatus(
    bez varchar(100) Primary Key,
    datum datetime default(now())
);

Create Table Artikel(
    AID int Primary Key auto_increment,
    BID int not null,
    Bezeichnung varchar(50) not null,
    Beschreibung varchar(3000),
    Start datetime not null default(now()),
    Ende datetime not null,
    Frei tinyint not null default(0),
    Startpreis decimal(12, 2) not null,
    status varchar(50), not null default('aktiv'),

    constraint StartEnde CHECK(Start < Ende)
);

Create Table Gebote(
    GID int Primary Key auto_increment,
    BID int not null,
    AID int not null,
    ZP datetime not null default(now()),
    Preis decimal(12,2) not null,
    status varchar(50) not null default('aktiv'),

    constraint UArtikelMitPreis unique(AID, Preis),
    constraint UBenutzerArtikelZeit unique(BID, AID, ZP)
);

Create Table BenutzerHIST(
    BID int Primary Key,
    Email varchar(255),
    VN varchar(50),
    NN varchar(50),
    Passwort varchar(50),
    Status varchar(100)
);
Create Table ArtikelHIST(
    AID int Primary Key,
    BID int,
    Bezeichnung varchar(50),
    Beschreibung varchar(3000),
    Start datetime,
    Ende datetime,
    Frei tinyint,
    Startpreis decimal(12, 2)
);
Create Table GebotHIST(
    GID int Primary Key,
    BID int,
    AID int,
    ZP datetime ,
    Preis decimal(12,2)
);

Alter Table Benutzer add constraint stornoStatus Foreign Key(Status) References stornoStatus(bez);
Alter Table Artikel add constraint ArtikelstornoStatus Foreign Key(Status) References stornoStatus(bez);
Alter Table Artikel add constraint ArtikelBenutzer Foreign Key(BID) References Benutzer(BID);

-- Alter Table Artikel drop foreign Key ArtikelBenutzer;
-- Insert Into TabA (s1, ..., sn) select s1, ... , sn from TabA where...

Alter Table Gebote add constraint GeboteBenutzer Foreign Key(BID) References Benutzer(BID);
Alter Table Gebote add constraint GeboteArtikel Foreign Key(AID) References Artikel(AID);

Insert Into stornoStatus(bez) Values 
    ('aktiv'),
    ('Storno'),
    ('Fertig'),
    ('deaktiviert');

Insert Into Benutzer(Email, VN, NN, Passwort) Values 
    ('josmessner@tsn.at', 'Josef', 'Messner', 'Passwort'),
    ('tobZimmermann@tsn.at', 'Tobias', 'Zimmermann', '1234'),
    ('Email@gmail.at', 'Emanuel', 'Mail', 'EmMai1012'),
    ('anSuntinger@tsn.at', 'Anton', 'Suntinger', 'RedBull'),
    ('HTL-Dieb', 'saiboT', 'nnamremmiZ', '4321');

Insert Into Artikel(BID, Bezeichnung, Beschreibung,Ende, Frei, Startpreis) Values 
    (1, 'Lampe', 'Leuchtet gut', '2024-03-15 11:24:12', 1, 200.00),
    (2, 'Tisch', 'steht gut', '2024-06-01 17:00:00',0, 174.99),
    (3, 'Zug', 'Öbb Zug zum Verkaufen', '2024-04-10 23:24:12', 1, 10000.01),
    (4, 'Autobahn', 'Deutsche Autobahn jetzt im Angebot', '2025-12-24 12:12:12', 1, 10.00),
    (5, 'Tafel', 'Holz Tisch', '2024-03-17 17:30:00', 1, 99.99),
    (5, 'Stuhl', 'Gelber Stuhl', '2024-03-17 17:30:00', 1, 49.99);

Insert Into Gebote(BID, AID, Preis) Values
    (1, 1, 200.00),
    (2, 2, 174.99),
    (3,3,10000.01),
    (4,4,10.00),
    (5,5, 99.99),
    (5,6, 49.99);

Create index ArtikelBenutzerGebot on Gebote(AID, BID);
Create index GebotPreis on Gebote(Preis, AID);
Create index ArtikelBenutzer on Artikel(BID, AID);