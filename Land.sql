-- ---------------------------------------
-- Projekt- bzw. Übungsname
-- Name:	Max Mustermann
-- Datum: 	03.12.2022
-- ---------------------------------------

SOURCE C:\TMP\backUp\Land.sql


Select * from land;

Select name from land;

Select * from land where einwohner > 1E08;

select * from land where 
bip between 1 and 1E011
AND 
region = 'Asien';

select name, einwohner from land where name In('Frankreich', 'Deutschland', 'Polen');

Select name, einwohner/1000000 as 'Einwohner in Millionen' from land where region = 'Südamerika'
Order BY bip DESC;

select name from land where name Like '%Vereinigte%';

Select Distinct(region) from land Order By region ASC;

Select name from land where bip IS NULL;

select Sum(einwohner) as 'Weltbevölkerung' from land;

select AVG(bip) from land;

Select sum(einwohner) ,sum(bip) from land where region = 'Europa';

Select min(flaeche), max(flaeche) from land;

Select count(Distinct(region)) from land;

Select region, count(name) from land where einwohner > 1E07 Group By region;

Select region, sum(einwohner) from land Group By region having sum(einwohner) > 1E08;

Select region, sum(einwohner), sum(flaeche) from land Group By region Order By sum(einwohner) ASC;

Select region, sum(einwohner), sum(flaeche) from land Group By region Having region Like '%Amerika%' Order By sum(einwohner) ASC;