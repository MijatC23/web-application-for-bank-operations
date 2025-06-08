<?php
If(!isset($_COOKIE['Administator'])){
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
                    <a href="zaposlenH.php" class="nav-link">
                    <i class="fa-solid fa-user-plus text-light"></i>
                        <span class="d-none d-sm-inline text-white" ID="dugmici" >Dodaj Korisnika</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="izbrisiKorisnika.php" class="nav-link">
                    <i class="fa-solid fa-user-slash text-white"></i>
                        <span class="d-none d-sm-inline text-white" ID="dugmici" >Izbrisi Korisnika</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="zaposlenRacun.php" class="nav-link">
                    <i class="fa-solid fa-file text-white"></i>
                        <span class="d-none d-sm-inline text-white" ID="dugmici" >Svi Racuni</span>
                    </a>
                </li>
            </ul>
            <ul class="nav flex-column mt-auto" >
                <li class="nav-item" >
                    <a href="" class="nav-link">
                        <i class="fa-solid fa-user me-2 text-light"></i>
                        <span class="d-none d-sm-inline text-light" ID="OdjaviSE">Odjavi Se</span>
                    </a>
                </li>
                
            </ul>
        </div>
        <form action="funkcije.php" method="POST" class="col col-lg-10 mx-auto text-center">
            <label for="">Svi dodati racuni</label>
        
        <table class="table">
            <thead>
                <tr>
                <th scope="col">Ime Radnika</th>
                <th scope="col">Broj Racuna</th>
                </tr>
            </thead>
            <tbody>
        <?php
        $sql="SELECT * from Racuni";
        $rezultat = sqlsrv_query($db, $sql);
        if ($rezultat === false) {
            die(print_r(sqlsrv_errors(), true));
        };
        while ($redT = sqlsrv_fetch_array($rezultat, SQLSRV_FETCH_ASSOC)) {
            echo "<tr>
                    <th scope='row'>{$redT['IMEZAPOSLENOG']}</th>
                    <td>{$redT['BROJRACUNA']}</td>
                  </tr>";
        }
    
        
        
        ?>
        
        </form></div>
    </div>

</body>
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
           izbrisiKolacic("Administator")
        })
    })
</script>
</html>
