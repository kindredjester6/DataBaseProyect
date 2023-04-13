<?php

$serverName = "database-1.c0dtmimmbhm5.us-east-1.rds.amazonaws.com";  //no olvidar el nombre del servidor 
//$connectionInfo = array( "Database"=>"warehouse");
$connectionInfo = array( "Database"=>"warehouse", "UID"=>"admin", "PWD"=>"473YYJHP");
$con = sqlsrv_connect( $serverName, $connectionInfo);

if( $con ) {
     echo "Conexión establecida.<br />";
}else{
     echo "Conexión no se pudo establecer.<br />";
     die( print_r( sqlsrv_errors(), true));
}
?>