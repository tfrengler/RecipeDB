<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section>
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes</h1>
</section>

<cfmodule template="RecipeListFilter.cfm" listSwitchButtonType="simple" >

<section id="RecipeList-Container">
	<div class="col-lg-8 col-lg-offset-2 olive-wrapper-grey-background standard-rounded-corners standard-box-shadow" >

		<table id="RecipeList-Table" border="0" class="row-border order-column stripe" >
			<thead>
				<th>Name</th>
				<th>Created by</th>
				<th>Created on</th>
				<th>Modified on</th>
				<th>Published</th>
				<th>ID</th> <!-- This has to be last, for the click handler that opens recipes to work! -->
			</thead>

			<tbody>
			</tbody>
		</table>

	</div>
</section>

</cfoutput>