<?php

$serverName = "proyectbdtest.database.windows.net";  //No olvidar el nombre del servidor 
//$connectionInfo = array( "Database"=>"warehouse");
$connectionInfo = array( "Database"=>"warehouse", "UID"=>"unknown", "PWD"=>"y34[f4^M");
$con = sqlsrv_connect( $serverName, $connectionInfo);

if( $con ) {
     echo "Conexión establecida.<br />";
}else{
     echo "Conexión no se pudo establecer.<br />";
     die( print_r( sqlsrv_errors(), true));
}
?>
