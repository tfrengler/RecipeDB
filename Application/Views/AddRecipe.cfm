<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<section>
	<h1 id="AddRecipe-Welcome" class="olive-text-color-center" >Add new recipe</h1>	
</section>

<br/>

<section>
	<form id="AddRecipe-Form" class="olive-wrapper-grey-background standard-rounded-corners col-lg-2 col-lg-offset-5" >

		<input id="AddNewRecipe-Anyway" type="hidden" value="0" >

		<input id="AddRecipe-Name" class="form-control" type="text" value="" placeholder="name" maxlength="100" />
		<!--- <input id="DuplicateCheck" type="checkbox" /><span> Warn me about potential duplicate recipes</span> --->

		<br/>

		<input id="AddNewRecipe-Button" type="button" value="OK" class="standard-button btn-block center-block" />

	</form>
</section>

<br/>

<section>
	<div id="AddRecipe-DuplicateAlertBox" class="col-lg-4 col-lg-offset-4" ></div>
</section>

</cfoutput>