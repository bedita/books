{if strnatcmp($conf->majorVersion, '3.3') <= 0}
    {$javascript->link('jquery/jquery.changealert', false)}
{else}
    {$html->script('libs/jquery/jquery-migrate-1.2.1', false)} {* Assure JS compatibility *}
{/if}

{* Top menu *}
{$view->element('modulesmenu')}

{* Left menu *}
{$view->element('menuleft', ['method' => 'categories'])}

{* Title *}
<div class="head">
    <h1>{t}Categories{/t}</h1>
</div>

{* Commands menu *}
{$view->element('menucommands', ['method' => 'categories'])}

<div class="main">
    {* Categories' list *}
    {$view->element('list_categories')}
</div>
