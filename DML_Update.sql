-- ---------------------------------------
-- DML-Update
-- Name:	Josef Meßner
-- Datum: 	27.11.2023
-- ---------------------------------------

use lager;

Update lieferanten SET name = 'Systech GmbH'
    where name = 'Ritzer OG';

Update lieferanten Set plz = NULL
    where id = 15;

Select * from lieferanten where plz IS NOT NULL; 

Update lieferanten SET PLZ = 6410, Ort = 'Telfs'
    where id = 13;

Delete FROM lieferanten where id = 14;