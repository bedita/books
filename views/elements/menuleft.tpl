{*
Template incluso.
Menu a SX valido per tutte le pagine del controller.
*}
<div class="primacolonna">

		<div class="modules"><label class="bedita" rel="{$html->url('/')}">{$conf->projectName|default:$conf->userVersion}</label></div>

		{* Actions menu *}
		{$actions = ['index' => $currentModule.label, 'categories' => 'Categories']}
		<ul class="menuleft insidecol">
			{foreach $actions as $action => $label}
			<li {if $method == $action}class="on"{/if}>
				{$tr->link($label, $html->url(['controller' => $moduleName, 'action' => $action]))}
			</li>
			{/foreach}
		</ul>
	
		<ul class="menuleft insidecol">

		{if $module_modify eq '1'}

			<li><a href="{$html->url('/books/view')}">{t}New Book{/t}</a></li>

		{/if}

		</ul>

{$view->element('export')}

{if (!empty($view->action)) && $view->action eq "index"}

		<div class="insidecol publishingtree">
			
			{$view->element('tree')}
		
		</div>

{/if}


{$view->element('user_module_perms')}

</div>