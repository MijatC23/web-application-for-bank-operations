<?php
If(!isset($_COOKIE['Korisnik'])){
    header("Location:/");
}; 
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
        <form action="funkcije.php" method="POST" class="col col-lg-5 mx-auto text-center">
            <label for="">Unesite Ime Primaoca</label>
            <input type="text" id="imeP" class="col mx-auto text-center form-control">
            <label for="">Unesite Prezime Primaoca</label>
            <input type="text" id="prezimeP" class="col mx-auto text-center form-control">
            <label for="">Unesite Mesto Prebilavista Primaoca</label>
            <input type="text" id="mestoP" class="col mx-auto text-center form-control">
            <label for="">Unesite Zeljeni Iznos</label>
            <input type="text" id="iznosP" class="col mx-auto text-center form-control">
            <label for="">Unesite Racun Primaoca</label>
            <input type="text" id="racunP" class="col mx-auto text-center form-control">
            <input type="button" class="dugme btn-success mt-2" value="Dodaj" id="ubaci">
        </form> 
        
        
    </div>
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
           izbrisiKolacic("Korisnik")
        })
    })

    $(document).ready(function(){
        $("#ubaci").click(function(){
            let imeP=$("#imeP").val();
            let prezimeP=$("#prezimeP").val();
            let mestoP=$("#mestoP").val();
            let iznosP=$("#iznosP").val();
            let racunP=$("#racunP").val();
            if (imeP === "" || prezimeP === "" || mestoP === "" || iznosP === "" || racunP === "") {
                  alert("Unesite sva polja");
             }
    else{
                        $.post("funkcije.php",{iznosP : iznosP, racunP : racunP},function(response){
                            console.log("Response from server: " + response);
                            if(response==" Uspesno"){
                                alert("Uspesno ste platili")
                            }
                            else{
                                alert("Greska prilikom placanja");
                            }

        })
        }
    })
    
    })
</script>

</html>
