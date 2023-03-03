<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="style.css" rel="stylesheet" media="all" />
    <title>Document</title>
</head>
<body>

<h1 ID = "titulo"> Lista de articulos </h1>
<?php 
$serverName = "proyectbdtest.database.windows.net, 1433";  
$connectionInfo = array( "Database"=>"warehouse", "UID"=>"unknown", "PWD"=>"y34[f4^M");
$conn = sqlsrv_connect( $serverName, $connectionInfo);

/*
if( $conn ) {
     echo "Conexión establecida.<br />";
}else{
     echo "Conexión no se pudo establecer.<br />";
     die( print_r( sqlsrv_errors(), true));
}
*/

$table = '
   <table ID = "tabla" border=1>
                    <tr class="Tope">
                         <th> ID </th>
                         <th>Nombre</th>
                         <th>Precio</th>
                    </tr>
  ';

$sql = "SELECT TOP (1000) *
  FROM [dbo].[Articulo]";
$stmt = sqlsrv_query( $conn, $sql );

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

<?php
sqlsrv_free_stmt( $stmt);
sqlsrv_close( $conn );
?>

<div id="posBoton">
    <div ID="botones">
        <button ID= "botonI" onclick="alert('You pressed the button!')">Insertar</button>
        <button ID= "botonC">Cerrar</button>
    </div>
</div>
</body>
</html>

