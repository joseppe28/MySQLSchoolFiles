-- ---------------------------------------
-- Bundesliga
-- Name:	Josef Meßner
-- Datum: 	19.02.2024
-- ---------------------------------------

Create database if not exists bundesliga;
use bundesliga;


Create Table if not exists Verein(
    VID int Primary Key,
    name varchar(50) unique
);

Create Table if not exists Spieler(
    SpPossNr int Primary Key,
    VID int not null,
    VN varchar(50),
    NN varchar(50)
    Foreign Key(VID) References Verein(VID)
);

Create Table if not exists Stadion(
    StadionID int Primary Key,
    StadionName varchar(50) unique,
    Adresse varchar(50)
);

Create Table if not exists Spiel(
    SpielID int Primary Key,
    HeimID int not null,
    GastID int not null, 
    spieltag date not null,
    StadionID int not null,

    Foreign Key(HeimID) References Verein(VID),
    Foreign Key(GastID) References Verein(VID),
    Foreign Key(StadionID) References Stadion(StadionID)

);

Create Table if not exists Torschützen(
    TorID int Primary Key,
    SpielerID int not null,
    SpielID int not null,
    minute int not null,

    Foreign Key(SpielerID) References Spieler(SpPossNr),
    Foreign Key(SpielID) References Spiel(SpielID)
);

Create Table if not exists Schiedsrichter(
    SchiedsrichterID int Primary Key,
    VN varchar(50) not null,
    NN varchar(50) not null
);

Create Table if not exists Linienrichter(
    LinienrichterID int Primary Key,
    VN varchar(50) not null,
    NN varchar(50) not null
);



Create Table if not exists Karten(
    KartenID int Primary Key,
    Farbe varchar(10) not null,
    minute int not null, 
    SpielerID int not null,
    SchiedsrichterID int not null,
    SpielID int not null,

    Foreign Key(SpielerID) References Spieler(SpielerID),
    Foreign Key(SchiedsrichterID) References Schiedsrichter(SchiedsrichterID),
    Foreign Key(SpielID) References Spiel(SpielID)
);