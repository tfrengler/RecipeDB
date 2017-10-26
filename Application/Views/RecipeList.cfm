<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section class="row" >
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes</h1>
</section>

<section id="RecipeList-Container" class="row" >
	<div class="col-md-8 col-md-offset-2 olive-wrapper-grey-background" >

		<!--- <div id="Recipe-Toolbar" class="olive-wrapper-white-background" >
			<span><b>TOOLBOX: </b></span>
			<input type="checkbox" id="Filter-OwnedByMe" >Owned by me</span>
			<input type="checkbox" id="Filter-Published" >Published</span>
			<input type="checkbox" id="Filter-UnPublished" >Unpublished</span>
		</div> --->

		<hr/>

		<table id="RecipeList-Table" border="0" class="row-border order-column stripe" >
			<thead>
				<th>Name</th>
				<th>Created by</th>
				<th>Created on</th>
				<th>Last modified by</th>
				<th>Modified on</th>
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