<?php

include __DIR__ . "/connectDb.php";

if( isset($_POST['q']) )
	$SQL = $_POST['q'];
else
	$SQL = $_GET['q'];

if( !$result = $dbLink->query($SQL) )
    //die('There was an error running the query [' . $dbLink->error . ']');
	die("done=false");

//Query success, output result
echo "done=";
$row = $result->fetch_array(MYSQLI_NUM);
echo $row[0];

//Housekeeping
$result->free();
$dbLink->close();

?>