{if strnatcmp($conf->majorVersion, '3.3') > 0}
    {$html->script('libs/jquery/jquery-migrate-1.2.1', false)} {* assure js retrocompatibility *}
{/if}

{$view->element('modulesmenu')}

{$view->element("menuleft")}

{$view->element("menucommands")}

{$view->element("toolbar")}

<div class="mainfull">

	{assign_associative var="params" method="index"}
	{$view->element("list_objects",$params)}

</div>