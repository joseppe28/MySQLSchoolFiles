create database schule1;
use schule1;
create table Abteilung (
aid int primary key,
name varchar(255) not null unique
);
Insert Into Abteilung (aid, name) Values
    (1, "Einkauf"),
    (2, "Verkauf");


