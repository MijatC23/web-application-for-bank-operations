<?php
If(!isset($_COOKIE['Administator'])){
    header("Location:/");
}; 
?>
<!DOCTYPE html>
<html lang="en">
<head>  
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="zaposlenH.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body><div class="container-fluid">
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
        <form action="funkcije.php" method="POST" class="col col-lg-5 mx-auto text-center mt-2">
            <label for="">Unesite JBMG Korisnika</label>
            <input type="text" id="JBMG" class="form-control">
            <input type="button" class="dugme btn-success mt-2" value="Obrisi" id="dugme">
        </form> 
        
        
    </div>
</div>
    <script>
    $(document).ready(function(){
        $("#dugme").click(function(){
            let JBMG = $("#JBMG").val();
            $.post("funkcije.php", { JBMG: JBMG}, function(response){
                console.log(response);
                if(response ==" Ima") {
                    alert("Uspesno ste obrisali korisnika")
                } else {
                    alert("Nepostoi unet korisnik. Ispravite podatke");
                }
            });
        });
    });
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
</body>
</html>