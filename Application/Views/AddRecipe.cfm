<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<section>
	<h1 id="AddRecipe-Welcome" class="olive-text-color-center" >Add new recipe</h1>	
</section>

<br/>

<section>
	<form id="AddRecipe-Form" class="olive-wrapper-grey-background standard-rounded-corners col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4 standard-box-shadow" >

		<input id="AddNewRecipe-Anyway" type="hidden" value="0" >

		<input id="AddRecipe-Name" class="form-control" type="text" value="" placeholder="name" maxlength="100" />
		<!--- <input id="DuplicateCheck" type="checkbox" /><span> Warn me about potential duplicate recipes</span> --->

		<p>Give your new recipe a name. It can be up to 100 characters long.</p>
		<p><b>NOTE:</b> New recipes are <b>PRIVATE</b> by default. That means only <b>YOU</b> can see them! You can change visibility under the recipe</p>

		<input id="AddNewRecipe-Button" type="button" value="ADD" class="standard-button btn-block center-block" />

	</form>
</section>

<br/>

<section>
	<div id="AddRecipe-DuplicateAlertBox" class="col-lg-4 col-lg-offset-4" ></div>
</section>

</cfoutput>