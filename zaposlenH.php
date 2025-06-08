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
        <form action="funkcije.php" method="POST" class="col col-lg-5 mx-auto text-center">
            <label for="">Unesite Ime</label>
            <input type="text" id="imeKor" class="col mx-auto text-center form-control">
            <label for="">Unesite Prezime</label>
            <input type="text" id="prezimeKor" class="col mx-auto text-center form-control">
            <label for="">Unesite Mesto Prebilavista</label>
            <input type="text" id="mesto" class="col mx-auto text-center form-control">
            <label for="">Unesite Ulicu</label>
            <input type="text" id="ulicaKor" class="col mx-auto text-center form-control">
            <label for="">Unesite Email</label>
            <input type="text" id="emailKor" class="col mx-auto text-center form-control">
            <label for="">Unesite Kontakt</label>
            <input type="text" id="kontaktKor" class="col mx-auto text-center form-control">
            <label for="">Unesite JBMG</label>
            <input type="text" id="jbmgKor" class="col mx-auto text-center form-control">
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
           izbrisiKolacic("Administator")
        })
    })

    $(document).ready(function(){
        $("#ubaci").click(function(){
            let imeKor=$("#imeKor").val();
            let prezimeKor=$("#prezimeKor").val();
            let mesto=$("#mesto").val();
            let ulicaKor=$("#ulicaKor").val();
            let brojevi= ulicaKor.match(/\d+/g);
            let broj=brojevi.join("");
            let emailKor=$("#emailKor").val();
            let kontaktKor=$("#kontaktKor").val();          
            let konverzijaK=+kontaktKor;
            let jbmgKor=$("#jbmgKor").val();
            let konverzijaJ= parseInt(jbmgKor)
            if(imeKor !== "" && prezimeKor !=="" && mesto !=="" && ulicaKor !=="" && emailKor !=="" && kontaktKor !=="" &&  jbmgKor !==""){
            if(emailKor.includes("@")){
                if(!isNaN(konverzijaK)){
                    if(jbmgKor.length === 13  ){
                        $.post("funkcije.php",{imeKor : imeKor, prezimeKor : prezimeKor, emailKor: emailKor, ulicaKor : ulicaKor, brojevi : brojevi, konverzijaJ : konverzijaJ,konverzijaK : kontaktKor, mesto : mesto },function(response){
                            console.log("Response from server: " + response);
                            if(response==" Uspesno"){
                                alert("Uspesno ste dodali korisnika")
                            }
                            else{
                                alert("Greska");
                            }
                        })
                    }else{
                        alert("Niste uneli dobro JBMG")
                    }
                }
                else{
                    alert("Nise dobro uneli broj")
                }
            }else{
                alert("Niste mail ispravno ukucali");
            }
        }else{
            alert("Svi podaci moraju biti uneti");
        }
        })
    })
</script>
</html>
