<?php

$serverName = "proyectbdtest.database.windows.net, 1433";  
$connectionInfo = array( "Database"=>"warehouse", "UID"=>"unknown", "PWD"=>"y34[f4^M");
$con = sqlsrv_connect( $serverName, $connectionInfo);

if( $con ) {
     echo "Conexión establecida.<br />";
}else{
     echo "Conexión no se pudo establecer.<br />";
     die( print_r( sqlsrv_errors(), true));
}

//sqlsrv_close( $con );
?>