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
 * 
 *
 * @version			$Revision: 2712 $
 * @modifiedby 		$LastChangedBy: dante $
 * @lastmodified	$LastChangedDate: 2010-03-26 09:14:23 +0100 (ven, 26 mar 2010) $
 * 
 * $Id: books_controller.php 2712 2010-03-26 08:14:23Z dante $
 */
class BooksController extends ModulesController {

	var $name = 'Books';
	var $helpers 	= array('BeTree', 'BeToolbar');
	var $components = array('BeFileHandler', 'BeSecurity');
	var $uses = array('BEObject', 'Book', 'Tree', 'Category') ;
	protected $moduleName = 'books';

    /**
     * Models categorizable within this controller.
     *
     * @var array
     */
    protected $categorizableModels = array('Book');

    protected function beditaBeforeFilter() {
        BeLib::getObject('BeConfigure')->loadPluginLocalConfig($this->moduleName);
    }

    public function index($id = null, $order = "", $dir = true, $page = 1, $dim = 20) {
		$conf  = Configure::getInstance() ;
		$filter["object_type_id"] = $conf->objectTypes['book']["id"];
		$filter["count_annotation"] = array("Comment","EditorNote");
		$this->paginatedList($id, $filter, $order, $dir, $page, $dim);
	 }

	 public function view($id = null) {
		$this->viewObject($this->Book, $id);
	 }

	public function save() {
		$this->checkWriteModulePermission();
		$this->Transaction->begin();
		if(!empty($this->data['author'])) {
			$authorModel = ClassRegistry::init('Author');
			$authorData = array('title'=>$this->data['author'],'name'=>$this->data['author']);
			$authorModel->save($authorData);
			$authorId = $authorModel->getInsertID();
			$this->data['RelatedObject']['author'][$authorId] = array(
				'id' => $authorId,
				'priority' => 1
			);
		}
		$this->saveObject($this->Book);
	 	$this->Transaction->commit() ;
 		$this->userInfoMessage(__("Book saved", true)." - ".$this->data["title"]);
		$this->eventInfo("Book [". $this->data["title"]."] saved");
	 }

	public function delete() {
		$this->checkWriteModulePermission();
		$objectsListDeleted = $this->deleteObjects("Book");
		$this->userInfoMessage(__("Book deleted", true) . " -  " . $objectsListDeleted);
		$this->eventInfo("books $objectsListDeleted deleted");
	}

	public function deleteSelected() {
		$this->checkWriteModulePermission();
		$objectsListDeleted = $this->deleteObjects("Book");
		$this->userInfoMessage(__("Book deleted", true) . " -  " . $objectsListDeleted);
		$this->eventInfo("books $objectsListDeleted deleted");
	}

	public function listAllBooks($filters = null) {
		$this->layout = null;
		$this->render(null, null, VIEWS."books/inc/list_all_books.tpl");
	}

    /**
     * Shows Books categories.
     */
    public function categories() {
        $this->showCategories($this->Book);
    }

	protected function forward($action, $esito) {
		$REDIRECT = array(
			"cloneObject"	=> 	array(
							"OK"	=> "/books/view/{$this->Book->id}",
							"ERROR"	=> "/books/view/{$this->Book->id}" 
							),
			"save"	=> 	array(
							"OK"	=> "/books/view/{$this->Book->id}",
							"ERROR"	=> "/books/view/{$this->Book->id}" 
							), 
			"delete" =>	array(
							"OK"	=> $this->fullBaseUrl . $this->Session->read('backFromView'),
							"ERROR"	=> $this->referer() 
							), 
			"deleteSelected" =>	array(
							"OK"	=> $this->referer(),
							"ERROR"	=> $this->referer() 
							),
			"addItemsToAreaSection"	=> 	array(
							"OK"	=> $this->referer(),
							"ERROR"	=> $this->referer() 
							),
			"moveItemsToAreaSection"	=> 	array(
							"OK"	=> $this->referer(),
							"ERROR"	=> $this->referer() 
							),
			"removeItemsFromAreaSection"	=> 	array(
							"OK"	=> $this->referer(),
							"ERROR"	=> $this->referer() 
							),
			"changeStatusObjects"	=> 	array(
							"OK"	=> $this->referer(),
							"ERROR"	=> $this->referer() 
							)
		);
		if(isset($REDIRECT[$action][$esito])) return $REDIRECT[$action][$esito] ;
		return false ;
	}
}