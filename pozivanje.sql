insert into EKSPOZITURA(NAZIVEKSPOZITURE,ADRESAEKSPOZITURE)
values ('Ekspozitura Beograd','Laze Kostica 1 , Beograd')

insert into radnik (IDEKSPOZITURE,IDPOZICIJE,IMERADNIKA,PREZIMERADNIKA,kontaktradnika,EMAILRADNIKA,RADNIKKORIME,RADNIKKORPASSWORD,jmbgRadnika)
values(13,17,'Danilo','Cirkovic',381643218991,'daniloc@gmail.com','DaniloC217','JxHd3Pb35qJKRqp','0404013617248')


select * from radnik

update radnik
set RADNIKKORPASSWORD = '1408989407158'
where IDRADNIKA =14

select * from dbo.PrikazivanjeZaposlenihPoEkspozituri('Ekspozitura Beograd')


select * from radnik
select dbo.LoginRadnik('DaniloC217','JxHd3Pb35qJKRqp')

exec dbo.DodajRadnika 
@nazivekpoziture ='Ekspozitura Mladenovac',
@nazivpozicije = 'Blagajnik',
@imeradnika = 'Milojko',
@prezimeradnika = 'Stepic',
@kontaktradnika = '381625987113',
@emailradnika ='milojkos@gmail.com',
@radnikkorime ='MilojkoS335',
@radnikkorpassword ='7e1iYi0caaIQDXv',
@jmbgradnika = '2312991436544',
@idkorisnika = 16

select * from korisnik
exec dbo.DodajKorisnika
    @ime = 'Dalibor',
    @prezime = 'Nevenkić',
    @ulica = 'Nikole Pašića 27',
    @ulicnibroj = '27',
    @email = 'dalibor@example.com',
    @kontakt = '381635385123',
    @jmbg = '1506989707714',
    @mestostanovanja = 'Niš',
    @korisnikkorIme = 'DaliborN01211',
    @korisnikkorPassword = 'daliborN321',
    @broj_racuna = '183456789012341111',
    @broj_kartice = '4876123456793123',
    @cvv2 = '932',
    @pin = '8432',
    @id_radnika = 11,
    @vrsta_racuna = 'Tekući Račun',
    @valuta = 'dinarski';

exec dbo.DodajKorisnika
	@ime = 'Marko',
    @prezime = 'Petrovic',
    @ulica = 'Zlatiborska 12',
    @ulicnibroj = '12',
    @email = 'markop@example.com',
    @kontakt = '381636085124',  
    @jmbg = '1506989707720',   
    @mestostanovanja = 'Novi Sad',
    @korisnikkorIme = 'MarkoP20241',
    @korisnikkorPassword = 'rT3kdfghJ8wQ2a',
    @broj_racuna = '183456789012345679',  
    @broj_kartice = '4876123456789124',    
    @cvv2 = '933',                     
    @pin = '8433',               
    @id_radnika = 11,
    @vrsta_racuna = 'Tekući Račun',
    @valuta = 'evri'; 

	select * from kartica

	exec dbo.DodajKorisnika
    @ime = 'Stefan',
    @prezime = 'Milinkovic',
    @ulica = 'Vojvode Stepe 25',
    @ulicnibroj = '25',
    @email = 'stefanm@example.com',
    @kontakt = '381634567890',  
    @jmbg = '1701989712345',     
    @mestostanovanja = 'Beograd',
    @korisnikkorIme = 'StefanM2024',
    @korisnikkorPassword = 'Yk2jG5tLm8nF4h', 
    @broj_racuna = '183456789012345680',  
    @broj_kartice = '4876123456789125',    
    @cvv2 = '934',                        
    @pin = '8434',                        
    @id_radnika = 11,
    @vrsta_racuna = 'Devizni Racun',  
    @valuta = 'evri';   


	select * from  dbo.PrikaziRacuneKorisnika('1701989712345')

	exec dbo.DodajNoviRacun
	@jmbg = '1506989707720',
	@broj_racuna = '183456789012345112',
	@broj_kartice = '4876123456789112',
	@cvv2 = '384',
	@pin = '121',
	@id_radnika = 11,
	@vrsta_racuna = 'Tekuci Racun',
	@valuta = 'dinarski'

	select * from KORISNIK_RACUN

	select * from korisnik
	exec dbo.DeaktivirajRacun
	@broj_racuna = 183456789012345680

exec dbo.UplataKorisnikaDevizni @broj_racuna = 183456789012345680 , @iznos = 30


select * from korisnik
select * from KORISNIK_RACUN
select * from VRSTAKARTICE
exec dbo.DodeliOvlascenje @jmbg_prvog_korisnika = 1506989707714, @broj_racuna =  183456789012345678, 
@jmbg_drugog_korisnika = 1506989707720


select *  from racun
	exec dbo.Placanje
	@broj_racuna = 183456789012345180,
	@racun_primaoca = 183456789012345680,
	@kolicina = 30

	update racun 
	set BROJRACUNA = 183456789012345180
	where IDRACUNA=18

	exec dbo.PodizanjeDeviznogRacuna @broj_racuna= 183456789012345679,
	@iznos = 5
	select * from korisnik

	exec dbo.PrikaziRacunKorisnika @id_korisnika = 14

	exec dbo.PrikaziTransakcijeNaRacunu @broj_racuna = 183456789012345678

	select * from RADNIK
	exec dbo.UpdejtujRadnika @idradnika = 10,@updtIme = 'Milan',
    @updtPrezime = 'Jovanovic',
    @updtKontakt = '381635987321',
    @updtEmail = 'milan1j@gmail.com'

 select * from racun
 select * from KORISNIK_RACUN
 select * from korisnik
 select * from KARTICA
	exec dbo.DodajKarticu @jmbg = '1506989707714', @brojRacuna = '183456789012345678',
	@brojkartice = 4876123456789123, @cvv2 = 831,@pin = 9931 
	delete from kartica where idkartice = 37
	delete  from VRSTAKARTICE where IDVRSTAKARTICE = 31
	exec dbo.MenjajKarticu @jmbg = 1506989707714, @brojRacuna= '183456789012345678',
	@starakartica = '4876123456789123', @novaKartica = '4876123456789124', @cvv2= 321, @pin = 320 
	select * from racun
	select * from KORISNIK_RACUN
	EXEC dbo.TransferNovca @korisnik_id =14, @racun_prvi = 183456789012345679,
	@racun_drugi = 183456789012345680, @iznos = 5






	create PROCEDURE Menjacnica (
    @korisnik_id INT, 
    @racun_devizni VARCHAR(20),
    @racun_dinarski VARCHAR(20),
    @iznos DECIMAL(10, 2)
)
AS
BEGIN
    DECLARE @stanje_deviznog_racuna DECIMAL(10, 2);
    DECLARE @stanje_dinarskog_racuna DECIMAL(10, 2);
    DECLARE @koeficijent DECIMAL(10, 4);
    DECLARE @aktivan_devizni_racun VARCHAR(10);
    DECLARE @aktivan_dinarski_racun VARCHAR(10);

    BEGIN TRANSACTION;

    SELECT @stanje_deviznog_racuna = TRENUTNOSTANJERACUNA,
           @aktivan_devizni_racun = STATUSRACUNA
    FROM Korisnik_Racun
    JOIN Racun ON Korisnik_Racun.idracuna = Racun.idracuna
    WHERE Korisnik_Racun.idkorisnik = @korisnik_id
    AND Racun.BROJRACUNA = @racun_devizni;

    IF @aktivan_devizni_racun != 'Aktivan'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Devizni racun nije aktivan.';
        RETURN;
    END

    SELECT @stanje_dinarskog_racuna = TRENUTNOSTANJERACUNA,
           @aktivan_dinarski_racun = STATUSRACUNA
    FROM Korisnik_Racun
    JOIN Racun ON Korisnik_Racun.idracuna = Racun.idracuna
    WHERE Korisnik_Racun.idkorisnik = @korisnik_id
    AND Racun.BROJRACUNA = @racun_dinarski;

    IF @aktivan_dinarski_racun != 'Aktivan'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Dinarski racun nije aktivan.';
        RETURN;
    END

    SELECT @koeficijent = koeficijent
    FROM Valute
    WHERE NazivValute = 'EUR';

    IF @stanje_deviznog_racuna < @iznos
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Nedovoljna sredstva na deviznom racunu.';
        RETURN;
    END

    UPDATE Racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA - @iznos 
    WHERE BROJRACUNA = @racun_devizni;

    DECLARE @konvertovani_iznos DECIMAL(10, 2);
    SET @konvertovani_iznos = @iznos * @koeficijent;

    UPDATE Racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA + @konvertovani_iznos 
    WHERE BROJRACUNA = @racun_dinarski;

    INSERT INTO transakcija (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE)
    VALUES ('transfer', @iznos);

    DECLARE @nova_transakcija_id INT = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (idracuna, idtransakcije, datumtransakcije)
    VALUES ((SELECT idracuna FROM Racun WHERE BROJRACUNA = @racun_devizni), @nova_transakcija_id, GETDATE());

    INSERT INTO transakcija_racun (idracuna, idtransakcije, datumtransakcije)
    VALUES ((SELECT idracuna FROM Racun WHERE BROJRACUNA = @racun_dinarski), @nova_transakcija_id, GETDATE());

    COMMIT TRANSACTION;
    PRINT 'Uspešno izvršena transakcija.';
END
select * from RACUN
select * from KORISNIK
exec dbo.Menjacnica @korisnik_id = 14, @racun_devizni = 183456789012345679, @racun_dinarski = 183456789012345112 , @iznos = 5 

select * from IzlistajNeaktivneRacune(15)

select * from PrikaziRacuneKorisnika(1506989707720)

select * from PrikazivanjeZaposlenihPoEkspozituri('Ekspozitura Mladenovac')


CREATE VIEW PrikaziUkupanBrojVrstaKartica AS
SELECT 
    BREND,
    COUNT(*) AS ukupno
FROM 
    VRSTAKARTICE
GROUP BY 
    brend;
	select * from RADNIK_RACUN
	alter view zaposlenracun as
	SELECT 
    RADNIK_RACUN.IDRACUNA, 
    radnik.imeradnika,
	radnik.PREZIMERADNIKA
FROM 
    RADNIK_RACUN
JOIN 
    radnik ON RADNIK_RACUN.idradnika = radnik.idradnika;

	create view prikazvaluta  as
	select NazivValute,Koeficijent
	from Valute

create FUNCTION PrikaziKarticeKorisnika
(
    @jmbg NVARCHAR(13)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        kartica.BROJKARTICE,
        kartica.STATUSKARTICE,
        kartica.TIPKARTICE,
        kartica.DATUMIZDAVANJAKARTICE
    FROM 
        korisnik
    INNER JOIN 
        korisnik_racun ON korisnik.IDKORISNIK = korisnik_racun.IDKORISNIK
    INNER JOIN 
        racun ON korisnik_racun.IDRACUNA = racun.IDRACUNA
    INNER JOIN 
        kartica ON racun.IDRACUNA = kartica.IDRACUNA
    WHERE 
        korisnik.jmbg = @jmbg
);
select *from KORISNIK


CREATE VIEW PrikaziStatistikuTransakcija AS
SELECT 
    korisnik.IDKORISNIK,
    COUNT(transakcija.IDTRANSAKCIJA) AS UkupanBrojTransakcija,
    SUM(transakcija.IZNOS) AS UkupnaSuma
FROM 
    korisnik
LEFT JOIN 
    racun ON korisnik.IDKORISNIK = racun.ID
LEFT JOIN 
    transakcija ON racun.IDRACUNA = transakcija.IDRACUNA
GROUP BY 
    korisnik.IDKORISNIK;



	CREATE VIEW PrikaziKorisnikeSaViseRacuna AS
SELECT 
    korisnik.IDKORISNIK,
    korisnik.IMEKORISNIKA,
    korisnik.PREZIMEKORISNIKA,
    COUNT(racun.IDRACUNA) AS BrojRacuna
FROM 
    korisnik
INNER JOIN 
    korisnik_racun ON korisnik.IDKORISNIK = korisnik_racun.IDKORISNIK
INNER JOIN 
    racun ON korisnik_racun.IDRACUNA = racun.IDRACUNA
GROUP BY 
    korisnik.IDKORISNIK, korisnik.IMEKORISNIKA, korisnik.PREZIMEKORISNIKA
HAVING 
    COUNT(racun.IDRACUNA) > 1;

	select * from PrikaziKorisnikeSaViseRacuna

	select * from korisnik

	CREATE PROCEDURE PromeniSifruRadnika
    @IDRadnika INT,
    @NovaLozinka NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @HashedPassword VARBINARY(MAX);

    SET @HashedPassword = HASHBYTES('SHA2_256', @NovaLozinka);

    UPDATE radnik
    SET RadnikKorPassword = @HashedPassword
    WHERE IDRadnika = @IDRadnika;
END;
select * from radnik


EXEC PromeniSifruRadnika @IDRadnika = 13, @NovaLozinka = 'mladenovac11';
EXEC PromeniSifruRadnika @IDRadnika = 14, @NovaLozinka = 'mladenovac111';
EXEC PromeniSifruRadnika @IDRadnika = 15, @NovaLozinka = 'mladenovac1111';
EXEC PromeniSifruRadnika @IDRadnika = 16, @NovaLozinka = 'mladenovac11111';
EXEC PromeniSifruRadnika @IDRadnika = 17, @NovaLozinka = 'mladenovac111111';
EXEC PromeniSifruRadnika @IDRadnika = 18, @NovaLozinka = 'mladenovac1111111';
EXEC PromeniSifruRadnika @IDRadnika = 21, @NovaLozinka = 'mladenovac111111111';
EXEC PromeniSifruRadnika @IDRadnika = 22, @NovaLozinka = 'mladenovac1111111111';
EXEC PromeniSifruRadnika @IDRadnika = 23, @NovaLozinka = 'mladenovac11111111111';
EXEC PromeniSifruRadnika @IDRadnika = 24, @NovaLozinka = 'mladenovac111111111111';
EXEC PromeniSifruRadnika @IDRadnika = 25, @NovaLozinka = 'mladenovac1111111111111';

exec LoginRadnika @radnikkorime = 'FilipS912', @radnikkorpassword = 'mladenovac11'