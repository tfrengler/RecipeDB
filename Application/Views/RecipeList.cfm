<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section class="row" >
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes</h1>
</section>

<section id="RecipeList-Container" class="row" >

	<div class="col-md-8 col-md-offset-2 olive-wrapper-grey-background" >
		<table id="RecipeList-Table" border="0" class="row-border order-column stripe" >
			<thead>
				<th>Name</th>
				<th>Created by</th>
				<th>Created on</th>
				<th>Last modified by</th>
				<th>Modified on</th>
				<!--- <th>Ingredients</th> Not sure we want these here. Too much info in these columns to fit the tables nicely
				<th>Description</th> --->
				<th>ID</th>
			</thead>

			<tbody>
			</tbody>
		</table>
	</div>

</section>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.RecipeList.init();
	});
</script>

</cfoutput>