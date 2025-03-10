Create database Log_in;

use Log_in;

Create Table Benutzer(
    Email varchar(100),
    passwort varchar(100),

    primary key(Email, passwort)
);

Insert Into Benutzer(Email, passwort)Values
    ("josmessner@tsn.at", "12345"),
    ("Tobzimmermann@tsn.at", "passwort"),
    ("Test@gmail.com", "test");