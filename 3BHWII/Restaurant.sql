Create Database Restaurant; 
use Restaurant;

Create Table Restaurant(
    RESTNR int primary key,
    PLZ int not null,
    Ort varchar(100) not null,
    Straße varchar(100) not null,
    Hausnummer varchar(100) not null, 

    LNR int not null
);

Create Table Mitarbeiter(
    PNR int primary key,
    SVNR int not null,
    Anschrift varchar(100) not null,
    seit date not null,
    bis date,
    ANR int not null,
    BEZ varchar(100) not null,
    Ausbildung varchar(500)
);


