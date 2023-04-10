<!DOCTYPE html>
<html lang="en">
<?php include("conectDB.php"); ?>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="styleS.css" rel="stylesheet" media="all" />
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <title>Inicio de sesión</title>
</head>
<body>
    <div id = fondo>
        <div id = margen>

            <label id="Tope">SIGN IN</label>
            <form method="POST">
                <div class="form-floating"id = "Info">
                    
                    <input ID="floatingUser" type = "user" name="user" class="form-control" placeholder="Usuario">
                    <label for='floatingUser' id="User">Usuario</label>

                </div>

                <div class="form-floating">
                    <input ID="floatingPass" type = "password" name="pass" class="form-control" placeholder="Contraseña">
                    <label for='floatingPass' id="Pass">Password</label>
                </div>

                <div ID="botones">
                    <input type= "submit" name="Iniciar"ID= "botonI" value = "Insertar" class = "btn btn-primary"> <!-- <input type = "submit" name="insertC" class="btn btn-warning" value = "Filtrar por cantidad"> -->
            </form>
            
            <form action=".php">
                <Input type= "submit" ID= "botonC" value = "Cerrar" class = "btn btn-danger">
            </form>
            </div>  

        </div>

    </div> 

    <?php 
    if(isset($_POST['Iniciar'])){
        $user=$_POST['user'];
        $pass=$_POST['pass'];
        echo $user;
        echo $pass;

        $ip=gethostbyname('');

        echo "The user's IPv4 address is - ".$ip;
        $ip= gethostbyname('');
        $sql = "
        declare @val int;
        set @val = 0;
        exec spValUsuario '$user','$pass','$ip',@val output;
        select @val as validacion;
        ";
                
        $stmt = sqlsrv_query($con, $sql);
        
        $list = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);

        if($list['validacion'] == 1){
            header("Location: http://localhost/Proyecto/lista.php");
            die();
        }
        elseif($list['validacion'] == 2){
            echo '<h3>Usuario o contraseña no coinciden</h3>';   
        } 

        sqlsrv_free_stmt( $stmt); 
        sqlsrv_close( $con );
        }
    
    ?>

</body>
</html>