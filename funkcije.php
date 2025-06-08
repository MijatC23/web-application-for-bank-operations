 <?php
  require('konekcijaSaBazom.php');

  $db = konekcija();


  if(isset($_POST['korImeZ']) && isset($_POST['korPassZ'])) {
      $korImeZ = $_POST['korImeZ'];
      $korPassZ = $_POST['korPassZ'];
      
     
      $sql = "SELECT IDZAPOSLENOG FROM ZAPOSLEN WHERE ZAPOSLENKORIME = ? AND ZAPOSLENKORPASSWORD = ?";
      $parametri = array($korImeZ, $korPassZ);
      
      $upitL = sqlsrv_prepare($db, $sql, $parametri);
      if($upitL === false) {
          echo "Greska" . print_r(sqlsrv_errors(), true);
          exit;
      }
      
      if(sqlsrv_execute($upitL)) {
          if(sqlsrv_has_rows($upitL)) {
            $redL= sqlsrv_fetch_array($upitL);
            setcookie("Administator","{$redL['IDZAPOSLENOG']}",time()+8600,"/");
              echo "Da";
          } else {
              echo "Ne"; 
          }
      } 
  } 

if(isset($_POST['imeKor']) && isset($_POST['prezimeKor'])&& 
isset($_POST['emailKor'])&& isset($_POST['ulicaKor'])&& 
isset($_POST['brojevi'])&& isset($_POST['konverzijaJ'])&& 
isset($_POST['konverzijaK'])&& isset($_POST['mesto'])){
    $imeKor= $_POST['imeKor'];
    $prezimeKor= $_POST['prezimeKor'];
    $emailKor= $_POST['emailKor'];
    $ulicaKor= $_POST['ulicaKor'];
    $brojevi= $_POST['brojevi'];
    $konverzijaJ= $_POST['konverzijaJ'];
    $konverzijaK= $_POST['konverzijaK'];
    $mesto= $_POST['mesto'];

    $slovo= substr($prezimeKor,0,1);
    $user= $imeKor.$slovo;

    function password($length){
        $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+';
        $promeni = str_shuffle($chars);
        $sifra = substr($promeni,0,$length);
        return $sifra;
    }

    function dodavanjeIDKorisnika($db) {
        $query = "SELECT MAX(IDKORISNIK) AS PoslednjiID FROM KORISNIK";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId+ 1;
    }
    function TrenutniIDKorisnika($db) {
        $query = "SELECT MAX(IDKORISNIK) AS PoslednjiID FROM KORISNIK";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId;
    }
    function idProveraKartice($db) {
        $query = "SELECT MAX(IDKARTICE) AS PoslednjiID FROM KARTICA";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId+ 1;
    }
    function idProveraRacun($db) {
        $query = "SELECT MAX(IDRACUNA) AS PoslednjiID FROM RACUN";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId+ 1;
    }
    function TrenutniIDRacuna($db) {
        $query = "SELECT MAX(IDRACUNA) AS PoslednjiID FROM RACUN";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId;
    }
   
    function generisiRacun(){
        $start="183";
        for($ostaliBrojevi= mt_rand(1,9),$i=1;$i<15;$i++){
            $ostaliBrojevi .= mt_rand(0,9);
            $rezultat=$start.$ostaliBrojevi;
        }
        return $rezultat;
    };
    function generisiKarticu(){
        for($ostaliBrojevi= mt_rand(1,9),$i=1;$i<16;$i++){
            $ostaliBrojevi .= mt_rand(0,9);
            $rezultat=$ostaliBrojevi;
        }
        return $rezultat;
    };
    function generisiPin(){
        for($ostaliBrojevi= mt_rand(1,9),$i=1;$i<4;$i++){
            $ostaliBrojevi .= mt_rand(0,9);
            $rezultat=$ostaliBrojevi;
        }
        return $rezultat;
    };
    function generisiCSV(){
        for($ostaliBrojevi= mt_rand(1,9),$i=1;$i<3;$i++){
            $ostaliBrojevi .= mt_rand(0,9);
            $rezultat=$ostaliBrojevi;
        }
        return $rezultat;
    };


    $lozinka= password(8);
    $trenutniID=dodavanjeIDKorisnika($db);
    function dodajRacun($db){
        $trenutniDatumString = date("Y-m-d H:i:s.u");
        $trenutniDatum = new DateTime($trenutniDatumString);
        $trenutniDatumSQL = $trenutniDatum->format('Y-m-d H:i:s.u');
        $trenutniDatumSQL = substr($trenutniDatumSQL, 0, -3); 
            $generisaniRacun=generisiRacun();
            $idRacuna= idProveraRacun($db);
            $trenutniID=TrenutniIDKorisnika($db);
            $sqlRacun = "INSERT INTO RACUN(IDKORISNIK,BROJRACUNA,TIPRACUNA,TRENUTNOSTANJERACUNA,DATUMKREIRANJARACUNA,STATUSRACUNA)
            VALUES($trenutniID,$generisaniRacun,'Dinarski',10000,'$trenutniDatumSQL','Aktivan')"; 
        $rezultatR = sqlsrv_query($db, $sqlRacun);
    
        if ($rezultatR === false) {
            die(print_r(sqlsrv_errors(), true));
        }
        }
        function dodajKarticu($db){
            $idKartice= idProveraKartice($db);
            $trenutniIdRacuna=TrenutniIDRacuna($db);
            $trenutniDatumString = date("Y-m-d H:i:s.u");
            $trenutniDatum = new DateTime($trenutniDatumString);
            $trenutniDatumSQL = $trenutniDatum->format('Y-m-d H:i:s.u');
            $trenutniDatumSQL = substr($trenutniDatumSQL, 0, -3); 
            $generisanaKartica= generisiKarticu();
            $generisaniPIN= generisiPin();
            $generisaniCSV=generisiCSV();
            $sqlKartica = "INSERT INTO KARTICA(IDRACUNA,TIPKARTICE,DATUMIZDAVANJAKARTICE,BROJKARTICE,PIN,CSV)
            VALUES($trenutniIdRacuna,'Dinarski','$trenutniDatumSQL',$generisanaKartica,$generisaniPIN,$generisaniCSV)"; 
            $rezultatK = sqlsrv_query($db, $sqlKartica);
            if ($rezultatK === false) {
                die(print_r(sqlsrv_errors(), true));
            }
        }
        function MedjuTabela($db){
            $idZaposlenog=$_COOKIE['Administator'];
            $trenutniIdRacuna=TrenutniIDRacuna($db);
            $sqlMedjuTabela="INSERT INTO zaposlen_racun(IDZAPOSLENOG,IDRACUNA)
            values($idZaposlenog,$trenutniIdRacuna)";
            $rezultatMT=sqlsrv_query($db,$sqlMedjuTabela);
            if ($rezultatMT === false) {
                die(print_r(sqlsrv_errors(), true));
            }
        };
       


    $upit = "INSERT INTO KORISNIK(IMEKORISNIKA,PREZIMEKORISNIKA,ULICAKORISNIKA,ULICNIBROJKORISNIKA,EMAILKORISNIKA,KONTAKTKORISNIKA,JMBG,KORISNIKUSER,KORISNIKPASSWORD,Mesto)
    VALUES(?,?,?,?,?,?,?,?,?,?)";
    
    $parametri = array($imeKor, $prezimeKor, $ulicaKor, $brojevi, $emailKor, $konverzijaK, $konverzijaJ, $user, $lozinka, $mesto);
    $upitU = sqlsrv_prepare($db, $upit, $parametri);
    
    if ($upitU === false) {
        echo "Greska" . print_r(sqlsrv_errors(), true);
        exit;
    }
    
    if (sqlsrv_execute($upitU)) {
       dodajRacun($db);
       dodajKarticu($db);
       MedjuTabela($db);
        echo "Uspesno";

    } else {
        echo "Greska" . print_r(sqlsrv_errors(), true);
    }
    
    }
    if(isset($_POST['korisnikKorIme']) && isset($_POST['korisnikKorPassword']) ){
        $korisnikKorIme = $_POST['korisnikKorIme'];
        $korisnikKorPassword=$_POST['korisnikKorPassword'];

        $sql="SELECT IDKORISNIK from KORISNIK where KORISNIKUSER=? and KORISNIKPASSWORD=?";
        $parametri=array($korisnikKorIme,$korisnikKorPassword);
        $upitK=sqlsrv_prepare($db, $sql, $parametri);
        if($upitK === false) {
            echo "Greska" . print_r(sqlsrv_errors(), true);
            exit;
        }
        function TrenutniIDKorisnika($db) {
            $korisnikKorIme = $_POST['korisnikKorIme'];
            $query = "SELECT IDKORISNIK FROM KORISNIK where KORISNIKUSER = '${korisnikKorIme}'";
            $result = sqlsrv_query($db, $query);
        
            if ($result === false) {
                die(print_r(sqlsrv_errors(), true));
            }
        
            $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
            $poslednjiId = $row["IDKORISNIK"];
            return $poslednjiId;
        }
        if(sqlsrv_execute($upitK)) {
            if(sqlsrv_has_rows($upitK)) {
                $id=TrenutniIDKorisnika($db);
              setcookie("Korisnik","${id}",time()+8600,"/");
                echo "Da";
            } else {
                echo "Ne"; 
            }
        } else {
            echo "Greska" . print_r(sqlsrv_errors(), true);
        }


    }
function IzbrisatiKorisnika($jbmg, $db) {
    $upitProvera = "SELECT COUNT(*) AS Ukupno FROM KORISNIK WHERE jmbg=$jbmg";
    $rezultatProvere = sqlsrv_query($db, $upitProvera);
    $redProvera = sqlsrv_fetch_array($rezultatProvere);
    $Ukupno = $redProvera['Ukupno'];
    
    if($Ukupno < 1) {
        echo "Korisnik ne postoji.";
        return false;
    } else {
        
        $upitBrisanjeRacun="DELETE FROM TRANSAKCIJA_RACUN WHERE IDRACUNA IN(SELECT IDRACUNA FROM RACUN WHERE IDKORISNIK IN(SELECT IDKORISNIK FROM KORISNIK WHERE Jmbg=$jbmg))";
        $rezultatBrisanjeRacun = sqlsrv_query($db, $upitBrisanjeRacun);
    
        if ($rezultatBrisanjeRacun === false) {
            echo "Greška" . print_r(sqlsrv_errors(), true);
            return false;
        }

        $upitBrisanjeID="DELETE FROM TRANSAKCIJA_RACUN WHERE ID IN(SELECT IDKORISNIK FROM KORISNIK WHERE Jmbg=$jbmg)";
        $rezultatBrisanjeID = sqlsrv_query($db, $upitBrisanjeID);
    
        if ($rezultatBrisanjeID === false) {
            echo "Greška" . print_r(sqlsrv_errors(), true);
            return false;
        }

        $upitZaposlenRacun = "DELETE FROM ZAPOSLEN_RACUN WHERE IDRACUNA IN (SELECT IDRACUNA FROM RACUN WHERE IDKORISNIK IN (SELECT IDKORISNIK FROM KORISNIK WHERE Jmbg=$jbmg))";
        $rezultatZaposlenRacun = sqlsrv_query($db, $upitZaposlenRacun);

        if ($rezultatZaposlenRacun === false) {
            echo "Greška" . print_r(sqlsrv_errors(), true);
            return false;
        }


        $upitKartica = "DELETE FROM KARTICA WHERE IDRACUNA IN (SELECT IDRACUNA FROM RACUN WHERE IDKORISNIK IN (SELECT IDKORISNIK FROM KORISNIK WHERE Jmbg=$jbmg))";
        $rezultatKartica = sqlsrv_query($db, $upitKartica);
    
        if ($rezultatKartica === false) {
            echo "Greška" . print_r(sqlsrv_errors(), true);
            return false;
        }
        

        $upitRacun = "DELETE FROM RACUN WHERE IDKORISNIK IN (SELECT IDKORISNIK FROM KORISNIK WHERE Jmbg=$jbmg)";
        $rezultatRacun = sqlsrv_query($db, $upitRacun);
    
        if ($rezultatRacun === false) {
            echo "Greška" . print_r(sqlsrv_errors(), true);
            return false;
        }
    

        $upitKorisnik = "DELETE FROM KORISNIK WHERE Jmbg=$jbmg";
        $rezultatKorisnik = sqlsrv_query($db, $upitKorisnik);
    
        if ($rezultatKorisnik === false) {
            echo "Greška" . print_r(sqlsrv_errors(), true);
            return false;
        }

        return true;
    }


        
      
    }
    if(isset($_POST['JBMG'])){
        $jbmg=$_POST['JBMG'];
        if (IzbrisatiKorisnika($jbmg,$db) === true) {
            echo "Ima";
        } else {
            echo "Greska" . print_r(sqlsrv_errors(), true);
        }
    }
    function idProveraTranzakcija($db) {
        $query = "SELECT MAX(IDTRANSAKCIJE) AS PoslednjiID FROM TRANSAKCIJA";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId+ 1;
    };
    function idProveraTranzakcija1($db) {
        $query = "SELECT MAX(IDTRANSAKCIJE) AS PoslednjiID FROM TRANSAKCIJA";
        $result = sqlsrv_query($db, $query);
    
        if ($result === false) {
            die(print_r(sqlsrv_errors(), true));
        }
    
        $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC);
        $poslednjiId = $row["PoslednjiID"];
        return $poslednjiId+ 2;
    };
    if(isset($_POST['iznosP'])&& isset($_POST['racunP'])){
        $iznosP=$_POST['iznosP'];
        $racunP=$_POST['racunP'];
        $kolacic=$_COOKIE['Korisnik'];
        $idTransakcije= idProveraTranzakcija($db);
        $idTransakcije1= idProveraTranzakcija1($db);
        $trenutniDatumString = date("Y-m-d H:i:s.u");
        $trenutniDatum = new DateTime($trenutniDatumString);
        $trenutniDatumSQL = $trenutniDatum->format('Y-m-d H:i:s.u');
        $trenutniDatumSQL = substr($trenutniDatumSQL, 0, -3); 

        $upitProveraStanja = "SELECT TRENUTNOSTANJERACUNA FROM RACUN WHERE IDKORISNIK=$kolacic";
        $rezultatProveraStanja = sqlsrv_query($db, $upitProveraStanja);
        $redPS = sqlsrv_fetch_array($rezultatProveraStanja);

    if ($redPS['TRENUTNOSTANJERACUNA'] == 0 || $redPS['TRENUTNOSTANJERACUNA'] < 0) {
    echo " Ne";
    } else {
        $upitSmanjivanje = "UPDATE RACUN SET TRENUTNOSTANJERACUNA= TRENUTNOSTANJERACUNA - $iznosP WHERE IDKORISNIK = $kolacic";

        $upitTS = "INSERT INTO TRANSAKCIJA (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE, DATUMTRANSAKCIJE)
               VALUES ('Uplata', $iznosP, '$trenutniDatumSQL')";

        $upitPovecanje = "UPDATE RACUN SET TRENUTNOSTANJERACUNA= TRENUTNOSTANJERACUNA + $iznosP WHERE BROJRACUNA= $racunP";

        $upitTP = "INSERT INTO TRANSAKCIJA (TIPTRANSAKCIJE, IZNOSTRANSAKCIJE, DATUMTRANSAKCIJE)
               VALUES ('Primanje', $iznosP, '$trenutniDatumSQL')";




        $rezultatS= sqlsrv_query($db,$upitSmanjivanje);
        $upitVEZNAS="SELECT * FROM RACUN WHERE IDKORISNIK= $kolacic";
        $rezultatVEZNAS=sqlsrv_query($db,$upitVEZNAS);
        $redS= sqlsrv_fetch_array($rezultatVEZNAS);

        $int= intval($redS['IDRACUNA']);
        $idPrimaoca=$redS['IDKORISNIK'];
   


        $rezultatTS= sqlsrv_query($db,$upitTS);


        $rezultatP=sqlsrv_query($db,$upitPovecanje);
        $upitVEZNAP="SELECT * FROM RACUN WHERE BROJRACUNA= $racunP";
        $upitPrimalac="SELECT IDKORISNIK FROM KORISNIK WHERE idkorisnik in (SELECT IDKORISNIK FROM RACUN WHERE BROJRACUNA =$racunP)";
        $rezultatVEZNAP=sqlsrv_query($db,$upitVEZNAP);
        $rezultatPrimalac=sqlsrv_query($db,$upitPrimalac);
        $redP= sqlsrv_fetch_array($rezultatVEZNAP);
        $redPosiljalac=sqlsrv_fetch_array($rezultatPrimalac);
        $int1= intval($redP['IDRACUNA']);

        $ime1=$redPosiljalac['IDKORISNIK'];



        $rezultatTP= sqlsrv_query($db,$upitTP);



        $upitVezna="INSERT INTO TRANSAKCIJA_RACUN(IDTRANSAKCIJE,IDRACUNA,ID,ULOGA) VALUES ($idTransakcije,$int,$ime1,'Primalac')";

        
        $upitVezna1="INSERT INTO TRANSAKCIJA_RACUN(IDTRANSAKCIJE,IDRACUNA,ID,ULOGA) VALUES ($idTransakcije1,$int1,$idPrimaoca,'Platilac')";
        
        $rezultatVEZNA= sqlsrv_query($db,$upitVezna);
        $rezultatVEZNA1= sqlsrv_query($db,$upitVezna1);
        echo "Uspesno";
        }
    };
?>