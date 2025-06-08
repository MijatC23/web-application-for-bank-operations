<?php
If(!isset($_COOKIE['Korisnik'])){
    header("Location:/");
};
 require('konekcijaSaBazom.php');
 $db=konekcija();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="zaposlenH.css">
    <script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div id="nav" class="col-auto min-vh-100 d-flex flex-column justify-content-between" >
        <ul class="nav flex-column mb-auto">
                <li class="nav-item">
                    <a href="KorisnikH.php" class="nav-link">
                        <i class="fa-solid fa-home me-2 text-light"></i>
                        <span class="d-none d-sm-inline text-white" ID="dugmici" >Pocetna</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="placanje.php" class="nav-link">
                    <i class="fa-solid fa-credit-card text-light"></i>
                        <span class="d-none d-sm-inline text-white" ID="dugmici" >Placanje</span>
                    </a>
                </li>   
            </ul>
            <ul class="nav flex-column mt-auto" >
            <li class="nav-item" >
                    <a href="profil.php" class="nav-link">
                        <i class="fa-solid fa-user me-2 text-light"></i>
                        <span class="d-none d-sm-inline text-light">Profil</span>
                    </a>
                </li>
                <li class="nav-item" >
                    <a href="" class="nav-link">
                    <i class="fa-solid fa-right-from-bracket text-light"></i>
                        <span class="d-none d-sm-inline text-light" ID="OdjaviSE" >Odjavi Se</span>
                    </a>
                </li>
            </ul>
        </div>
        <div class="col-10">
            <table id="tabela" class="col-10">

            <?php
    if(isset($_COOKIE['Korisnik'])){
    $id=$_COOKIE['Korisnik'];
    $sqlP="EXEC PrikazKorisnik ${id}" ;
    $rezultat = sqlsrv_query($db, $sqlP);

if ($rezultat === false) {
    die(print_r(sqlsrv_errors(), true));
}

    while($red = sqlsrv_fetch_array($rezultat, SQLSRV_FETCH_ASSOC)){
        echo "<tr>
        <td  > Ime : {$red['IMEKORISNIKA']}</td>
        </tr>
        <tr>
        <td>Prezime : {$red['PREZIMEKORISNIKA']}</td>
        </tr>
        <tr>
        <td>Ulica : {$red['ULICAKORISNIKA']}</td>
        </tr>
        <tr>
        <td>Email : {$red['EMAILKORISNIKA']}</td>
        </tr>
        <tr>
        <td>Kontakt : {$red['KONTAKTKORISNIKA']}</td>
        </tr>
        <tr>
        <td>Mesto : {$red['MESTO']}</td>
        </tr>
        <td><a href='updateKorisnik.php' class='btn btn-success btn-sm'>Izmeni</a></td>
        
        
        
        
        </tr>";
    };
    echo "</table>";
}   
    ?>

        </div>
    
        
    </div>
    </div>
    <script>
        function izbrisiKolacic(imeKolacica) {
        var datum = new Date();
        datum.setDate(datum.getDate() - 1);
        var istice = ";expires=" + datum;
        var vrednost = "";
        document.cookie = imeKolacica + "=" + vrednost + istice + "; path=/";
        }
        $(document).ready(function(){
        $("#OdjaviSE").click(function(){
           izbrisiKolacic("Korisnik")
        })
    })
    </script>

</body>
</html>
