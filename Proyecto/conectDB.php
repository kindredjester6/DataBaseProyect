<?php

$serverName = "LAPTOP-SJR955OH";  
$connectionInfo = array( "Database"=>"warehouse");
//$connectionInfo = array( "Database"=>"warehouse", "UID"=>"unknown", "PWD"=>"y34[f4^M");
$con = sqlsrv_connect( $serverName, $connectionInfo);

if( $con ) {
     echo "Conexión establecida.<br />";
}else{
     echo "Conexión no se pudo establecer.<br />";
     die( print_r( sqlsrv_errors(), true));
}
?>