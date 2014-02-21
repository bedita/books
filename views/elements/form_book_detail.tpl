{* title and description *}

{$view->element('texteditor')}

<div class="tab"><h2>{t}Book details{/t}</h2></div>

<fieldset id="bookdetails">

<input type="hidden" name="data[weight_unit]" value="gr"/>
<input type="hidden" name="data[length_unit]" value="cm"/>
<input type="hidden" name="data[volume_unit]" value="cm3"/>

<table>
	<tr>
		<td>
			<label>{t}title{/t}:</label><br />
			<input id="titleBEObject" style="width:480px;" type="text" name="data[title]" value="{$object.title|escape:'html'|escape:'quotes'}" />
		</td>
		<td rowspan="3">
		{if !empty($attach[0])}	
			{assign_associative var="params" width=130 height=170 longside=false mode="crop"}
			{$beEmbedMedia->object($attach[0],$params)}
		{/if}
		</td>
	</tr>
	<tr>
		<td>
			<label>{t}subtitle{/t}:</label><br />
			<textarea style="width:480px; height:30px" class="shortdesc" name="data[description]">{$object.description|default:''|escape:'html'}</textarea>
		</td>
	</tr>
	<tr>
		<td><label>{t}abstract{/t}:</label></td>
	</tr>
	<tr>
		<td colspan=2>
			<textarea name="data[abstract]" class="richtextMini">{$object.abstract|default:''}</textarea>
		</td>
	</tr>
</table>

<hr />

<table class="booksauthor" border=0 style="width:100%;">

<tr>
	<th>{t}creator{/t}:</th>
	<td>
		<input type="text" style="width:380px" name="data[creator]" value="{$object.creator|default:''|escape:'html'|escape:'quotes'}" />
	</td>
	
</tr>
{*  bedev}
<tr>
	<td></td><td style="padding:0px 0px 0px 10px">{t}name and surname{/t}</td><td style="padding:0px 0px 0px 10px">{t}role{/t}</td>
</tr>
{if !empty($relObjects.author)}
{foreach from=$relObjects.author name=i item=author}
<input type="hidden" name="data[RelatedObject][author][{$author.id}][id]" value="{$author.id}"/>
<input type="hidden" name="data[RelatedObject][author][{$author.id}][priority]" value="{$author.priority}"/>
	<tr>
		<th style="width:20px">{t}author{/t}{$smarty.foreach.i.iteration}:</th>
		<td>
			<input style="width:100px" type="text" value="{$author.name}" />
			<input style="width:100px" type="text" value="{$author.name}" />
		</td>
		<td>	
			<select style="width:60px" class="authorrole" >
				<option>{t}author{/t}</option>
				<option>{t}editor{/t}</option>
				<option>{t}illustrator{/t}</option>
				<option>{t}translator{/t}</option>
				<option>{t}speaker{/t}</option>
			</select>
		</td>
		<td nowrap>
			<input type="button" title="{t}remove item{/t}" style="width:25px" value="-" />	
		</td>
	</tr>
{/foreach}
{/if}

<!-- http://memory.loc.gov/cocoon/loc.terms/relators/dc-relators.html -->

<input type="hidden" name="data[RelatedObject][author][0][switch]" value="author"/>
	<tr>
		<th nowrap style="width:20px">{t}author{/t}{$smarty.foreach.i.iteration+1|default:1}:</th>
		<td nowrap>
			<input type="text" style="width:100px" name="data[author]" id="authorBEObject" />
			<input type="text" style="width:120px" name="data[author]" id="authorBEObject" />	
		</td>
		<td>
			<select style="width:60px" name="data[authorrole]" class="authorrole" >
				<option>{t}author{/t}</option>
				<option>{t}editor{/t}</option>
				<option>{t}illustrator{/t}</option>
				<option>{t}translator{/t}</option>
				<option>{t}speaker{/t}</option>
			</select>
		</td>
		<td nowrap>
			{assign var=rel value='author'}
			<input type="button" class="modalbutton" title="{$rel|upper} : {t}select from author repository{/t}"
				rel="{$html->url('/pages/showObjects/')}{$object.id|default:0}/{$rel}/"  
				value="{t}get from list{/t}" />
			<input type="button" title="{t}add item{/t}" style="width:25px" value="+" />	
		</td>
	</tr>

{/bedev*}
</table>


<hr />

<table>
	<tr>
		<th>{t}publisher{/t}:</th>
		<td><input type="text" name="data[publisher]" value="{$object.publisher|default:''}" /></td>
		<th>{t}place{/t}:</th>
		<td><input type="text" name="data[production_place]" value="{$object.production_place|default:''}"/></td>
		<th>{t}year{/t}:</th>
		<td><input type="text" style="width:38px" name="data[year]" value="{$object.year|default:''}" size="4" maxlength="4" /></td>
	</tr>
	<tr>
		<th>{t}series{/t}:</th>
		<td><input type="text" name="data[series]" value="{$object.series|default:''}"/></td>
		<th>{t}language{/t}:</th>
		<td>
		{assign var=object_lang value=$object.lang|default:$conf->defaultLang}
		<select name="data[lang]" id="main_lang">
			{foreach key=val item=label from=$conf->langOptions name=langfe}
			<option {if $val==$object_lang}selected="selected"{/if} value="{$val}">{$label}</option>
			{/foreach}
			{foreach key=val item=label from=$conf->langsIso name=langfe}
			<option {if $val==$object_lang}selected="selected"{/if} value="{$val}">{$label}</option>
			{/foreach}
		</select>
		</td>	
	</tr>
	<tr>
		<th>{t}isbn/issn{/t}:</th>
		<td colspan=3><input type="text" style="width:100%" name="data[isbn]" value="{$object.isbn|default:''}" /></td>
		
		
	</tr>
</table>
</fieldset>

<div class="tab"><h2>{t}More data{/t}</h2></div>

<fieldset id="moredata">

<table>
	<tr>
		<th>{t}serial number{/t}:</th>
		<td colspan="2"><input type="text" name="data[serial_number]" value="{$object.serial_number|default:''}"/></td>
	</tr>
	<tr>
		<th>{t}location code{/t}:</th>
		<td colspan="2"><input type="text" name="data[location]" value="{$object.location|default:''}"/></td>
	</tr>
	<tr>
		<th>{t}width{/t}:</th>
		<td><input type="text" style="width:30px" name="data[width]" value="{$object.width|default:''}"/> cm</td>
		<th>{t}height{/t}:</th>
		<td><input type="text" style="width:30px" name="data[height]" value="{$object.height|default:''}"/> cm</td>
	</tr>
	<tr>
		<th>{t}depth{/t}:</th>
		<td><input type="text" style="width:30px" name="data[product_depth]" value="{$object.product_depth|default:''}"/> cm</td>
		<th>{t}weight{/t}:</th>
		<td><input type="text" style="width:30px" name="data[weight]" value="{$object.weight|default:''}"/> gr</td>
	</tr>
</table>



</fieldset>
