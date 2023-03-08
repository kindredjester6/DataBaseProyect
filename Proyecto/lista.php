<!DOCTYPE html>
<html lang="en">

<?php include("conectDB.php"); ?>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="styleL.css" rel="stylesheet" media="all" />
    <title>Document</title>
</head>
<body>
    <h1 ID = "titulo"> Lista de articulos </h1>
    <?php 

    $table = '
    <table ID = "tabla" border=1>
                        <tr class="Tope">
                            <th> ID </th>
                            <th>Nombre</th>
                            <th>Precio</th>
                        </tr>
    ';

    $sql = "EXEC dbo.ordenAlfabetico";
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
            <td>'.$row["Precio"].'</td>
        </tr>
    ';

    }
    ?>
    <?php $table .= '</table>'; ?>

    <div class="posicion">
        <div class = "tablaColor">
            <?php echo $table; ?>
        </div>
    </div>


    <?php sqlsrv_free_stmt( $stmt); ?>

    <?php sqlsrv_close( $con ); ?> 

    <div id="posBoton">

        <div ID="botones">
            <form action="index.php">
                <button ID= "botonI">Insertar</button>
            </form>
            
            <Input class="Close"ID= "botonC" type = "button" value = "Cerrar" onclick=''>
        </div>

    </div>


</body>
</html>