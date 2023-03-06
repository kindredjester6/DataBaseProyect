<!DOCTYPE html>
<?php
    include("index.php");
?>

<meta charset="UTF-8">
<html>
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale-1">

    <title>Lista de artículos</title>
    <!--Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    </head>
<body>
    <div class = "col-md-8 col-md-offset-2">
        <h1>Agregar artículo</h1>

        <form method = "POST" action = "Lista.php">
            <div class="form-group">
                <label>Nombre:</label>
                <input type = "text" name="nombre" class="form-control" placeholder="Escriba el nombre"><br />
            </div>
            <div class="form-group">
                <label>Precio:</label>
                <input type = "text" name="precio" class="form-control" placeholder="Escriba el precio">
            </div>
            <div class="form-group">
                <input type = "submit" name="insert" class="btn btn-warning" value = "Insertar"><br />
            </div>
            <div class="form-group">
                <input type = "submit" name="close" class="btn btn-warning" value = "Cerrar"><br />
            </div>
        </form>
    </div>
<br /><br /><br />
    <?php
        if(isset($_POST['insert'])){
            $nombre=$_POST['nombre'];
            $precio=$_POST['precio'];

            if(empty(trim($nombre))){
                echo "<h3>El nombre del producto no puede estar vacío.</h3>";
            } elseif(empty(trim($precio))){
                echo "<h3>El precio del producto no puede estar vacío.</h3>";
            } else {
                $insertar = "INSERT INTO Articulo(nombre, precio) VALUES ('$nombre', '$precio')";
                $ejecutar = sqlsrv_query($con, $insertar);
                if($ejecutar){
                    echo "<h3>Insertado correctamente</h3>";
                }
            }
            /*
            $insertar = "INSERT INTO Articulo(nombre, precio)VALUES('$nombre', '$precio')";

            $ejecutar = sqlsrv_query($con, $insertar);

            if($ejecutar){
                echo "<h3>Insertado correctamente </h3>";
            }
            */
        }
        if(isset($_POST['close'])){
            echo "<h3>Cerrando </h3>";
            include ('ConBD.php');
        }
    ?>
</body>
</html>
