<?php 
/* SVN FILE: $Id$ */
/* BeditaApp schema generated on: 2010-03-24 17:03:57 : 1269448617*/
class BeditaAppSchema extends CakeSchema {
	var $name = 'BeditaApp';

	function before($event = array()) {
		return true;
	}

	function after($event = array()) {
	}

	var $books = array(
		'id' => array('type' => 'integer', 'null' => false, 'default' => NULL, 'length' => 10, 'values' => NULL, 'key' => 'primary'),
		'isbn' => array('type' => 'string', 'null' => true, 'default' => NULL, 'length' => 13, 'values' => NULL),
		'year' => array('type' => 'integer', 'null' => true, 'default' => NULL, 'length' => 4, 'values' => NULL),
		'series' => array('type' => 'string', 'null' => true, 'default' => NULL, 'values' => NULL),
		'location' => array('type' => 'string', 'null' => true, 'default' => NULL, 'values' => NULL),
		'indexes' => array('PRIMARY' => array('column' => 'id', 'unique' => 1))
	);
}
?>