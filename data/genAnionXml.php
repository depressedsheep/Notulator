<?php

//Read the file into an array
$lines = file('rawAnion.txt', FILE_IGNORE_NEW_LINES);
$data = array();

//Iterate through lines
for( $i=0; $i<count($lines); $i++ ){
	$currentLine = $lines[$i];

	//Get name of cation
	$tmp = explode("\t", $currentLine);
	$name = $tmp[0];

	//Get chemical formula of cation
	$tmp = explode(" ", $tmp[1]);
	$formula = $tmp[0];

	//Get charge of cation
	if($tmp[1][0] == "-") $charge = "1";
	else $charge = $tmp[1][0];

	$data[$i] = array($name,$formula,$charge);
}

//Generate the XML file
$anions = new SimpleXmlElement('<anions/>');

//Iterate data array
for( $i=0; $i<count($data); $i++){
	$anion = $anions->addChild('anion');

	$anion->addChild('name', $data[$i][0]);
	$anion->addChild('formula', $data[$i][1]);
	$anion->addChild('charge', $data[$i][2]);
}


//Print the XML file
Header('Content-type: text/xml');
echo $anions->asXML();
