{*
** book view template
*}


{assign_associative var="params" inline="false" media="all"}
{$html->css("ui.datepicker", null, $params)}
{if strnatcmp($conf->majorVersion, '3.3') <= 0}
    {$javascript->link("jquery/jquery.form", false)}
    {$javascript->link("jquery/jquery.selectboxes.pack", false)}
    {$javascript->link("jquery/ui/jquery.ui.sortable", true)}
    {$javascript->link("jquery/ui/jquery.ui.datepicker", false)}
    {if $currLang != "eng"}
        {$javascript->link("jquery/ui/i18n/jquery.ui.datepicker-$currLang.js", false)}
    {/if}
    {$javascript->link("jquery/jquery.autocomplete", false)}
{else}
    {$html->script('libs/jquery/jquery-migrate-1.2.1', false)} {* assure js retrocompatibility *}
    {$html->script('libs/jquery/plugins/jquery.form', false)}
    {$html->script('libs/jquery/plugins/jquery.selectboxes.pack', false)}
    {$html->script('libs/jquery/ui/jquery.ui.sortable.min', true)}
    {$html->script('libs/jquery/ui/jquery.ui.datepicker.min', false)}
    {if $currLang != 'eng'}
         {$html->script("libs/jquery/ui/i18n/jquery.ui.datepicker-$currLang2.min.js", false)}
    {/if}
    {$html->script('libs/jquery/plugins/jquery.autocomplete', false)}
{/if}
<script type="text/javascript">
	{literal}
	$(document).ready( function () {

		openAtStart("#bookdetails,#properties");

        {/literal}
        {if strnatcmp($conf->majorVersion, '3.3') <= 0}
        {literal}
            $('textarea.autogrowarea').css("line-height", "1.2em").autogrow();
        {/literal}
		{else}
        {literal}
            $('textarea.autogrowarea').css("line-height", "1.2em").autosize();
        {/literal}
        {/if}
        {literal}
	});
	{/literal}
</script>

{assign_associative var="params" currObjectTypeId=$conf->objectTypes.book.id}
{$view->element('form_common_js', $params)}

{$view->element('modulesmenu')}

{$view->element('menuleft', ['method' => 'view'])}

<div class="head">

	<h1>{if !empty($object)}{$object.title|default:"<i>[no title]</i>"}{else}<i>[{t}New item{/t}]</i>{/if}</h1>

</div>

{assign var=objIndex value=0}

{$view->element('menucommands', ['method' => 'view', 'fixed' => true])}

<div class="main">	

	{$view->element('form')}

</div>

{$view->element('menuright')}