<?php

$metals = file('metals.txt', FILE_IGNORE_NEW_LINES);
$xml = file_get_contents('PeriodicTableMain.xml');
$sXML = new SimpleXMLElement($xml);

for( $i=0;$i<count($metals);$i++ ){
	$close = $sXML->xpath('//element[name="'.$metals[$i].'"]/number/text()');
	echo reset($close).',';
}
