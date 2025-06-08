<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="zaposlenL.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    <script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body><div class="container">
    <h1 class="col col-lg-12 mx-auto text-center">Dobrodosli</h1>
        <form action="funkcije.php" method="POST" class="col col-lg-8 mx-auto text-center">
            <label for="">Unesite Vase Korisnicko ime</label>
            <input type="text" id="korImeZ" class="form-control">
            <label for="">Unesite Vasu Lozinku</label>
            <input type="password" id="korPassZ" class="form-control">
            <input type="button" class="dugme btn-success" value="Uloguj se" id="dugme">
        </form> 
        
        
    </div>
    <script>
    $(document).ready(function(){
        $("#dugme").click(function(){
            let korImeZ = $("#korImeZ").val();
            let korPassZ = $("#korPassZ").val();
            $.post("funkcije.php", { korImeZ: korImeZ, korPassZ: korPassZ }, function(response){
                if(response ==" Da") {
                    window.location.assign("zaposlenH.php")
                } else {
                    alert("Niste lepo uneli podatke");
                }
            });
        });
    });
</script>
</body>
</html>


1506989707714