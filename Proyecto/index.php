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
    <div id = formulario>
            <div class = "col-md-8 col-md-offset-2"> 
                <form  method = "POST" action = "index.php">

                <h1>Agregar artículo</h1>
                    <div class="form-group">
                        <label>Nombre:</label>
                        <input ID="input1" type = "text" name="nombre" class="form-control" placeholder="Escriba el nombre"> <br />
                    </div>
                    <!-- Inicio de Caja de selección -->

                    <div class="control-group">
                        <label id='LabelCaja' class="control-label">Clase</label>
                            <div class="controls">
                                <select name = 'Sbox' id="SB" class="form-select"> 
                                    <option value=0 class="input-xlarge">Seleccionar clase</option>
                                    <option value="1">Ebanisteria</option>
                                    <option value="2">Electrico</option>
                                    <option value="3">Plomeria</option>
                                </select> <br />
                            </div>
                    </div>

                    <!-- Fin de Caja de selección -->
                    <div class="form-group">
                        <label>Precio:</label>
                        <input ID="input3" type = "text" name="precio" class="form-control" placeholder="Escriba el precio"> <br />
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
    </div>
    <?php
        if(isset($_POST['insert'])){
            $nombre=$_POST['nombre'];
            $precio=$_POST['precio'];
            $Sbox = $_POST['Sbox'];
            $idUser=1;
            if (($precio=='')||(preg_match('/^[\pL\s]*$/u', $precio))){$precio = -1;} 

            if ((int)$precio >= 0){
                $ip= gethostbyname('');
                $sql = "
                declare @val int;
                set @val = 0;
                exec @val =  psInsertarArticulo '$nombre',".$Sbox.",".$precio.",".$idUser.",'$ip',@val output;
                select @val as validacion;
                ";
                
                $stmt = sqlsrv_query($con, $sql);

                $list = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC);

                $list['validacion'] ??= 2;
                
                if($list['validacion'] == 1){
                    echo "<h3>Favor digitar el nombre de un producto</h3>";
                }
                elseif($list['validacion'] == 2){
                    echo 'entró';
                    header("Location: http://localhost/Proyecto/lista.php");
                    die();
                }

                elseif($list['validacion'] == 3){
                    echo '<h3>Existe</h3>';

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