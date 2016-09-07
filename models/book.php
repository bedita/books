<?php
/*-----8<--------------------------------------------------------------------
 * 
 * BEdita - a semantic content management framework
 * 
 * Copyright 2008 ChannelWeb Srl, Chialab Srl
 * 
 * This file is part of BEdita: you can redistribute it and/or modify
 * it under the terms of the Affero GNU General Public License as published 
 * by the Free Software Foundation, either version 3 of the License, or 
 * (at your option) any later version.
 * BEdita is distributed WITHOUT ANY WARRANTY; without even the implied 
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the Affero GNU General Public License for more details.
 * You should have received a copy of the Affero GNU General Public License 
 * version 3 along with BEdita (see LICENSE.AGPL).
 * If not, see <http://gnu.org/licenses/agpl-3.0.html>.
 * 
 *------------------------------------------------------------------->8-----
 */

/**
 * Book product
 *
 * @version			$Revision: 2510 $
 * @modifiedby 		$LastChangedBy: bato $
 * @lastmodified	$LastChangedDate: 2009-12-17 13:36:03 +0100 (gio, 17 dic 2009) $
 * 
 * $Id: book.php 2510 2009-12-17 12:36:03Z bato $
 */
class Book extends BeditaProductModel
{
	var $actsAs = array();
	public $objectTypeId = 20;
	public $searchFields = array("title" => 10 , "creator" => 6, "description" => 6, 
		"subject" => 4, "abstract" => 4, "isbn" => 10, "publisher" => 4);	
	
	public $objectTypesGroups = array("leafs", "related");
	
	public function beforeValidate() {
		$this->checkNumber('year');
		$this->checkNumber('quantity');
		$this->formatPrice('price');
		$this->formatPrice('digital_price');
		return true;
	}

	protected function formatPrice($field){
		$locale = setlocale(LC_ALL, 0);
        $data = &$this->data[$this->name];
        if (substr($locale, 0, 5) === 'it_IT') {
            $locale_info = localeconv();
            $curr = $locale_info['int_curr_symbol'];
            $formatter = new NumberFormatter($locale, NumberFormatter::CURRENCY);
            $price = $data[$field] . "\xc2\xa0" . '€';
            $data[$field] = $formatter->parseCurrency($price, $curr);
        } else {
            $data[$field] = str_replace(',', '', $data[$field]);
        }
	}
}

