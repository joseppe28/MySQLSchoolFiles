-- ---------------------------------------
-- 1.Übung DDL
-- Name:	Josef Meßner
-- Datum: 	06.11.23
-- ---------------------------------------

-- 1.) Erstelle eine neue Datenbank von euerer Klasse aber nur, wenn diese nicht bereits existiert
CREATE database if not exists 2BHWII;
-- Alle DBs anzeigen
SHOW databases;
-- DB löschen
DROP database if exists 2BHWII;
-- Alle DBs anzeigen
SHOW databases;

-- 1. Tabelle erstellen

CREATE TABLE tab1(
    ID int NOT NULL auto_increment,
    Name char(30),
    PLZ int,
    primary key(ID)
);

-- Namen der Klasse

Create table if not exists personen(
    ID int,
    Vorname char(30),
    Nachname char(30),
    PLZ char(10),
    Stadt char(30)
);

-- Datenstruktur von Tabellen verändern

ALTER TABLE personen RENAME mitarbeiter;

-- und wieder zurück

ALTER TABLE mitarbeiter RENAME personen;

-- Neue Spalte hinzufügen

Alter TABLE personen ADD Geschlecht char(1);

-- Mit position

ALTER TABLE personen ADD Anrede ENUM('Frau', 'Herr') AFTER ID; 

-- Geburtsdatum und Gehalt hinzufügen

ALTER TABLE personen ADD Geburtsdatum date;
ALTER TABLE personen ADD Gehalt DECIMAL(10,2);

-- Sozialversicherungsnummer

Alter Table personen Add svnr varchar(12);

-- Löschen der Spalte

Alter Table personen drop svnr;
Alter Table personen drop Anrede;

-- Spalten ändern

Alter Table personen modify Geschlecht varchar(3);

-- Spalte umbenennen

Alter Table personen change Gehalt Einkommen int;

-- Emirhak verdient nicht coolle Zahen deswegen ändern des Datentyps.

Alter Table personen modify Einkommen Decimal(8,2);

-- Primary Key hinzufügen

Alter Table personen ADD Primary Key(ID);

-- Primary Key löschen

Alter Table personen drop primary key;

-- Standartwert festlegen

Alter Table personen Alter plz set default '1234';

-- Standartwert löschen

Alter Table personen Alter plz drop default;

-- Letzte Übung zu DDL

Create Table if not exists Buchliste(
    id int, 
    autor varchar(50),
    buchtitel varchar(50),
    preis Decimal(10,2),
    Jahr int Not Null
);

Alter Table Buchliste Rename buch;

Alter Table buch ADD verlag char(50) after buchtitel;

Alter Table buch change buchtitel titel Varchar(20);

Alter Table buch Alter preis set default '10';

Alter Table buch ADD Primary KEY(id);

Alter Table buch modify Jahr Year Not Null;

-- id auto-increment hinzufügen

Alter Table buch modify id int auto_increment;