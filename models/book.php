<?php
/*-----8<--------------------------------------------------------------------
 * 
 * BEdita - a semantic content management framework
 * 
 * Copyright 2008-2016 ChannelWeb Srl, Chialab Srl
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
 * The Book as a product 
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
		$this->parsePrice('price');
		$this->parsePrice('digital_price');
		return true;
	}

    /**
     * NumberFormatter::CURRENCY and TYPE_CURRENCY suck - you have to include currency symbol
     * This is a locale independent "horrible" parser for most commont display formats:
     *   #,###.## -  #.###,## - # ###.##
     */
    protected function parsePrice($field){
        $data = &$this->data[$this->name];
        if (!empty($data[$field])) {
            $value = str_replace(',', '.', $data[$field]);
            $value = str_replace(' ', '', $value);
            $parts = explode('.', $value);
            $numParts = count($parts); 
            if ($numParts > 1) {
                $last = array_pop($parts);
                $value = implode('', $parts);
                $value .= (strlen($last) > 2 ? '' : '.') . $last;
            }
            $data[$field] = floatval($value);
        }
    }
}

