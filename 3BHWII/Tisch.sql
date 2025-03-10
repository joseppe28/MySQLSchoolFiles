create database Tisch;

use Tisch;

create Table tisch(
    SNR int primary key auto_increment,
    lenght int,
    height int, 
    width int,
    material varchar(50)
);

Update Tisch set material = "Zirbe" where SNR = 7;
Update Tisch set lenght = 150 where SNR = 7;
Update Tisch set width = 500 where SNR = 7;
Update Tisch set height = 800 where SNR = 7;