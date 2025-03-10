use Versteigerung;

Insert Into BenutzerHIST(BID, Email, VN, NN, Passwort, Status) select BID, Email, VN, NN, Passwort, Status from Benutzer
        where status = 'deaktiviert' on duplicate key update BID = Values(BID), Email = Values(Email), VN = Values(VN), NN = Values(NN),
                                                             Passwort = Values(Passwort), Status = Values(Status);

Insert Into ArtikelHIST(AID, BID, Bezeichnung, Beschreibung, Start, Ende, Frei, Startpreis)
select AID,BID, Bezeichnung, Beschreibung, Start, Ende, Frei, Startpreis from Artikel where status IN('Storno', 'Fertig') on duplicate key update
        AID = Values(AID), BID = Values(BID), Bezeichnung = Values(Bezeichnung), Beschreibung = Values(Beschreibung), Start= Values(Start),
        Ende = Values(Ende), Frei = Values(Frei), Startpreis = Values(Startpreis);

Insert Into GebotHIST(GID, BID, AID, ZP, Preis) select GID, BID, AID, ZP, Preis from Gebote where status In('Storno','Fertig')
    on duplicate key update GID = Values(GID), BID = Values(BID), AID = Values(AID), ZP = Values(ZP), Preis = Values(Preis);

Delete from Gebote where status IN('Storno', 'Fertig');
Delete from Artikel where status IN('Storno', 'Fertig');

Optimize Table Gebote;
Optimize Table Artikel;


