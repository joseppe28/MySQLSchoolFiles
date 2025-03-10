-- ---------------------------------------
-- DML Übung
-- Name:	Josef Meßner
-- Datum: 	13.11.2023
-- ---------------------------------------

-- Spalten wurden in DDL-Übung 1 erschaffen

-- Datensatz einfügen

Insert Into buch
    (id, autor, titel, jahr)
Values
    (1, 'Huber', 'MySQL', 2023);

Insert Into buch
    (autor, titel, preis, jahr)
Values
    ('Josef', 'Anton', 100, 2023);

Insert Into buch Values(NULL, 'Anton', 'Qbb', 'Verlag_Austria', 10000, 2008);

Insert Into lieferanten
    (name, plz, ort)
Values
    ('Huber GmbH', '6460', 'Imst');

Insert Into buch
    (autor, titel, preis, jahr)
Values
    ('Tobu', 'HTL Life', 0, 2020),
    ('Tobi', 'Mein Leben', 0, 2019);

Insert Into lieferanten
    (name, plz, ort)
Values
    ('Schroth AG', 6500, 'Landeck'),
    ('Ritzer OG', 6130, 'Schwaz');