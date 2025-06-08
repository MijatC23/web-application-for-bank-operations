<?php
require('konekcijaSaBazom.php');
$db=konekcija();




?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="zaposlenH.css">
    <title>Document</title>
</head>
<body>
    <?php
   
        $id=$_COOKIE['Korisnik'];
        $sql="SELECT * from korisnik where IDKORISNIK= ${id}" ;
        $rezultat = sqlsrv_query($db, $sql);
        $red= sqlsrv_fetch_array($rezultat);
    
    ?>
    <div class="container-fluid">
        <div class="row">
        <form action="updateKorisnik.php" method="POST" class="col col-lg-5 mx-auto text-center">
        <input type="hidden" name="id" value="<?php echo $red['IDKORISNIK']?>">
            <label for="">Unesite Mesto Prebilavista</label>
            <input type="text" name="Mesto"  value="<?php echo $red['MESTO'] ?>" class="col mx-auto text-center form-control">
            <label for="">Unesite Ulicu</label>
            <input type="text" name="UlicaKorisnika" value="<?php echo $red['ULICAKORISNIKA'] ?>"  class="col mx-auto text-center form-control">
            <label for="">Unesite Email</label>
            <input type="text" name="EmailKorisnika" value="<?php echo $red['EMAILKORISNIKA'] ?>" class="col mx-auto text-center form-control">
            <label for="">Unesite Kontakt</label>
            <input type="text" name="KontaktKorisnika" value="<?php echo $red['KONTAKTKORISNIKA'] ?>"  class="col mx-auto text-center form-control">
            <label for="">Unesite Sifru</label>
            <input type="password" name="sifraKor1" value="<?php echo $red['KORISNIKPASSWORD'] ?>" class="col mx-auto text-center form-control">
            <label for="">Ponovo Unesite Sifru</label>
            <input type="password" name="sifraKor2" class="col mx-auto text-center form-control">
            <input type="submit" class="dugme btn-success mt-2" value="Izmeni"  name="ubaci">
        </form> 
        </div>
    </div>
    <?php
    if(isset($_POST['ubaci'])){
        $id=$_POST['id'];
        
        $Mesto=$_POST['Mesto'];
        $UlicaKorisnika=$_POST['UlicaKorisnika'];
        $EmailKorisnika=$_POST['EmailKorisnika'];
        $KontaktKorisnika=$_POST['KontaktKorisnika'];
        $sifraKor1=$_POST['sifraKor1'];
        $sifraKor2=$_POST['sifraKor2'];
            $brojevi = array();
            preg_match_all('/\d+/', $UlicaKorisnika, $brojevi);
            $broj = implode("", $brojevi[0]);
    if($sifraKor1 == $sifraKor2){
    if( $Mesto!=""  && $UlicaKorisnika!=""  && $EmailKorisnika!=""  && $KontaktKorisnika!="" ){
        $sqlU= "UPDATE KORISNIK SET MESTO= '${Mesto}', ULICAKORISNIKA = '${UlicaKorisnika}', ULICNIBROJKORISNIKA = '${broj}', EMAILKORISNIKA= '${EmailKorisnika}', KONTAKTKORISNIKA= '${KontaktKorisnika}' , KORISNIKPASSWORD= '${sifraKor1}' WHERE IDKORISNIK= '${id}'";
        $update= sqlsrv_query($db, $sqlU);
        if ($update === false) {
            die(print_r(sqlsrv_errors(), true));
        }else {
            header("Location: profil.php");
        }
    }else {
        echo "<script>
        alert('Greska. Niste sve podatke uneli.');
        </script>";
    }
    }else {echo "<script>
        alert('Niste lepo uneli sifru. povratak na profil'); window.location='profil.php';
        </script>";
        }
    }
    
    
    
    ?>
</body>
</html>