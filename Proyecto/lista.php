<!DOCTYPE html>
<html lang="en">

<?php include("conectDB.php"); ?>

<head id = 'encabezado'>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="styleL.css" rel="stylesheet" media="all" />
    <title>Document</title>
</head>
<body>
    <?php

//------------------------------------Inicio de Tabla de listar------------------------------
    $table = '
    <table ID = "tabla" border=1>
                        <tr class="Tope">
                            <th> Id </th>
                            <th> Nombre </th>
                            <th> Clase </th>
                            <th> Precio </th>
                        </tr>
    ';

    $sql = "EXEC dbo.spOrdenAlfabetico";
    $stmt = sqlsrv_query( $con, $sql );

    if( $stmt === false) {
        die( print_r( sqlsrv_errors(), true) );
    }
    ?>

    <?php 


    while( $row = sqlsrv_fetch_array( $stmt, SQLSRV_FETCH_ASSOC) ) {
        $table .= '
        <tr>
            <td>'.$row["Id"].'</td>            
            <td>'.$row["Nombre"].'</td>
            <td>'.$row["Clase"].'</td>
            <td>'.$row["Precio"].'</td>
        </tr>
    ';

    }
    ?>
    <?php $table .= '</table>'; ?>

    <div class="posicion">
        <div class = "tablaColor">
            <h1 ID = "titulo"> Lista de articulos </h1>
<!-- --------------------------------------Inicio de los inputs-text y botones-------------------------------------- -->

            <form  method = "POST" action = "lista.php">

                <div class="form-group">
                    <label id='LabelN' class="control-label">Nombre</label>
                    <div id = 'contentName'>
                        <input ID="InputN" type = "text" name="nombreA" class="form-control" placeholder="Escriba el nombre">
                        <input type = "submit" name="insertN" class="btn btn-info" value = "Filtrar por nombre">
                    </div>
                </div>

                <div class="form-group">
                    <label id='LabelC' class="control-label">Cantidad</label>
                    <div id = 'contentC'>
                        <input ID='InputC' type = "text" name="cantidad" class="form-control" placeholder="Digite la cantidad">
                        <input type = "submit" name="insertC" class="btn btn-info" value = "Filtrar por cantidad">
                    </div>
                </div>

                <div class="control-group">
                    <label id='LabelCaja' class="control-label">Clase</label>
                    <div class="controls">
                        <select name = 'Sbox' id="SB" class="form-select">
                            <option value="" class="input-xlarge">Seleccionar clase</option>
                            <option value="Ebanisteria">Ebanisteria</option>
                            <option value="Electrico">Electrico</option>
                            <option value="Plomeria">Plomeria</option>
                        </select>

                        <input type = "submit" name="insert" class="btn btn-info" value = "Filtrar por clase">
                    </div>
                </div>
            </form>
<!-- --------------------------------------Fin de los inputs-text y botones-------------------------------------- -->
                <?php

                if(isset($_POST['insert'])){
                        $nombre=$_POST['Sbox'];
                        echo $nombre;
                        //Inicia las instrucciones para que funcione el EXEC de SQL
                }

                if(isset($_POST['insertN'])){
                    $nombre=$_POST['nombreA'];
                    echo $nombre;
                    //Inicia las instrucciones para que funcione el EXEC de SQL
                }

                if(isset($_POST['insertC'])){
                    $nombre=$_POST['cantidad'];
                    echo $nombre;
                    //Inicia las instrucciones para que funcione el EXEC de SQL
                }  

                ?>
            <?php //?>
            <?php echo $table; ?>
        </div>
    </div>
    <?php sqlsrv_free_stmt($stmt); ?>

    <?php sqlsrv_close( $con ); ?> 

    <div id="posBoton">

        <div ID="botones">
            <form action="index.php">
                <input type= "submit" ID= "botonI" value = "Insertar" class = "btn btn-primary"> <!-- <input type = "submit" name="insertC" class="btn btn-warning" value = "Filtrar por cantidad"> -->
            </form>
            
            <form action="sesion.php">
                <Input type= "submit" ID= "botonC" value = "Cerrar" class = "btn btn-danger">
            </form>
        </div>

    </div>


</body>
</html>