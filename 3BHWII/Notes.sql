Create Database Notes;
use Notes;

Create Table Note(
    nid int primary key auto_increment,
    name varchar(100),
    note varchar(1000)
);

drop table Note;