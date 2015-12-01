
<script type="text/javascript">
<!--
var message = "{t}Are you sure that you want to delete the item?{/t}" ;
var messageSelected = "{t}Are you sure that you want to delete selected items?{/t}" ;
var urls = Array();
urls['deleteSelected'] = "{$html->url('deleteSelected/')}";
urls['changestatusSelected'] = "{$html->url('changeStatusObjects/')}";
urls['copyItemsSelectedToAreaSection'] = "{$html->url('addItemsToAreaSection/')}";
urls['moveItemsSelectedToAreaSection'] = "{$html->url('moveItemsToAreaSection/')}";
urls['removeFromAreaSection'] = "{$html->url('removeItemsFromAreaSection/')}";

{literal}
$(document).ready(function(){

	$(".indexlist TD").not(".checklist").css("cursor","pointer").click(function(i) {
		document.location = $(this).parent().find("a:first").attr("href"); 
	} );

	$("#deleteSelected").bind("click", function() {
		if(!confirm(messageSelected)) 
			return false ;
		$("#formObject").attr("action", urls['deleteSelected']) ;
		$("#formObject").submit() ;
	});

	$("#assocObjects").click( function() {
		var op = ($('#areaSectionAssocOp').val()) ? $('#areaSectionAssocOp').val() : "copy";
		$("#formObject").attr("action", urls[op + 'ItemsSelectedToAreaSection']) ;
		$("#formObject").submit() ;
	});

	$(".opButton").click( function() {
		$("#formObject").attr("action",urls[this.id]) ;
		$("#formObject").submit() ;
	});
});
{/literal}

//-->
</script>	

	
<form method="post" action="" id="formObject">
{$beForm->csrf()}

	<input type="hidden" name="data[id]"/>

	<table class="indexlist">
	{capture name="theader"}
		<thead>
		<tr>
			<th></th>
			<th>{$beToolbar->order('id', 'id')}</th>
			<th>{$beToolbar->order('creator', 'author')}</th>
			<th>{$beToolbar->order('title', 'title')}</th>
			<th style="text-align:center">{$beToolbar->order('status', 'status')}</th>
			<th>{$beToolbar->order('modified', 'modified')}</th>
			<th style="text-align:center">
				{assign_associative var="htmlAttributes" alt="comments" border="0"} 
				{$beToolbar->order('num_of_comment', '', 'iconComments.gif', $htmlAttributes)}
			</th>			
			<th>{$beToolbar->order('lang', 'lang')}</th>
			<th>{$beToolbar->order('num_of_editor_note', 'notes')}</th>
		</tr>
		</thead>
	{/capture}
		
		{$smarty.capture.theader}
	
		{section name="i" loop=$objects}
		
		<tr class="obj {$objects[i].status}">
			<td class="checklist">
			{if !empty($objects[i].start_date) && ($objects[i].start_date|date_format:"%Y%m%d") > ($smarty.now|date_format:"%Y%m%d")}
			
				<img title="{t}object scheduled in the future{/t}" src="{$html->webroot}img/iconFuture.png" style="height:28px; vertical-align:middle;">
			
			{elseif !empty($objects[i].end_date) && ($objects[i].end_date|date_format:"%Y%m%d") < ($smarty.now|date_format:"%Y%m%d")}
			
				<img title="{t}object expired{/t}" src="{$html->webroot}img/iconPast.png" style="height:28px; vertical-align:middle;">
			
			{elseif (!empty($objects[i].start_date) && (($objects[i].start_date|date_format:"%Y%m%d") == ($smarty.now|date_format:"%Y%m%d"))) or ( !empty($objects[i].end_date) && (($objects[i].end_date|date_format:"%Y%m%d") == ($smarty.now|date_format:"%Y%m%d")))}
			
				<img title="{t}object scheduled today{/t}" src="{$html->webroot}img/iconToday.png" style="height:28px; vertical-align:middle;">

			{/if}
			
			{if !empty($objects[i].Permission)}
				<img title="{t}permissions set{/t}" src="{$html->webroot}img//iconLocked.png" style="height:28px; vertical-align:middle;">
			{/if}
			
			{if (empty($objects[i].fixed))}
				<input type="checkbox" name="objects_selected[]" class="objectCheck" title="{$objects[i].id}" value="{$objects[i].id}" />
			{/if}
			
			</td>
			
			<td>{$objects[i].id}</td>
			<td>{$objects[i].creator}</td>
			<td>
				<a href="{$html->url('view/')}{$objects[i].id}">{$objects[i].title|truncate:64|default:"<i>[no title]</i>"}</a>
			</td>

			<td style="text-align:center">{$objects[i].status}</td>
			<td>{$objects[i].modified|date_format:$conf->dateTimePattern}</td>
			<td style="text-align:center">{$objects[i].num_of_comment|default:0}</td>
			<td>{$objects[i].lang}</td>
			<td>{if $objects[i].num_of_editor_note|default:''}<img src="{$html->webroot}img/iconNotes.gif" alt="notes" />{/if}</td>
		</tr>
		
		
		
		{sectionelse}
		
			<tr><td colspan="100" style="padding:30px">{t}No {$moduleName} found{/t}</td></tr>
		
		{/section}
		
{if ($smarty.section.i.total) >= 10}
		
			{$smarty.capture.theader}
			
{/if}


</table>

<br />
	
{if !empty($objects)}

<div style="white-space:nowrap">
	
	{t}Go to page{/t}: {$beToolbar->changePageSelect('pagSelectBottom')} 
	&nbsp;&nbsp;&nbsp;
	{t}Dimensions{/t}: {$beToolbar->changeDimSelect('selectTop')} &nbsp;
	&nbsp;&nbsp;&nbsp
	<label for="selectAll"><input type="checkbox" class="selectAll" id="selectAll"/> {t}(un)select all{/t}</label>

	
</div>

<br />

<div class="tab"><h2>{t}Bulk actions on{/t}&nbsp;<span class="selecteditems evidence"></span> {t}selected records{/t}</h2></div>
<div>

{t}change status to{/t}: 	<select style="width:75px" id="newStatus" name="newStatus">
								<option value=""> -- </option>
								{html_options options=$conf->statusOptions}
							</select>
			<input id="changestatusSelected" type="button" value=" ok " class="opButton" />
	<hr />
	
	{if !empty($tree)}

		{assign var='named_arr' value=$view->params.named}
		{if empty($named_arr.id)}
			{t}copy{/t}
		{else}
			<select id="areaSectionAssocOp" name="areaSectionAssocOp" style="width:75px">
				<option value="copy"> {t}copy{/t} </option>
				<option value="move"> {t}move{/t} </option>
			</select>
		{/if}
		&nbsp;{t}to{/t}:  &nbsp;

		<select id="areaSectionAssoc" class="areaSectionAssociation" name="data[destination]">
		{$beTree->option($tree)}
		</select>

		<input type="hidden" name="data[source]" value="{$named_arr.id|default:''}" />
		<input id="assocObjects" type="button" value=" ok " />
		<hr />

		{if !empty($named_arr)}
		<input id="removeFromAreaSection" type="button" value="{t}Remove selected from section{/t}" class="opButton" />
		<hr/>
		{/if}
	{/if}

	
	<input id="deleteSelected" type="button" value="X {t}Delete selected items{/t}"/>
	
</div>

{/if}

</form>



<br />
<br />
<br />
<br />
	
	



