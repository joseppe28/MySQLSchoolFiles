Create database Adressbuch;
use Adressbuch;

Create Table Personen(
    ID int primary key auto_increment,
    NN varchar(100) not null,
    VN varchar(100) not null,
    Adresse varchar(200) not null,
    PLZ varchar(20) not null
);

Insert Into Personen(VN, NN, Adresse, PLZ)
Values
('Josef', 'Messner', 'Obere Puite 226', '6405'),
('Tobias', 'Zimmermann', 'Zirler Industriegebiet', '6401'),
('Florian', 'Kainz', 'Villa in Kematen', '6403');


Create database Noteneingabe;
use Noteneingabe;

Create Table Schüler(
    VN varchar(50),
    NN varchar(50),
    SID int primary key auto_increment
);

Create Table Benotung(
    SID int,
    Fach varchar(100),
    Note int,
    primary key(SID, Fach)
);

Alter Table Benotung add constraint SchülerNummer Foreign Key(SID) References Schüler(SID);

Insert Into Schüler(VN, NN, SID) Values
    ("Josef", "Messner", 1),
    ("Tobias", "Zimmermann", 2),
    ("Florian", "Kainz", 3),
    ("Lukas", "Eberhardt", 4);