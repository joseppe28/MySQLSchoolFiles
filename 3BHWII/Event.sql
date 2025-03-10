create database EventManagment;

use EventManagment;

Create Table Veranstaltungen(
    VID int primary key auto_increment,
    BEZ varchar(100) not null,
    Beschreibung varchar(500) not null,
    Dauer int not null,
    VON datetime not null,
    BIS datetime not null,
    Poster boolean,
    SID int not null,
    Tag char(1),

    -- Film
    Genre varchar(20), 
    Regisseur varchar(40),
    FSK varchar(10), 

    -- Theater
    Theatergruppe varchar(100),

    -- Konzert
    Musikrichtung varchar(20),
    Band varchar(50)
);
Create Table Saal(
    SID int primary key,
    BEZ varchar(50) not null,
    Ort varchar(100)
);
Create Table Platz(
    PID int primary key,
    PNR varchar(10) not null,
    Preis decimal(8, 2) not null,
    SID int
);
Create Table Ticket(
    TNR int primary key,
    Zeitpunkt datetime not null,
    PID int,
    VID int,
    BNR int,
    KNR int
);
Create Table Kunde(
    KNR int primary key,
    NNAME varchar(30) not null,

    VIP char(1),
    VNAME varchar(30),
    GEBDAT datetime,
    Telefon varchar(100),
    Geschlecht char(1),
    Adresse varchar(100)
);
Create Table Account(
    Email varchar(100) primary key,
    Passwort varchar(100) not null,
    KNR int 
);
Create Table Bestellung(
    BNR int primary key,
    Zeitpunkt datetime not null,
    Anmerkungen varchar(100) not null,
    Email varchar(100)
);
Create Table OnlineVerkauf(
    OID int primary key,
    BNR int,
    BEZ varchar(100),
    Hersteller varchar(50),
    Stück int not null
);
Create Table Veranstaltungsort(
    Name varchar(100) primary key
);
Create Table MerchandiseVerkauf(
    MVID int primary key,
    Name varchar(100) not null,
    BEZ varchar(100),
    Hersteller varchar(50),
    Lagerstand int not null
);
Create Table MerchandiseArtikel(
    BEZ varchar(100),
    Hersteller varchar(50),
    Beschreibung varchar(150) not null,
    Preis decimal(8,2) not null,
    VID int,

    primary key(BEZ, Hersteller),
);
Create Table Mitarbeiter(
    SV_NR int primary key,
    VNAME varchar(100) not null,
    NNAME varchar(100) not null
);
Create Table Arbeit(
    AID int primary key,
    SV_NR int,
    Name varchar(100),
    Rolle varchar(20) not null
);

Alter Table Veranstaltungen add constraint VeranstaltungenSaal Foreign Key(SID) References Saal(SID);
Alter Table Saal add constraint SaalOrt Foreign Key(Ort) References Veranstaltungsort(Name);
Alter Table Platz add constraint SaalPlatz Foreign Key(SID) References Saal(SID);
Alter Table Ticket add constraint TicketPlatz Foreign Key(PID) References Platz(PID);
Alter Table Ticket add constraint TicketVeranstalltungen Foreign Key(VID) References Veranstaltungen(VID);
Alter Table Ticket add constraint TicketKunde Foreign Key(KNR) References Kunde(KNR);
Alter Table Ticket add constraint TicketBestellung Foreign Key(BNR) References Bestellung(BNR);
Alter Table Account add constraint AccountKunde Foreign Key(KNR) References Kunde(KNR);
Alter Table Bestellung add constraint BestellungAccount Foreign Key(Email) References Account(Email);
Alter Table OnlineVerkauf add constraint OVMA Foreign Key(BEZ, Hersteller) References MerchandiseArtikel(BEZ, Hersteller);
Alter Table OnlineVerkauf add constraint OVB Foreign Key(BNR) References Bestellung(BNR);
Alter Table MerchandiseArtikel add constraint MAV Foreign Key(VID) References Veranstaltungen(VID);
Alter Table MerchandiseVerkauf add constraint MVMA Foreign Key(BEZ, Hersteller) References MerchandiseVerkauf(BEZ, Hersteller);
Alter Table MerchandiseVerkauf add constraint MVVO Foreign Key(Name) References Veranstaltungsort(Name);
Alter Table Arbeit add constraint AVO Foreign Key(Name) References Veranstaltungsort(Name);
Alter Table Arbeit add constraint AM Foreign Key(SV_NR) References Mitarbeiter(SV_NR);
Alter Table Mitarbeiter add constraint MM Foreign Key(V_SV_NR) References Mitarbeiter(SV_NR);


Alter Table Mitarbeiter add V_SV_NR int;