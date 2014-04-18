<?php
/*=======================

To create Cation table:
CREATE TABLE IF NOT EXISTS `notulator_derp`.`cations` (
  `cation_id` INT NOT NULL AUTO_INCREMENT,
  `cation_name` VARCHAR(45) NULL,
  `cation_formula` VARCHAR(45) NULL,
  `cation_charge` TINYINT NULL,
  PRIMARY KEY (`cation_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci

========================*/

include __DIR__ . "/../connectDb.php";

$fileName = "cation.txt";
$lines = file($fileName, FILE_IGNORE_NEW_LINES);

$insert = array();
for( $i=0; $i<count($lines); $i++ ){
	$lineText = $lines[$i];

	$tmp = explode("\t", $lineText);
	$name = $tmp[0];

	$tmp = explode(" ", $tmp[1]);
	$formula = $tmp[0];
	if($tmp[1][0] == "+")
		$charge = "1";
	else
		$charge = $tmp[1][0]; //Gets first character of string

	$insert[$i] = array($name,$formula,$charge);
}

$sql = "INSERT INTO cations(cation_id, cation_name, cation_formula, cation_charge) VALUES";
for( $i=0; $i<count($insert); $i++ ){
	$name = str_replace("(", "\(", $insert[$i][0] );
	$name = str_replace(")", "\)", $name );
	$formula = $insert[$i][1];
	$charge = $insert[$i][2];

	$sql .= "('', '$name', '$formula', $charge)";
	if( $i != count($insert)-1 ) $sql .= ",";
}

echo $sql;

if( !$result = $dbLink->query($sql) )
    die('<br><br>There was an error running the query [' . $dbLink->error . ']');
else	
	echo "<br><hr><br><h1>Success</h1>";