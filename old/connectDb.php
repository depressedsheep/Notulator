<?php

include __DIR__ . "/config.php";

$dbLink = new mysqli(HOST, USER, PWD, $GLOBALS['database']);

if($dbLink->connect_errno > 0)
    //die('Unable to connect to database [' . $dbLink->connect_error . ']');
    die("false");