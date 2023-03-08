<!DOCTYPE html>

<?php include("conectDB.php"); ?>

<meta charset="UTF-8">
<html>
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                    <input ID="input1" type = "text" name="nombre" class="form-control" placeholder="Escriba el nombre"><br />
                </div>
                <div class="form-group">
                    <label>Precio:</label>
                    <input ID="input2" type = "text" name="precio" class="form-control" placeholder="Escriba el precio">
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
        if (($precio=='')||(preg_match('/^[\pL\s]*$/u', $precio))){$precio = -1;} 
        if ((int)$precio >= 0){

            $sql = "
            exec psInsertarArticulo '$nombre',".$precio.";
            ";
            
            $stmt = sqlsrv_query($con, $sql);

            $list = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);


            if($list['validacion'] == 1){
                echo "<h3>Favor digitar el nombre del producto</h3>";
            }
            elseif($list['validacion'] == 2){
                echo '<script type="text/javascritp"> document.getElementById("input1").disabled=false; </script>';
                echo '<script type="text/javascritp"> document.getElementById("input2").disabled=false; </script>';
                echo '<form method = "GET" action = "lista.php">
                        <div class="forma">
                          <div class="modal-content">
                            <p>Inserción exitosa</p>
                            <button type="submit" id="disennoBtn">Ok</button>
                          </div>
                        </div>
                    </form>';
            }

            elseif($list['validacion'] == 3){
                echo '<h3>existe</h3>';

            } 

            sqlsrv_free_stmt( $stmt); 
            sqlsrv_close( $con );
            }
        else{
            echo "<h3>Favor digitar correctamente el precio del producto</h3>";
        }
        }
    ?>

</body>
</html>