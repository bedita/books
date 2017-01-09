{*
** books form template
*}

<form action="{$html->url('/books/save')}" method="post" name="updateForm" id="updateForm" class="cmxform">
{$beForm->csrf()}
<input type="hidden" name="data[id]" value="{$object.id|default:''}"/>

	{$view->element('form_book_detail')}

	{$view->element('form_properties', ['comments' => true])}

	{$view->element('form_categories')}

	{$view->element('form_tree')}
	
	{if strnatcmp($conf->majorVersion, '3.3') <= 0}
		{$view->element('form_file_list', ['containerId' => 'multimediaContainer', 'collection' => true, 'relation' => 'attach', 'title' => 'Multimedia'])}
	{/if}

	{$view->element('form_tags')}
	
	{$view->element('form_links')}
		
	{$view->element('form_translations')}
	
	{$view->element('form_assoc_objects', ['object_type_id' => $conf->objectTypes.book.id])}

	{$view->element('form_advanced_properties', ['el' => $object])}
	
	{$view->element("form_custom_properties")}
	
	{$view->element('form_permissions', ['el' => $object])}
</form>

{$view->element('form_print')}