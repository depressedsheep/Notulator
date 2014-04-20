<?php

//Read the file into an array
$lines = file('rawCation.txt', FILE_IGNORE_NEW_LINES);

for( $i=0; $i<count($lines); $i++ ){
	$tmp = explode("\t", $lines[$i]);
	$tmp = explode(" ", $tmp[1]);
	echo "'" . $tmp[0]."',";
}