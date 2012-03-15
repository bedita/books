{*
** books form template
*}

<form action="{$html->url('/books/save')}" method="post" name="updateForm" id="updateForm" class="cmxform">
<input type="hidden" name="data[id]" value="{$object.id|default:''}"/>

	{$view->element('form_book_detail')}

	{assign_associative var="params" comments='true'}
	{$view->element('form_properties',$params)}

	{$view->element('form_tree')}
	
	{assign_associative var="params" containerId='multimediaContainer' collection="true" relation='attach' title='Multimedia'}
	{$view->element('form_file_list', $params)}

	{$view->element('form_tags')}
	
	{$view->element('form_links')}
		
	{$view->element('form_translations')}
	
	{assign_associative var="params" object_type_id=$conf->objectTypes.book.id}
	{$view->element('form_assoc_objects', $params)}

	{assign_associative var="params" el=$object}
	{$view->element('form_advanced_properties',$params)}
	
	{$view->element("form_custom_properties")}
		

</form>

{$view->element('form_print')}