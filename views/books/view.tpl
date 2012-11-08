{*
** book view template
*}


{assign_associative var="params" inline="false" media="all"}
{$html->css("ui.datepicker", null, $params)}

{$javascript->link("jquery/jquery.form", false)}
{$javascript->link("jquery/jquery.selectboxes.pack", false)}
{$javascript->link("jquery/ui/jquery.ui.sortable", true)}
{$javascript->link("jquery/ui/jquery.ui.datepicker", false)}
{if $currLang != "eng"}
{$javascript->link("jquery/ui/i18n/jquery.ui.datepicker-$currLang.js", false)}
{/if}
{$javascript->link("jquery/jquery.autocomplete", false)}

<script type="text/javascript">
	{literal}
	$(document).ready( function (){

		openAtStart("#bookdetails,#properties");
		$('textarea.autogrowarea').css("line-height", "1.2em").autogrow();
				
	});
	{/literal}
</script>

{assign_associative var="params" currObjectTypeId=$conf->objectTypes.book.id}
{$view->element('form_common_js', $params)}

{$view->element('modulesmenu')}

{$view->element('menuleft')}

<div class="head">

	<h1>{if !empty($object)}{$object.title|default:"<i>[no title]</i>"}{else}<i>[{t}New item{/t}]</i>{/if}</h1>

</div>

{assign var=objIndex value=0}

{assign_associative var="params" fixed="true"}
{$view->element('menucommands',$params)}

<div class="main">	

	{$view->element('form')}

</div>

{$view->element('menuright')}