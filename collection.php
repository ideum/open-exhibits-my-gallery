<?php 

if(isset($_GET['title']) && isset($_GET['total']) && isset($_GET['name']) && isset($_GET['file'])){
	$title = $_GET['title'];
	$name = $_GET['name'];
	$total = (int) $_GET['total'];
	$images = array();
	$file = $_GET['file'];
	
	//Save all the images passed in as an array of id's
	for($j = 1; $j <= $total; $j++){
		array_push($images, $_GET['image'.$j]);
	}
	
	//Create a new XML document
	$xdoc = new DomDocument("1.0", "UTF-8");
	//Format the output
	$xdoc-> formatOutput= TRUE;
	//Do not preserve white space
	$xdoc->preserveWhiteSpace = FALSE;
	//Load the old saved collecitons file
	$xdoc->Load($file, LIBXML_NOBLANKS);
	//Get the data for the previous collection
	$previousCollection = $xdoc->getElementsByTagName('collection');
	//Create a new collection
	$newCollection = $xdoc->createElement('collection');
	//Create the id attribute
	$newId = $xdoc->createAttribute('id');
	//Create the new id according to the lengt of the previous collection
	$newId->value = (string) ($previousCollection->length + 1);
	//Append the new id to the new collection
	$newCollection->appendChild($newId);
	//Create a new title element
	$newTitle = $xdoc->createElement('title', htmlspecialchars($title, ENT_QUOTES));
	//append the new title to the new collection
	$newCollection->appendChild($newTitle);
	//Create a new name element
	$newName = $xdoc->createElement('name', htmlspecialchars($name, ENT_QUOTES));
	//Append the name element to the new collection
	$newCollection->appendChild($newName);
	//Add all of the image elements from the previous saved array of image id's 
	for($i = 0; $i < $total; $i++){
		$newImage = $xdoc->createElement('image', $images[$i]);
		$newCollection->appendChild($newImage);
	}
	//Add the new collection to the old collection
	$xdoc->getElementsByTagName('personalCollections')->item(0)->appendChild($newCollection);
	
	//Save the changes to the file
	$xdoc->save($file);
	echo "true";
}


?>