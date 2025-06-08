select * from VRSTAKARTICE
delete  from VRSTARACUNA where IDVRSTERACUNA = 2
insert into VRSTAKARTICE(BREND)
values('Maestro')


ALTER TABLE EKSPOZITURA
Alter COLUMN adresaekspoziture VARCHAR(50);

/*Računi oročenog depozita*/




/*1.Sve za radnika*/
select * from EKSPOZITURA
select * from radnik
	
insert into radnik(IDEKSPOZITURE,IDPOZICIJE,IMERADNIKA,PREZIMERADNIKA,KONTAKTRADNIKA,EMAILRADNIKA,RADNIKKORIME,RADNIKKORPASSWORD,jmbgradnika)
values(9,5,'Dzoni','Oktopod','0614360271','darkom@gmail.com','dzoni123','FjK+12.','1234567890121')

create procedure LoginKorisnika
(
    @korisnikkorime NVARCHAR(50),
    @korisnikkorpassword NVARCHAR(50)
)
AS
BEGIN
    DECLARE @Rezultat varbinary(MAX);
	set @Rezultat = HASHBYTES('SHA2_256', @korisnikkorpassword)

    IF EXISTS (
        SELECT 1
        FROM KORISNIK
        WHERE KORISNIKKORIME = @korisnikkorime
          AND KORISNIKKORPASSWORD = @Rezultat
    )
    BEGIN
		print 'Login je uspešan';
    END
    ELSE
    BEGIN
        
        print 'Login je neuspešan';
    END
END;

sifra = input(unesi sifru)

exec dbo.LoginRadnika
@RADNIKKORIME = 'MIlor1adD03122',
@RADNIKKORPASSWORD = '123'

SELECT dbo.LoginRadnik('DarkoM245', 'sifra') AS Rezultat;
select * from RADNIK`
ALTER PROCEDURE DodajRadnika
    @NAZIVEKPOZITURE NVARCHAR(50), 
    @NAZIVPOZICIJE NVARCHAR(50),  
    @IMERADNIKA NVARCHAR(50),
    @PREZIMERADNIKA NVARCHAR(50),
    @KONTAKTRADNIKA NVARCHAR(50),
    @EMAILRADNIKA NVARCHAR(100),
    @RADNIKKORIME NVARCHAR(50),
    @RADNIKKORPASSWORD NVARCHAR(50),
	@JMBGRADNIKA CHAR (13),
    @IDRADNIKA INT
AS
BEGIN
    DECLARE @IDEKSPOZITURE INT;
    DECLARE @IDPOZICIJE INT;
    DECLARE @KORISNIKPOZICIJA NVARCHAR(50);
	DECLARE @Rezultat varbinary(MAX);
	set @Rezultat = HASHBYTES('SHA2_256',@RADNIKKORPASSWORD)
	

    SELECT @IDEKSPOZITURE = ekspozitura.IDEKSPOZITURE
    FROM ekspozitura
    WHERE ekspozitura.NAZIVEKSPOZITURE = @NAZIVEKPOZITURE;

    IF @IDEKSPOZITURE IS NULL
    BEGIN
        RAISERROR('Ekspozitura sa datim nazivom ne postoji.', 16, 1);
        RETURN;
    END

    SELECT @IDPOZICIJE = radnikpozicija.IDPOZICIJE
    FROM RADNIKPOZICIJA
    WHERE radnikpozicija.NAZIVPOZICIJE = @NAZIVPOZICIJE;

    IF @IDPOZICIJE IS NULL
    BEGIN
        RAISERROR('Pozicija sa datim nazivom ne postoji.', 16, 1);
        RETURN;
    END

    SELECT @KORISNIKPOZICIJA = radnikpozicija.NAZIVPOZICIJE
    FROM radnik
    JOIN radnikpozicija ON radnik.IDPOZICIJE = radnikpozicija.IDPOZICIJE
    WHERE radnik.IDRADNIKA = @IDRADNIKA;

    IF @KORISNIKPOZICIJA IN ('Blagajnik', 'Kreditni savetnik')
    BEGIN
        RAISERROR('Korisnik sa pozicijom %s ne može dodavati radnike.', 16, 1, @KORISNIKPOZICIJA);
        RETURN;
    END

    IF @KORISNIKPOZICIJA = 'Direktor filijale'
    BEGIN
        IF NOT EXISTS (SELECT 1 
                       FROM radnikpozicija
                       WHERE radnikpozicija.IDPOZICIJE = @IDPOZICIJE 
                         AND radnikpozicija.NAZIVPOZICIJE IN ('Blagajnik', 'Kreditni savetnik'))
        BEGIN
            RAISERROR('Korisnik sa pozicijom Direktor filijale može dodavati samo Blagajnika i Kreditnog savetnika.', 16, 1);
            RETURN;
        END
    END

    IF EXISTS (SELECT 1 
               FROM radnikpozicija
               WHERE radnikpozicija.IDPOZICIJE = @IDPOZICIJE 
                 AND radnikpozicija.NAZIVPOZICIJE = 'Regionalni direktor')
    BEGIN
        RAISERROR('Ne može se dodati radnik sa pozicijom Regionalni direktor.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM radnik WHERE radnik.RADNIKKORIME = @RADNIKKORIME)
    BEGIN
        RAISERROR('Radnik sa istim korisničkim imenom već postoji.', 16, 1);
        RETURN;
    END
	    IF EXISTS (SELECT 1 FROM radnik WHERE radnik.jmbgRadnika = @JMBGRADNIKA)
    BEGIN
        RAISERROR('Već je unet radnik.', 16, 1);
        RETURN;
    END

INSERT INTO radnik (
    IDEKSPOZITURE,
    IDPOZICIJE,
    IMERADNIKA,
    PREZIMERADNIKA,
    KONTAKTRADNIKA,
    EMAILRADNIKA,
    RADNIKKORIME,
    RADNIKKORPASSWORD,
    JMBGRADNIKA
) VALUES (
    @IDEKSPOZITURE,
    @IDPOZICIJE,
    @IMERADNIKA,
    @PREZIMERADNIKA,
    @KONTAKTRADNIKA,
    @EMAILRADNIKA,
    @RADNIKKORIME,
    @Rezultat,
    @JMBGRADNIKA
);


    PRINT 'Radnik je uspešno dodat.';
END;
exec dbo.DodajRadnika
    @NAZIVEKPOZITURE = 'Ekspozitura Mladenovac',
    @NAZIVPOZICIJE = 'Blagajnik',
    @IMERADNIKA = 'Milorad',
    @PREZIMERADNIKA = 'Dejanović',
    @KONTAKTRADNIKA = '0610061530',
    @EMAILRADNIKA = 'milorad@gmail.com',
    @RADNIKKORIME = 'MIlor1adD03122',
    @RADNIKKORPASSWORD = '123',
    @IDRADNIKA = 20,
	@jmbgRadnika = '1234567890123'
	delete from radnik where IDRADNIKA= 28
	select * from korisnik

	ALTER TABLE korisnik
DROP COLUMN korisnikkorpassword;

	ALTER TABLE korisnik



	create view PregledZaposlenih as
SELECT 
    COUNT(radnik.IDPOZICIJE) AS BrojRadnika,
    radnikpozicija.NAZIVPOZICIJE
FROM radnik
JOIN radnikpozicija ON radnik.IDPOZICIJE = radnikpozicija.IDPOZICIJE
GROUP BY radnikpozicija.NAZIVPOZICIJE;
	

	select * from RADNIKPOZICIJA


CREATE FUNCTION PrikazivanjeZaposlenihPoEkspozituri
(
    @nazivEkspoziture NVARCHAR(30)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        radnik.IMERADNIKA AS ImeRadnika,
        radnik.PREZIMERADNIKA AS PrezimeRadnika,
        RADNIKPOZICIJA.NAZIVPOZICIJE AS NazivPozicije
    FROM radnik
    JOIN RADNIKPOZICIJA ON radnik.IDPOZICIJE = RADNIKPOZICIJA.IDPOZICIJE
    JOIN EKSPOZITURA ON radnik.IDEKSPOZITURE = EKSPOZITURA.IDEKSPOZITURE
    WHERE EKSPOZITURA.NAZIVEKSPOZITURE = @nazivEkspoziture
);

alter PROCEDURE UpdejtujRadnika
    @idradnika INT,
    @updtIme NVARCHAR(30),
    @updtPrezime NVARCHAR(30),
    @updtKontakt NVARCHAR(30),
    @updtEmail NVARCHAR(30)
AS
BEGIN
    IF @idradnika IS NULL OR @updtIme IS NULL OR @updtPrezime IS NULL OR @updtKontakt IS NULL OR @updtEmail IS NULL
    BEGIN
        RAISERROR('Svi parametri moraju biti uneseni.', 16, 1);
        RETURN;
    END

    UPDATE Radnik
    SET
        IMERADNIKA = @updtIme,
        PREZIMERADNIKA = @updtPrezime,
        KONTAKTRADNIKA = @updtKontakt,
        EMAILRADNIKA = @updtEmail
    WHERE
        IDRADNIKA = @idradnika;
END;


select * from VRSTAKARTICE
ALTER PROCEDURE DodajKorisnika
    @ime NVARCHAR(100),
    @prezime NVARCHAR(100),
    @ulica NVARCHAR(255),
    @ulicnibroj NVARCHAR(10),
    @email NVARCHAR(100),
    @kontakt NVARCHAR(15),
    @jmbg NVARCHAR(13),
    @mestostanovanja NVARCHAR(30),
    @korisnikkorIme NVARCHAR(30),
    @korisnikkorPassword NVARCHAR(20),
    @broj_racuna NVARCHAR(20),
    @broj_kartice NVARCHAR(20),
    @cvv2 NVARCHAR(4),
    @pin NVARCHAR(4),
    @id_radnika INT,
    @vrsta_racuna NVARCHAR(100),
    @valuta NVARCHAR(10)
AS
BEGIN
    BEGIN TRANSACTION; 

    BEGIN 
        DECLARE @novi_id_racuna INT;
        DECLARE @novi_id_korisnika INT;
        DECLARE @id_vrste_racuna INT;
        DECLARE @kartica_id INT;
        DECLARE @tip_racuna NVARCHAR(20);
        DECLARE @tip_kartice NVARCHAR(20);
        DECLARE @brendKartice NVARCHAR(20);
		 DECLARE @Rezultat varbinary(MAX);
		set @Rezultat = HASHBYTES('SHA2_256',@korisnikkorPassword)
		

        IF EXISTS (SELECT 1 FROM korisnik WHERE korisnikkorIme = @korisnikkorIme)
        BEGIN
            PRINT 'Greška: Korisničko ime već postoji. Pokušajte ponovo.';
            ROLLBACK TRANSACTION; 
            RETURN;
        END

        SELECT @id_vrste_racuna = IDVRSTERACUNA FROM VRSTARACUNA WHERE NAZIVVRSTERACUNA = @vrsta_racuna;

        IF @id_vrste_racuna IS NULL
        BEGIN
            PRINT 'Greška: Vrsta računa ne postoji.';
            ROLLBACK TRANSACTION; 
            RETURN;
        END

        SET @tip_racuna = 
            CASE 
                WHEN @vrsta_racuna = 'Tekući Račun' AND @valuta = 'dinarski' THEN 'dinarski'
                WHEN @vrsta_racuna = 'Tekući Račun' AND @valuta = 'evri' THEN 'strana valuta'
                WHEN @vrsta_racuna = 'Tekući Račun' AND @valuta = 'strana valuta' THEN 'strana valuta'
                WHEN @vrsta_racuna = 'Devizni račun' AND @valuta = 'evri' THEN 'strana valuta'
                WHEN @vrsta_racuna = 'Štedni Račun' AND @valuta = 'dinarski' THEN 'dinarski'
                ELSE 'nepoznato'
            END;

        IF @tip_racuna = 'nepoznato'
        BEGIN
            PRINT 'Greška: Tip računa nije prepoznat.';
            ROLLBACK TRANSACTION;  -- Poništi promene
            RETURN;
        END

        IF LEFT(@broj_racuna, 3) = '183' AND LEN(@broj_racuna) = 18
        BEGIN
            IF LEFT(@broj_kartice, 4) = '4876' AND LEN(@broj_kartice) = 16
            BEGIN
                INSERT INTO korisnik (IMEKORISNIKA, PREZIMEKORISNIKA, ULICAKORISNIKA, ULICNIBROJKORISNIKA, EMAILKORISNIKA, KONTAKTKORISNIKA, jmbg, mestostanovanja, korisnikkorIme, korisnikkorPassword)
                VALUES (@ime, @prezime, @ulica, @ulicnibroj, @email, @kontakt, @jmbg, @mestostanovanja, @korisnikkorIme, @Rezultat);
                
                SET @novi_id_korisnika = SCOPE_IDENTITY();

                SELECT @id_vrste_racuna = IDVRSTERACUNA FROM VRSTARACUNA WHERE NAZIVVRSTERACUNA = @vrsta_racuna;

                INSERT INTO racun (BROJRACUNA, TIPRACUNA, TRENUTNOSTANJERACUNA, DATUMKREIRANJARACUNA, STATUSRACUNA, IDVRSTERACUNA)
                VALUES (@broj_racuna, @tip_racuna, 0, GETDATE(), 'Aktivan', @id_vrste_racuna);

                SET @novi_id_racuna = SCOPE_IDENTITY();

                SET @tip_kartice = 
                    CASE 
                        WHEN @tip_racuna = 'dinarski' THEN 'dinarska'
                        WHEN @tip_racuna = 'strana valuta' THEN 'strana valuta'
                        ELSE 'nepoznato'
                    END;

                IF @tip_kartice = 'nepoznato'
                BEGIN
                    PRINT 'Greška: Tip kartice nije prepoznat.';
                    ROLLBACK TRANSACTION; 
                    RETURN; 
                END

                SET @brendKartice = 
                    CASE 
                        WHEN @vrsta_racuna = 'Tekući Račun' AND @tip_racuna = 'dinarski' THEN 'Dina'
                        WHEN @vrsta_racuna = 'Tekući Račun' AND @tip_racuna = 'strana valuta' THEN 'Visa'
                        WHEN @vrsta_racuna = 'Devizni Račun' AND @tip_racuna = 'strana valuta' THEN 'MasterCard'
                        ELSE 'nepoznato' 
                    END;

                IF @brendKartice = 'nepoznato'
                BEGIN
                    PRINT 'Greška: Brend kartice je nepoznat.';
                    ROLLBACK TRANSACTION; 
                    RETURN;  
                END

                INSERT INTO kartica (IDRACUNA, TIPKARTICE, BROJKARTICE, DATUMIZDAVANJAKARTICE, ROKVAZENJA, CVV2, PIN,statusKARTICE)
                VALUES (@novi_id_racuna, @tip_kartice, @broj_kartice, GETDATE(), dbo.Rok(), @cvv2, @pin,'Aktivan');
                
                SET @kartica_id = SCOPE_IDENTITY();
                
                INSERT INTO VRSTAKARTICE(IDKARTICE, brend)
                VALUES (@kartica_id, @brendKartice);

                INSERT INTO korisnik_racun (IDKORISNIK, IDRACUNA)
                VALUES (@novi_id_korisnika, @novi_id_racuna);

                INSERT INTO RADNIK_RACUN(IDRADNIKA, IDRACUNA)
                VALUES (@id_radnika, @novi_id_racuna);

                PRINT 'Uspešno dodat korisnik.';
            END
            ELSE
            BEGIN
                PRINT 'Greška: Broj kartice nije validan.';
                ROLLBACK TRANSACTION; 
            END
        END
        ELSE
        BEGIN
            PRINT 'Greška: Broj računa nije validan.';
            ROLLBACK TRANSACTION; 
        END

        COMMIT TRANSACTION;  
    END 
    BEGIN 
        ROLLBACK TRANSACTION; 
        PRINT 'Greška: ' + ERROR_MESSAGE();  
    END 
END;

EXEC DodajKorisnika
    @ime = 'Marko', 
    @prezime = 'Marković', 
    @ulica = 'Kralja Petra 10', 
    @ulicnibroj = '10', 
    @email = 'marko@example.com', 
    @kontakt = '0641234567', 
    @jmbg = '1234567890194', 
	@mestostanovanja = 'Mladenovac',
	@korisnikkorIme='Cofaf1j3234',
	@korisnikkorPassword='123',
    @broj_racuna = '183000000000000000', 
    @broj_kartice = '4876123456789012',
    @cvv2 = '123', 
    @pin = '4567', 
    @id_radnika = 1,
    @vrsta_racuna = 'Tekući Račun',
	@valuta = 'dinarski'
	select * from k



alter FUNCTION Rok()
RETURNS NVARCHAR(7)
AS
BEGIN
    DECLARE @novidatum DATE;
    DECLARE @konverzija NVARCHAR(7);

    SET @novidatum = DATEADD(YEAR, 5, GETDATE());

    SET @konverzija = FORMAT(@novidatum, 'MM-yyyy');

    RETURN @konverzija;
END;

select dbo.Rok() as rok



select * from KORISNIK_RACUN

alter TRIGGER RegionalniBlok
ON Radnik
INSTEAD OF DELETE
AS
BEGIN
   
    IF EXISTS (
        SELECT 1
        FROM DELETED
        JOIN RADNIKPOZICIJA ON DELETED.IDPOZICIJE = RADNIKPOZICIJA.IDPOZICIJE
        WHERE RADNIKPOZICIJA.NAZIVPOZICIJE = 'Regionalni direktor'
    )
    BEGIN
        RAISERROR('Ne možete obrisati radnika sa pozicijom regionalni direktor.', 16, 1);
        RETURN;
    END

    DELETE FROM Radnik
    WHERE IDRADNIKA IN (SELECT IDRADNIKA FROM DELETED);
END;

Create PROCEDURE DodajNoviRacun
    @jmbg NVARCHAR(13),
    @broj_racuna NVARCHAR(20),
    @broj_kartice NVARCHAR(20),
    @cvv2 NVARCHAR(4),
    @pin NVARCHAR(4),
    @id_radnika INT,
    @vrsta_racuna NVARCHAR(100),
    @valuta NVARCHAR(10)
AS
BEGIN
    BEGIN TRANSACTION;  

    DECLARE @novi_id_racuna INT;
    DECLARE @id_vrste_racuna INT;
    DECLARE @tip_racuna NVARCHAR(20);
    DECLARE @tip_kartice NVARCHAR(20);
    DECLARE @brendKartice NVARCHAR(20);
    DECLARE @id_korisnika INT;
	select * from korisnik

    SELECT @id_korisnika = IDKORISNIK FROM korisnik WHERE jmbg = @jmbg;

    IF @id_korisnika IS NULL
    BEGIN
        PRINT 'Greška: Korisnik sa datim JMBG-om ne postoji.';
        ROLLBACK TRANSACTION; 
        RETURN;
    END

    SELECT @id_vrste_racuna = IDVRSTERACUNA FROM VRSTARACUNA WHERE NAZIVVRSTERACUNA = @vrsta_racuna;

    IF @id_vrste_racuna IS NULL
    BEGIN
        PRINT 'Greška: Vrsta računa ne postoji.';
        ROLLBACK TRANSACTION;  
        RETURN;
    END

    SET @tip_racuna = 
        CASE 
            WHEN @vrsta_racuna = 'Tekući Račun' AND @valuta = 'dinarski' THEN 'dinarski'
            WHEN @vrsta_racuna = 'Tekući Račun' AND @valuta = 'evri' THEN 'strana valuta'
            WHEN @vrsta_racuna = 'Tekući Račun' AND @valuta = 'strana valuta' THEN 'strana valuta'
            WHEN @vrsta_racuna = 'Devizni račun' AND @valuta = 'evri' THEN 'strana valuta'
            WHEN @vrsta_racuna = 'Štedni Račun' AND @valuta = 'dinarski' THEN 'dinarski'
            ELSE 'nepoznato'
        END;

    IF @tip_racuna = 'nepoznato'
    BEGIN
        PRINT 'Greška: Tip računa nije prepoznat.';
        ROLLBACK TRANSACTION;  =
        RETURN;
    END

    IF LEFT(@broj_racuna, 3) = '183' AND LEN(@broj_racuna) = 18
    BEGIN
        IF LEFT(@broj_kartice, 4) = '4876' AND LEN(@broj_kartice) = 16
        BEGIN
            INSERT INTO racun (BROJRACUNA, TIPRACUNA, TRENUTNOSTANJERACUNA, DATUMKREIRANJARACUNA, STATUSRACUNA, IDVRSTERACUNA)
            VALUES (@broj_racuna, @tip_racuna, 0, GETDATE(), 'Aktivan', @id_vrste_racuna);

            SET @novi_id_racuna = SCOPE_IDENTITY();

            SET @tip_kartice = 
                CASE 
                    WHEN @tip_racuna = 'dinarski' THEN 'dinarska'
                    WHEN @tip_racuna = 'strana valuta' THEN 'strana valuta'
                    ELSE 'nepoznato'
                END;

            IF @tip_kartice = 'nepoznato'
            BEGIN
                PRINT 'Greška: Tip kartice nije prepoznat.';
                ROLLBACK TRANSACTION;  -- Poništi promene
                RETURN; 
            END

            SET @brendKartice = 
                CASE 
                    WHEN @vrsta_racuna = 'Tekući Račun' AND @tip_racuna = 'dinarski' THEN 'Dina'
                    WHEN @vrsta_racuna = 'Tekući Račun' AND @tip_racuna = 'strana valuta' THEN 'Visa'
                    WHEN @vrsta_racuna = 'Devizni Račun' AND @tip_racuna = 'strana valuta' THEN 'MasterCard'
                    ELSE 'nepoznato' 
                END;

            IF @brendKartice = 'nepoznato'
            BEGIN
                PRINT 'Greška: Brend kartice je nepoznat.';
                ROLLBACK TRANSACTION;  -- Poništi promene
                RETURN;  
            END

            INSERT INTO kartica (IDRACUNA, TIPKARTICE, BROJKARTICE, DATUMIZDAVANJAKARTICE, ROKVAZENJA, CVV2, PIN)
            VALUES (@novi_id_racuna, @tip_kartice, @broj_kartice, GETDATE(), dbo.Rok(), @cvv2, @pin);
            
            DECLARE @kartica_id INT = SCOPE_IDENTITY();
            
            INSERT INTO VRSTAKARTICE(IDKARTICE, brend)
            VALUES (@kartica_id, @brendKartice);

            INSERT INTO korisnik_racun (IDKORISNIK, IDRACUNA)
            VALUES (@id_korisnika, @novi_id_racuna);

            INSERT INTO RADNIK_RACUN(IDRADNIKA, IDRACUNA)
            VALUES (@id_radnika, @novi_id_racuna);

            COMMIT TRANSACTION;  
            PRINT 'Uspešno dodat novi račun korisniku.';
        END
        ELSE
        BEGIN
            PRINT 'Greška: Broj kartice nije validan.';
            ROLLBACK TRANSACTION;
        END
    END
    ELSE
    BEGIN
        PRINT 'Greška: Broj računa nije validan.';
        ROLLBACK TRANSACTION; 
    END
END;
EXEC DodajNoviRacun 
    @jmbg = '1234564890144',              
    @broj_racuna = '183456789012345678',  
    @broj_kartice = '4876123456789012',   
    @cvv2 = '123',                         
    @pin = '1234',                         
    @id_radnika = 1,                       
    @vrsta_racuna = 'Tekući Račun',       
    @valuta = 'evri';

	select * from TRANSAKCIJA

	alter table transakcija_racun
	add  datumTransakcije datetime

Alter PROCEDURE UplataKorisnikaDinarski
	@broj_racuna NVARCHAR(20),
    @iznos DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @id_racuna INT;
    DECLARE @trenutno_stanje DECIMAL(10, 2);
    DECLARE @novi_stanje DECIMAL(10, 2);
    DECLARE @transakcija_id INT;
    DECLARE @status NVARCHAR(20);
    DECLARE @tip_racuna NVARCHAR(20);

    SELECT @id_racuna = IDRACUNA,
           @trenutno_stanje = TRENUTNOSTANJERACUNA,
           @status = STATUSRACUNA,
           @tip_racuna = TIPRACUNA
    FROM racun
    WHERE BROJRACUNA = @broj_racuna;

    IF @id_racuna IS NULL
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @status != 'Aktivan'
    BEGIN
        PRINT 'Greška: Račun nije aktivan.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @tip_racuna != 'dinarski'
    BEGIN
        PRINT 'Greška: Račun nije dinarski.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    
    SET @novi_stanje = @trenutno_stanje + @iznos;

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = @novi_stanje 
    WHERE IDRACUNA = @id_racuna;

    INSERT INTO transakcija (IZNOSTRANSAKCIJE, TIPTRANSAKCIJE)
    VALUES (@iznos, 'Uplata');

    SET @transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (IDRACUNA, IDTRANSAKCIJE, datumTransakcije)
    VALUES (@id_racuna, @transakcija_id, GETDATE());

    COMMIT TRANSACTION;

    PRINT 'Uspešno izvršena uplata.';
END;

alter FUNCTION PrikaziRacuneKorisnika
(
    @jmbg NVARCHAR(13)
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        racun.IDRACUNA,
        racun.BROJRACUNA,
        racun.TRENUTNOSTANJERACUNA,
        racun.STATUSRACUNA,
        racun.TIPRACUNA
    FROM 
        korisnik
    INNER JOIN 
        korisnik_racun ON korisnik.IDKORISNIK = korisnik_racun.IDKORISNIK
    INNER JOIN 
        racun ON korisnik_racun.IDRACUNA = racun.IDRACUNA
    WHERE 
        korisnik.jmbg = @jmbg
);

SELECT * FROM PrikaziRacuneKorisnika('1234567890194');

EXEC UplataKorisnikaDinarski 
    @jmbg = '1234567890194', 
    @iznos = 100;

alter Procedure UplataKorisnikaDevizni
	@broj_racuna NVARCHAR(20),
    @iznos DECIMAL(10, 2)

AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @id_racuna INT;
    DECLARE @trenutno_stanje DECIMAL(10, 2);
    DECLARE @novi_stanje DECIMAL(10, 2);
    DECLARE @transakcija_id INT;
    DECLARE @status NVARCHAR(20);
    DECLARE @tip_racuna NVARCHAR(20);

    SELECT @id_racuna = IDRACUNA,
           @trenutno_stanje = TRENUTNOSTANJERACUNA,
           @status = STATUSRACUNA,
           @tip_racuna = TIPRACUNA
    FROM racun
    WHERE BROJRACUNA = @broj_racuna;

    IF @id_racuna IS NULL
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @status != 'Aktivan'
    BEGIN
        PRINT 'Greška: Račun nije aktivan.';
        ROLLBACK TRANSACTION;
        RETURN;
    END
	select * from racun
    IF @tip_racuna != 'strana valuta'
    BEGIN
        PRINT 'Greška: Račun nije dinarski.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    
    SET @novi_stanje = @trenutno_stanje + @iznos;

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = @novi_stanje 
    WHERE IDRACUNA = @id_racuna;

    INSERT INTO transakcija (IZNOSTRANSAKCIJE, TIPTRANSAKCIJE)
    VALUES (@iznos, 'Uplata');

    SET @transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (IDRACUNA, IDTRANSAKCIJE, datumTransakcije)
    VALUES (@id_racuna, @transakcija_id, GETDATE());

    COMMIT TRANSACTION;

    PRINT 'Uspešno izvršena uplata.';
END;

alter PROCEDURE DeaktivirajRacun
    @broj_racuna NVARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @id_racuna INT;
    DECLARE @trenutno_stanje DECIMAL(10, 2);


    SELECT @id_racuna = IDRACUNA, @trenutno_stanje = TRENUTNOSTANJERACUNA
    FROM racun
    WHERE BROJRACUNA = @broj_racuna;

    IF @id_racuna IS NULL
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

	    IF @trenutno_stanje <> 0
    BEGIN
        PRINT 'Greška: Račun ne može biti deaktiviran jer trenutno stanje nije 0.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    UPDATE racun 
    SET STATUSRACUNA = 'Neaktivan'
    WHERE IDRACUNA = @id_racuna;

	UPDATE Kartica
    SET StatusKartice = 'Deaktivirana'
    WHERE IDRacuna = @id_racuna;

    COMMIT TRANSACTION;

    PRINT 'Račun je uspešno deaktiviran.';
END;
----
create TRIGGER trg_BlokirajBrisanjeKorisnika
ON korisnik
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Greška: Brisanje korisnika nije dozvoljeno.';
    ROLLBACK; 
END;
----
CREATE TRIGGER BlokirajBrisanjeRacuna
ON Racun
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Greška: Brisanje racuna nije dozvoljeno.';
    ROLLBACK; 
END;
--
CREATE TRIGGER BlokirajBrisanjeKartice
ON kartica
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Greška: Brisanje kartice nije dozvoljeno.';
    ROLLBACK; 
END;
--
CREATE PROCEDURE PodizanjeDinarskogRacuna
	@broj_racuna NVARCHAR(20),
    @iznos DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @id_racuna INT;
    DECLARE @trenutno_stanje DECIMAL(10, 2);
    DECLARE @novi_stanje DECIMAL(10, 2);
    DECLARE @transakcija_id INT;
    DECLARE @status NVARCHAR(20);
    DECLARE @tip_racuna NVARCHAR(20);

    SELECT @id_racuna = IDRACUNA,
           @trenutno_stanje = TRENUTNOSTANJERACUNA,
           @status = STATUSRACUNA,
           @tip_racuna = TIPRACUNA
    FROM racun
    WHERE BROJRACUNA = @broj_racuna;

    IF @id_racuna IS NULL
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @status != 'Aktivan'
    BEGIN
        PRINT 'Greška: Račun nije aktivan.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @tip_racuna != 'dinarski'
    BEGIN
        PRINT 'Greška: Račun nije dinarski.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    
    SET @novi_stanje = @trenutno_stanje - @iznos;

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = @novi_stanje 
    WHERE IDRACUNA = @id_racuna;

    INSERT INTO transakcija (IZNOSTRANSAKCIJE, TIPTRANSAKCIJE)
    VALUES (@iznos, 'Isplata');

    SET @transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (IDRACUNA, IDTRANSAKCIJE, datumTransakcije)
    VALUES (@id_racuna, @transakcija_id, GETDATE());

    COMMIT TRANSACTION;

    PRINT 'Uspešno izvršena isplata';
END;
--
CREATE Procedure PodizanjeDeviznogRacuna
	@broj_racuna NVARCHAR(20),
    @iznos DECIMAL(10, 2)

AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @id_racuna INT;
    DECLARE @trenutno_stanje DECIMAL(10, 2);
    DECLARE @novi_stanje DECIMAL(10, 2);
    DECLARE @transakcija_id INT;
    DECLARE @status NVARCHAR(20);
    DECLARE @tip_racuna NVARCHAR(20);

    SELECT @id_racuna = IDRACUNA,
           @trenutno_stanje = TRENUTNOSTANJERACUNA,
           @status = STATUSRACUNA,
           @tip_racuna = TIPRACUNA
    FROM racun
    WHERE BROJRACUNA = @broj_racuna;

    IF @id_racuna IS NULL
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF @status != 'Aktivan'
    BEGIN
        PRINT 'Greška: Račun nije aktivan.';
        ROLLBACK TRANSACTION;
        RETURN;
    END
	select * from racun
    IF @tip_racuna != 'strana valuta'
    BEGIN
        PRINT 'Greška: Račun nije dinarski.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    
    SET @novi_stanje = @trenutno_stanje - @iznos;

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = @novi_stanje 
    WHERE IDRACUNA = @id_racuna;

    INSERT INTO transakcija (IZNOSTRANSAKCIJE, TIPTRANSAKCIJE)
    VALUES (@iznos, 'Isplata');

    SET @transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (IDRACUNA, IDTRANSAKCIJE, datumTransakcije)
    VALUES (@id_racuna, @transakcija_id, GETDATE());

    COMMIT TRANSACTION;

    PRINT 'Uspešno izvršena isplata.';
END;
alter FUNCTION LoginKorisnik
(
    @KorisnikKorIme NVARCHAR(25),
    @KorisnikKorPassword NVARCHAR(20)
)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @Rezultat NVARCHAR(50);


    IF EXISTS (
        SELECT 1
        FROM korisnik
        WHERE korisnikkorime = @KorisnikKorIme
          AND korisnikkorpassword = @KorisnikKorPassword
    )
    BEGIN

        SELECT @Rezultat = CAST(IDKORISNIK AS NVARCHAR(50))
        FROM korisnik
        WHERE korisnikkorime = @KorisnikKorIme
          AND korisnikkorPassword = @KorisnikKorPassword;
    END
    ELSE
    BEGIN
        
        SET @Rezultat = 'NE';
    END

    RETURN @Rezultat;
END;
SELECT dbo.LoginKorisnik('Cofa123', '123') AS Rezultat;

CREATE PROCEDURE PrikaziRacunKorisnika
    @id_korisnika INT
AS
BEGIN

    SELECT racun.BROJRACUNA, racun.TRENUTNOSTANJERACUNA
    FROM korisnik_racun
    INNER JOIN racun ON korisnik_racun.IDRACUNA = racun.IDRACUNA
    WHERE korisnik_racun.IDKORISNIK = @id_korisnika;
END;
EXEC PrikaziRacunKorisnika @id_korisnika = 12;
--
CREATE PROCEDURE PrikaziTransakcijeNaRacunu
    @broj_racuna NVARCHAR(20)
AS
BEGIN

    IF NOT EXISTS (SELECT 1 FROM racun WHERE BROJRACUNA = @broj_racuna)
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        RETURN;
    END

    SELECT transakcija.IDTRANSAKCIJE, transakcija.IZNOSTRANSAKCIJE, transakcija.TIPTRANSAKCIJE, transakcija_racun.datumTransakcije
    FROM transakcija
    INNER JOIN transakcija_racun ON transakcija.IDTRANSAKCIJE = transakcija_racun.IDTRANSAKCIJE
    INNER JOIN racun ON transakcija_racun.IDRACUNA = racun.IDRACUNA
    WHERE racun.BROJRACUNA = @broj_racuna;
END;

EXEC PrikaziTransakcijeNaRacunu @broj_racuna = '183000000000000000';

CREATE TRIGGER DupliJMBG
ON racun
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM korisnik
        WHERE JMBG IN (SELECT JMBG FROM inserted)
    )
    BEGIN
        RAISERROR ('Greška: Korisnik vec postoji u sistemu', 16, 1);
        ROLLBACK;
    END
END;
CREATE PROCEDURE DodeliOvlascenje
    @jmbg_prvog_korisnika NVARCHAR(13),
    @broj_racuna NVARCHAR(20),
    @jmbg_drugog_korisnika NVARCHAR(13)
AS
BEGIN
    BEGIN TRANSACTION;

    DECLARE @id_prvog_korisnika INT;
    DECLARE @id_drugog_korisnika INT;
    DECLARE @id_racuna INT;

    SELECT @id_prvog_korisnika = IDKORISNIK
    FROM korisnik
    WHERE jmbg = @jmbg_prvog_korisnika;

    IF @id_prvog_korisnika IS NULL
    BEGIN
        PRINT 'Greška: Prvi korisnik sa datim JMBG-om ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    SELECT @id_drugog_korisnika = IDKORISNIK
    FROM korisnik
    WHERE jmbg = @jmbg_drugog_korisnika;

    IF @id_drugog_korisnika IS NULL
    BEGIN
        PRINT 'Greška: Drugi korisnik sa datim JMBG-om ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    SELECT @id_racuna = IDRACUNA
    FROM racun
    WHERE BROJRACUNA = @broj_racuna;

    IF @id_racuna IS NULL
    BEGIN
        PRINT 'Greška: Račun sa datim brojem ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO korisnik_racun (IDKORISNIK, IDRACUNA)
    VALUES (@id_drugog_korisnika, @id_racuna);

    COMMIT TRANSACTION;

    PRINT 'Uspešno dodeljeno ovlašćenje.';
END;
CREATE FUNCTION IzlistajNeaktivneRacune
(
    @id_korisnika INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT racun.BROJRACUNA
    FROM racun
    JOIN korisnik_racun ON racun.IDRACUNA = korisnik_racun.IDRACUNA
    WHERE korisnik_racun.IDKORISNIk = @id_korisnika
      AND racun.STATUSRACUNA = 'Neaktivan'
);
CREATE PROCEDURE PromeniPodatkeKorisnika
    @id_korisnika INT,
    @nova_ulica NVARCHAR(255),
    @novi_ulicni_broj NVARCHAR(10),
    @novi_kontakt NVARCHAR(15),
    @novo_mesto_stanovanja NVARCHAR(30),
    @novi_email NVARCHAR(100)
AS
BEGIN
    BEGIN TRANSACTION;

    UPDATE korisnik
    SET ULICAKORISNIKA = @nova_ulica,
        ULICNIBROJKORISNIKA = @novi_ulicni_broj,
        KONTAKTKORISNIKA = @novi_kontakt,
        mestostanovanja = @novo_mesto_stanovanja,
        EMAILKORISNIKA = @novi_email
    WHERE IDKORISNIK = @id_korisnika;

    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'Greška: Korisnik sa datim ID-om ne postoji.';
        ROLLBACK TRANSACTION;
        RETURN;
    END

    COMMIT TRANSACTION;

    PRINT 'Podaci su uspešno promenjeni.';
END;

CREATE PROCEDURE Placanje (
    @korisnik_id INT,
    @racun_primaoca VARCHAR(20),
    @kolicina DECIMAL(10, 2)
)
AS
BEGIN
    DECLARE @stanje_korisnika DECIMAL(10, 2);
    DECLARE @stanje_primaoca DECIMAL(10, 2);
    DECLARE @tip_racuna_korisnika VARCHAR(10);
    DECLARE @tip_racuna_primaoca VARCHAR(10);
    DECLARE @aktivan_korisnik VARCHAR(10);
    DECLARE @aktivan_primaoc VARCHAR(10);
    DECLARE @id_racuna_primaoca INT;

    BEGIN TRANSACTION;

    SELECT @stanje_korisnika = TRENUTNOSTANJERACUNA, 
           @tip_racuna_korisnika = TIPRACUNA, 
           @aktivan_korisnik = STATUSRACUNA
    FROM racun
    WHERE idracuna = @korisnik_id;

    IF @aktivan_korisnik != 'Aktivan'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Korisnikov račun nije aktivan.';
        RETURN;
    END

    SELECT @stanje_primaoca = TRENUTNOSTANJERACUNA, 
           @tip_racuna_primaoca = TIPRACUNA, 
           @aktivan_primaoc = STATUSRACUNA,
           @id_racuna_primaoca = idracuna 
    FROM racun
    WHERE BROJRACUNA = @racun_primaoca;

    IF @aktivan_primaoc != 'Aktivan'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Račun primaoca nije aktivan.';
        RETURN;
    END

    IF @tip_racuna_korisnika != @tip_racuna_primaoca
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Tip računa se ne poklapa.';
        RETURN;
    END

    IF @stanje_korisnika < @kolicina
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Nedovoljna sredstva na računu korisnika.';
        RETURN;
    END

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA - @kolicina 
    WHERE idracuna = @korisnik_id;

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA + @kolicina 
    WHERE idracuna = @id_racuna_primaoca;

    DECLARE @nova_transakcija_id INT;

    INSERT INTO transakcija (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE)
    VALUES ('isplata', @kolicina);

    SET @nova_transakcija_id = SCOPE_IDENTITY();

	select * from TRANSAKCIJA_RACUN

    INSERT INTO transakcija_racun (idracuna, idtransakcije,datumtransakcije)
    VALUES (@korisnik_id, @nova_transakcija_id, GETDATE());

    INSERT INTO transakcija (tiptransakcije, IZNOSTRANSAKCIJE)
    VALUES ('uplata', @kolicina);

    SET @nova_transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (idracuna, idtransakcije, datumtransakcije)
    VALUES (@id_racuna_primaoca, @nova_transakcija_id, GETDATE());

    COMMIT TRANSACTION;
    PRINT 'Uspešno izvršena transakcija.';

END

CREATE PROCEDURE TransferNovca (
    @korisnik_id INT,
    @racun_primaoca VARCHAR(20),
    @kolicina DECIMAL(10, 2)
)
AS
BEGIN
    DECLARE @stanje_korisnika DECIMAL(10, 2);
    DECLARE @stanje_primaoca DECIMAL(10, 2);
    DECLARE @tip_racuna_korisnika VARCHAR(10);
    DECLARE @tip_racuna_primaoca VARCHAR(10);
    DECLARE @aktivan_korisnik VARCHAR(10);
    DECLARE @aktivan_primaoc VARCHAR(10);
    DECLARE @id_racuna_primaoca INT;

    BEGIN TRANSACTION;

    SELECT @stanje_korisnika = TRENUTNOSTANJERACUNA, 
           @tip_racuna_korisnika = TIPRACUNA, 
           @aktivan_korisnik = STATUSRACUNA
    FROM racun
    WHERE idracuna = @korisnik_id;

    IF @aktivan_korisnik != 'Aktivan'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Korisnikov račun nije aktivan.';
        RETURN;
    END

    SELECT @stanje_primaoca = TRENUTNOSTANJERACUNA, 
           @tip_racuna_primaoca = TIPRACUNA, 
           @aktivan_primaoc = STATUSRACUNA,
           @id_racuna_primaoca = idracuna 
    FROM racun
    WHERE BROJRACUNA = @racun_primaoca;

    IF @aktivan_primaoc != 'Aktivan'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Račun primaoca nije aktivan.';
        RETURN;
    END

    IF @tip_racuna_korisnika != @tip_racuna_primaoca
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Transfer je moguć samo između istog tipa računa.';
        RETURN;
    END

    IF @stanje_korisnika < @kolicina
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Nedovoljna sredstva na računu korisnika.';
        RETURN;
    END

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA - @kolicina 
    WHERE idracuna = @korisnik_id;

    UPDATE racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA + @kolicina 
    WHERE idracuna = @id_racuna_primaoca;

    DECLARE @nova_transakcija_id INT;

    INSERT INTO transakcija (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE)
    VALUES ('isplata', @kolicina);

    SET @nova_transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (idracuna, idtransakcije, datumtransakcije)
    VALUES (@korisnik_id, @nova_transakcija_id, GETDATE());

    INSERT INTO transakcija (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE)
    VALUES ('uplata', @kolicina);

    SET @nova_transakcija_id = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (idracuna, idtransakcije, datumtransakcije)
    VALUES (@id_racuna_primaoca, @nova_transakcija_id, GETDATE());

    COMMIT TRANSACTION;
    PRINT 'Uspešno izvršena transakcija.';

END

CREATE TABLE Valute (
    IdValute INT IDENTITY(1,1) PRIMARY KEY ,
	NazivValute nvarchar(40),
    Koeficijent DECIMAL(10, 4) NOT NULL
);
INSERT INTO valute (nazivValute, koeficijent)
VALUES ('USD', 110.00)

ALTER TABLE valute
ADD IDRadnika INT;
ALTER TABLE valute
ADD CONSTRAINT FK_valute_Radnik
FOREIGN KEY (IDRadnika) REFERENCES Radnik(IDRadnika);

alter PROCEDURE DodajValutu (
    @idRadnika INT,
    @valuta NVARCHAR(50),
    @noviKoeficijent DECIMAL(10, 4)
)
AS
BEGIN
    DECLARE @idPozicije INT;
    DECLARE @nazivPozicije NVARCHAR(100);

    SELECT @idPozicije = IDPozicije
    FROM Radnik
    WHERE IDRadnika = @idRadnika;

    SELECT @nazivPozicije = NazivPozicije
    FROM RADNIKPOZICIJA
    WHERE IDPozicije = @idPozicije;

    IF @nazivPozicije != 'Analitičar valuta'
    BEGIN
        PRINT 'Greška: Samo Analitičar valuta mogu dodavati valute.';
        RETURN;
    END

    INSERT INTO valute (nazivvalute, Koeficijent, IDRadnika)
    VALUES (@valuta, @noviKoeficijent, @idRadnika);

    PRINT 'Uspešno dodata nova valuta.';
END
alter PROCEDURE IzmeniKoeficijent (
    @idRadnika INT,
    @valuta NVARCHAR(50),
    @noviKoeficijent DECIMAL(10, 4)
)
AS
BEGIN
    DECLARE @idPozicije INT;
    DECLARE @nazivPozicije NVARCHAR(100);

    SELECT @idPozicije = IDPozicije
    FROM Radnik
    WHERE IDRadnika = @idRadnika;


    SELECT @nazivPozicije = NazivPozicije
    FROM RADNIKPOZICIJA
    WHERE IDPozicije = @idPozicije;

    IF @nazivPozicije != 'Analitičar valuta'
    BEGIN
        PRINT 'Greška: Samo Analitičari valuta mogu menjati koeficijente.';
        RETURN;
    END

    UPDATE valute
    SET Koeficijent = @noviKoeficijent
    WHERE nazivValute = @valuta;

    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'Greška: Valuta ne postoji.';
        RETURN;
    END

    PRINT 'Uspešno izmenjen koeficijent za valutu.';
END
CREATE PROCEDURE KonvertujValutu (
    @idKorisnika INT,
    @iznos DECIMAL(10, 2),
    @brojDeviznogRacuna NVARCHAR(20),
    @brojTekucegRacuna NVARCHAR(20)  
)
AS
BEGIN
    DECLARE @stanjeDeviznog DECIMAL(10, 2);
    DECLARE @stanjeTekuceg DECIMAL(10, 2);
    DECLARE @koeficijent DECIMAL(10, 4);
    DECLARE @iznosKonvertovan DECIMAL(10, 2);
    DECLARE @tipRacuna NVARCHAR(20);
    DECLARE @novaTransakcijaID INT;

	 BEGIN TRANSACTION;

    SELECT @stanjeDeviznog = TRENUTNOSTANJERACUNA, @tipRacuna = TIPRACUNA
    FROM racun
    WHERE BROJRACUNA = @brojDeviznogRacuna;

	IF @stanjeDeviznog IS NULL
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Devizni račun ne postoji.';
        RETURN;
    END

    IF @stanjeDeviznog < @iznos
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Nedovoljna sredstva na deviznom računu.';
        RETURN;
    END

	    IF @tipRacuna != 'strana valuta'
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Broj računa nije devizni.';
        RETURN;
    END

	    SELECT @stanjeTekuceg = TRENUTNOSTANJERACUNA
    FROM racun
    WHERE BROJRACUNA = @brojTekucegRacuna;

    IF @stanjeTekuceg IS NULL
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Greška: Tekući račun ne postoji.';
        RETURN;
    END

	SELECT @koeficijent = Koeficijent
    FROM valute
    WHERE nazivValute = 'EUR'; 

	SET @iznosKonvertovan = @iznos * @koeficijent;
	
	UPDATE racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA - @iznos
    WHERE BROJRACUNA = @brojDeviznogRacuna;

	UPDATE racun 
    SET TRENUTNOSTANJERACUNA = TRENUTNOSTANJERACUNA + @iznosKonvertovan
    WHERE BROJRACUNA = @brojTekucegRacuna;

INSERT INTO transakcija (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE)
    VALUES ('Promena novca', @iznos);

    SET @novaTransakcijaID = SCOPE_IDENTITY();

    INSERT INTO transakcija_racun (IDRACUNA, IDTRANSAKCIJE, DATUMTRANSAKCIJE)
    VALUES (
        (SELECT IDRACUNA FROM racun WHERE BROJRACUNA = @brojDeviznogRacuna), 
        @novaTransakcijaID, 
        GETDATE()
    );

    INSERT INTO transakcija (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE)
    VALUES ('Transfer', @iznosKonvertovan);

    SET @novaTransakcijaID = SCOPE_IDENTITY();


    INSERT INTO transakcija_racun (IDRACUNA, IDTRANSAKCIJE, DATUMTRANSAKCIJE)
    VALUES (
        (SELECT IDRACUNA FROM racun WHERE BROJRACUNA = @brojTekucegRacuna),@novaTransakcijaID,GETDATE());

    COMMIT TRANSACTION;

    PRINT 'Uspešno izvršena konverzija.';
END 




CREATE TRIGGER BrisanjeValuta
ON valute
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Greška: Brisanje iz tabele Valuta nije dozvoljeno.';
    ROLLBACK TRANSACTION;
END

alter PROCEDURE ProveriIstek
AS
BEGIN
    DECLARE @trenutniDatum DATE = GETDATE();

    SELECT Korisnik.EMAILKORISNIKA, Kartica.DATUMIZDAVANJAKARTICE
    FROM Kartica
    JOIN Racun ON Kartica.IDRacuna = Racun.IDRacuna
    JOIN Korisnik_Racun ON Racun.IDRacuna = Korisnik_Racun.IDRACUNA
    JOIN Korisnik ON Korisnik_Racun.IDKorisnik = Korisnik.IDKorisnik
    WHERE Kartica.ROKVAZENJA BETWEEN @trenutniDatum AND DATEADD(DAY, 30, @trenutniDatum)
	AND Kartica.StatusKartice = 'Aktivna';
END

ALTER TABLE Kartica
ADD StatusKartice NVARCHAR(50)

select * from kartica


CREATE TRIGGER BlokirajBrisanjeVrsteKartica
ON VrstaKartice
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR('Brisanje iz tabele VrstaKartice nije dozvoljeno.', 16, 1);
END

ALTER PROCEDURE DodajKarticu
    @jmbg NVARCHAR(13),
    @idRacuna INT,
    @brojKartice NVARCHAR(20),
    @CVV2 INT,
    @PIN INT
AS
BEGIN
    DECLARE @brojKarticaCount INT;
    DECLARE @nazivVrste NVARCHAR(50);
    DECLARE @tip_racuna NVARCHAR(50);
    DECLARE @brendKartice NVARCHAR(50);
    DECLARE @idKartice INT;

    BEGIN TRANSACTION;

    SELECT @brojKarticaCount = COUNT(*)
    FROM Kartica
    JOIN Racun ON Kartica.IDRacuna = Racun.IDRacuna
    JOIN Korisnik_Racun ON Racun.IDRacuna = Korisnik_Racun.IDRacuna
    JOIN Korisnik ON Korisnik_Racun.IDKorisnik = Korisnik.IDKorisnik
    WHERE Korisnik.JMBG = @jmbg AND Racun.IDRacuna = @idRacuna AND Kartica.StatusKartice = 'Aktivan';

    IF @brojKarticaCount >= 2
    BEGIN
        RAISERROR('Korisnik već ima dve aktivne kartice za ovaj račun.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    IF LEFT(@brojKartice, 4) <> '4876'
    BEGIN
        RAISERROR('Broj nove kartice mora početi sa 4876.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    SELECT @nazivVrste = VRSTARACUNA.NAZIVVRSTERACUNA, @tip_racuna = Racun.TipRacuna
    FROM Racun
    JOIN VRSTARACUNA ON Racun.IDVRSTERACUNA = VRSTARACUNA.IDVRSTERACUNA
    WHERE Racun.IDRacuna = @idRacuna;

    SET @brendKartice = 
        CASE 
            WHEN @nazivVrste = 'Tekući Račun' AND @tip_racuna = 'dinarski' THEN 'Dina'
            WHEN @nazivVrste = 'Tekući Račun' AND @tip_racuna = 'strana valuta' THEN 'Visa'
            WHEN @nazivVrste = 'Devizni Račun' AND @tip_racuna = 'strana valuta' THEN 'MasterCard'
            ELSE 'nepoznato' 
        END;

    INSERT INTO Kartica (IDRacuna, BrojKartice, TIPKARTICE, DATUMIZDAVANJAKARTICE, ROKVAZENJA, StatusKartice, PIN, CVV2)
    VALUES (@idRacuna, @brojKartice, @tip_racuna, GETDATE(), dbo.rok(), 'Aktivan', @PIN, @CVV2);

    SET @idKartice = SCOPE_IDENTITY();

    INSERT INTO VrstaKartice (IDKartice, Brend)
    VALUES (@idKartice, @brendKartice);

    COMMIT TRANSACTION;
END


ALTER PROCEDURE MenjajKarticu
    @jmbg NVARCHAR(13), 
    @idRacuna INT,
    @staraKartica NVARCHAR(20),
    @novaKartica NVARCHAR(20),
    @Pin INT,
    @CVV2 INT
AS
BEGIN
    DECLARE @nazivVrste NVARCHAR(50);
    DECLARE @tip_racuna NVARCHAR(50);
    DECLARE @brendKartice NVARCHAR(50);
    DECLARE @idKartice INT;

    BEGIN TRANSACTION;

    UPDATE Kartica
    SET StatusKartice = 'Deaktivirana'
    WHERE IDRacuna = @idRacuna AND BrojKartice = @staraKartica;

    IF LEFT(@novaKartica, 4) <> '4876'
    BEGIN
        RAISERROR('Broj nove kartice mora početi sa 4876.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    SELECT @nazivVrste = VRSTARACUNA.NAZIVVRSTERACUNA, @tip_racuna = Racun.TipRacuna
    FROM Racun
    JOIN VRSTARACUNA ON Racun.IDVRSTERACUNA = VRSTARACUNA.IDVRSTERACUNA
    WHERE Racun.IDRacuna = @idRacuna;

    SET @brendKartice = 
        CASE 
            WHEN @nazivVrste = 'Tekući Račun' AND @tip_racuna = 'dinarski' THEN 'Dina'
            WHEN @nazivVrste = 'Tekući Račun' AND @tip_racuna = 'strana valuta' THEN 'Visa'
            WHEN @nazivVrste = 'Devizni Račun' AND @tip_racuna = 'strana valuta' THEN 'MasterCard'
            ELSE 'nepoznato' 
        END;

    INSERT INTO Kartica (IDRacuna, BrojKartice,DATUMIZDAVANJAKARTICE, ROKVAZENJA, StatusKartice, PIN, CVV2, TIPKARTICE)
    VALUES (@idRacuna, @novaKartica,GETDATE() ,dbo.rok(), 'Aktivan', @Pin, @CVV2, @tip_racuna);

    SET @idKartice = SCOPE_IDENTITY();

    INSERT INTO VrstaKartice (IDKartice, Brend)
    VALUES (@idKartice, @brendKartice);

    COMMIT TRANSACTION;
END



select * from dbo.IzlistajNeaktivneRacune('1')

select * from dbo.PrikazivanjeZaposlenihPoEkspozituri('Ekspozitura Mladenovac')

select * from dbo.prikaziRacuneKorisnika('1')

select * from radnik
select dbo.LoginRadnik('MirkoK221','MK+4321')
select dbo.LoginKorisnik('Cofa13234','123')


	select * from EKSPOZITURA
	exec dbo.DodajRadnika
	@NAZIVEKPOZITURE = 'cofa',
    @NAZIVPOZICIJE = 'Regionalni direktor',
    @IMERADNIKA = 'Dzoni',
    @PREZIMERADNIKA = 'Octopod',
    @KONTAKTRADNIKA = '0610061530',
    @EMAILRADNIKA = 'milorad@gmail.com',
    @RADNIKKORIME = 'dzoni123',
    @RADNIKKORPASSWORD = 'admin',
    @IDKORISNIKA = 2,
	@jmbgRadnika = '1224567890444'

	select * from radnik  select * from RADNIKPOZICIJA
	exec dbo.ObrisiRadnika
	@idkorisnika = 9,
	@jmbg = '1234567890149'

	exec dbo.DodajValutu
	@idradnika = 9,
	@valuta = 'EUR',
	@novikoeficijent = '117'
	select * from valute
	exec dbo.IzmeniKoeficijent
	@idradnika = 9,
	@valuta = 'PoxiCoin',
	@novikoeficijent = '480'

	select * from KORISNIK_RACUN

	exec dbo.DeaktivirajRacun
	@broj_racuna = 183456789012345678;

	exec dbo.DodajNoviRacun
	@jmbg = 1234564890144,
	@broj_racuna =183456789012345618,
	@broj_kartice = 4876153456781012,
	@cvv2 = 831,
	@pin = 4931,
	@id_radnika = 3,
	@vrsta_racuna = 'Tekući Račun',
	@valuta = 'dinarski'


	exec dbo.DodajKarticu
	@jmbg = 1234564890144,
	@idRacuna =14,
	@brojkartice = 48761534561014,
	@pin = 1234,
	@cvv2= 342

	EXEC MenjajKarticu 
    @jmbg = 1234564890144,        
    @idRacuna = 14,                  
    @staraKartica = 48761534561014, 
    @novaKartica = 4876123456789013,  
    @Pin = 1234,                     
    @CVV2 = 123;

	exec dbo.UplataKorisnikaDinarski


	CREATE FUNCTION RadnikPretragaKorisnika
    (@jmbg NVARCHAR(13)
    )
RETURNS INT
AS
BEGIN
    DECLARE @idKorisnika INT;

    SELECT @idKorisnika = IDKorisnik
    FROM Korisnik
    WHERE JMBG = @jmbg;

    RETURN @idKorisnika;
END;
	
	

	exec dbo.PrikaziTransakcijeNaRacunu
	@broj_racuna = 183000000000000000

	
	exec dbo.Placanje 
	@broj_racuna = 183456789012345618,
	@racun_primaoca = 183000000000000000,
	@kolicina = 30

	select * from racun
	exec dbo.PromeniPodatkeKorisnika 
	@id_korisnika = 12,
	@nova_ulica = 'Nikole Pasica 323',
	@novi_ulicni_broj = '323',
	@novi_kontakt = '0673211743',
	@novo_mesto_stanovanja = 'Novi Pazar',
	@novi_email = 'promenjenmail@gmail.com'




