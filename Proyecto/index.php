<!DOCTYPE html>

<?php include("conectDB.php"); ?>

<meta charset="UTF-8">
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Lista de artículos</title>
    <!--Bootstrap core CSS -->
    <link href="styleI.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
<body>

    <h1>Agregar artículo</h1>
        <div class = "col-md-8 col-md-offset-2"> 
            <form  method = "POST" action = "index.php">

                <div class="form-group">
                    <label>Nombre:</label>
                    <input type = "text" name="nombre" class="form-control" placeholder="Escriba el nombre"><br />
                </div>
                <div class="form-group">
                    <label>Precio:</label>
                    <input type = "text" name="precio" class="form-control" placeholder="Escriba el precio">
                </div>
                <div class="form-groupBtn">
                    <input type = "submit" name="insert" class="btn btn-warning" value = "Insertar artículo"><br />

            </form>
                        <form method = "GET" action = "lista.php" >
                            <input type = "submit" name="Close" class="btn btn-warning" value = "Cerrar"><br />
                        </form>
                    </div>
                </div>
        </div>
<br /><br /><br />
    <?php
        if(isset($_POST['insert'])){
            $nombre=$_POST['nombre'];
            $precio=$_POST['precio'];

                $insertar = "DECLARE @isTrue INT;

                EXEC @isTrue = dbo.psInsertarArticulo  $nombre, $precio;
                
                select @isTrue;";

                $ejecutar = sqlsrv_query($con, $insertar);

                $name = sqlsrv_get_field( $ejecutar, 0);  

                echo '<h3>'.$name.'</h3>';  
                
                    if($ejecutar){
                    echo "<h3>Insertado correctamente</h3>";
                    }

                
                if($insertar == 1){
                    echo "<h3>Favor escribir el nombre del producto</h3>";
                }elseif($insertar == 2){
    
                }elseif($insertar == 3){
                    echo '<h3>existe</h3>';
                }

            }
        sqlsrv_close( $con );
    ?>

</body>
</html>
