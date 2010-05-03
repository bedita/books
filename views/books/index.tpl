{$view->element('modulesmenu')}

{$view->element("menuleft")}

{$view->element("menucommands")}

{$view->element("toolbar")}

<div class="mainfull">

	{assign_associative var="params" method="index"}
	{$view->element("list_objects",$params)}

</div>