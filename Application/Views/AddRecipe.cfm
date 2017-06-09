<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section class="row" >
	<h1 id="AddRecipe-Welcome" class="olive-text-color-center" >Add new recipe</h1>	
</section>

<br/>

<section class="row" >
	<form id="AddRecipe-Form" class="olive-wrapper-grey-background col-md-2 col-md-offset-5" >

		<input id="AddNewRecipe-Anyway" type="hidden" value="0" >

		<input id="AddRecipe-Name" class="form-control" type="text" value="" placeholder="recipe name" maxlength="100" />
		<input id="DuplicateCheck" type="checkbox" checked /><span> Warn me about potential duplicate recipes</span>

		<br/><br/>

		<input id="AddNewRecipe-Button" type="button" value="OK" class="standard-button btn-block center-block" />

	</form>
</section>

<br/>

<section class="row" >
	<div id="AddRecipe-DuplicateAlertBox" class="col-md-4 col-md-offset-4" ></div>
</section>

<section class="row" >
	<div id="AddRecipe-MessageBox" class="error-box col-md-2 col-md-offset-5" ></div>
</section>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.AddRecipe.init();
	});
</script>

</cfoutput>