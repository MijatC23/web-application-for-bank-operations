<?php
If(!isset($_COOKIE['Korisnik'])){
    header("Location:/");
}; 
require('konekcijaSaBazom.php');
  $db = konekcija();
$id=$_COOKIE['Korisnik'];
$upit="SELECT BROJRACUNA,TRENUTNOSTANJERACUNA,IDRACUNA,IDKORISNIK FROM RACUN WHERE IDKORISNIK =$id";
$rezultat = sqlsrv_query($db, $upit);

if ($rezultat === false) {
    die(print_r(sqlsrv_errors(), true));
};

$red=sqlsrv_fetch_array($rezultat);
if($red){
$upitTranzakcija= "SELECT t.TIPTRANSAKCIJE, t.IZNOSTRANSAKCIJE, t.DATUMTRANSAKCIJE, k.IMEKORISNIKA
FROM TRANSAKCIJA t
INNER JOIN TRANSAKCIJA_RACUN tr ON t.IDTRANSAKCIJE = tr.IDTRANSAKCIJE
INNER JOIN KORISNIK k ON tr.ID = k.IDKORISNIK
WHERE  tr.IDRACUNA = {$red['IDRACUNA']}";
$rezultatT=sqlsrv_query($db,$upitTranzakcija);
if($rezultatT === false){
    die(print_r(sqlsrv_errors(), true));
};
$redT=sqlsrv_fetch_array($rezultatT);
}
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
        <div class="card col-10" id="Kartica">
        <div class="card-body col-12">
          <h5 class="card-title">Bankarski kredincijali</h5>
            <div class="mb-3">
              <label for="username" class="form-label">Broj Racuna:</label>
              <p><?php echo"{$red['BROJRACUNA']}";?></p>
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Trenutno Stanje na Racunu:</label>
              <p><?php echo"{$red['TRENUTNOSTANJERACUNA']}";?> rsd</p>
            </div>
            <hr>
            <form id="filterForm">
      <label for="tipTransakcije">Unesite tip transakcije (uplata/primanje):</label>
    <input type="text" name="tipTransakcije" id="tipTransakcije">
    <button type="submit">Filtriraj</button>
</form>
            <table class="table">
            <thead>
                <tr>
                <th scope="col">Naziv</th>
                <th scope="col">Iznos</th>
                <th scope="col">Vreme</th>
                <th scope="col">Naziv Primaoca</th>
                </tr>
            </thead>
            <tbody>
    <?php
    if(isset($_GET['tipTransakcije'])) {
        $tipTransakcije = ($_GET['tipTransakcije']);
    
        $upitTranzakcija = "SELECT t.TIPTRANSAKCIJE, t.IZNOSTRANSAKCIJE, t.DATUMTRANSAKCIJE, k.IMEKORISNIKA, tr.ULOGA
                            FROM TRANSAKCIJA t
                            INNER JOIN TRANSAKCIJA_RACUN tr ON t.IDTRANSAKCIJE = tr.IDTRANSAKCIJE
                            INNER JOIN KORISNIK k ON tr.ID = k.IDKORISNIK
                            WHERE tr.IDRACUNA = {$red['IDRACUNA']} AND t.TIPTRANSAKCIJE LIKE '%$tipTransakcije%'";
    } else {
          $upitTranzakcija = "SELECT *
          FROM prikazivanjeTransakcija({$red['IDRACUNA']})";
    }
    
    $rezultatT = sqlsrv_query($db, $upitTranzakcija);
    if ($rezultatT === false) {
        die(print_r(sqlsrv_errors(), true));
    };
    while ($redT = sqlsrv_fetch_array($rezultatT, SQLSRV_FETCH_ASSOC)) {
        $datumTransakcije = $redT['DATUMTRANSAKCIJE']->format('Y-m-d H:i:s');
        echo "<tr>
                <th scope='row'>{$redT['TIPTRANSAKCIJE']}</th>
                <td>{$redT['IZNOSTRANSAKCIJE']}</td>
                <td>{$datumTransakcije}</td>
                <td>{$redT['IMEKORISNIKA']}</td>
              </tr>";
    }

    
    
    
    
    
    ?>
            </tbody>
        </table>
</div>
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
