<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<div id="RecipeList-Container" class="row" >

	<div class="col-md-6 col-md-offset-3" >
		<table id="RecipeList-Table" border="1" >
			<thead>
				<th>RecipeID</th>
				<th>DateCreated</th>
				<th>DateTimeLastModified</th>
				<th>CreatedByUser</th>
				<th>LastModifiedByUser</th>
				<th>Ingredients</th>
				<th>Description</th>
				<th>Name</th>
			</thead>

			<tbody>
			</tbody>
		</table>
	</div>

</div>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.RecipeList.init();
	});
</script>

</cfoutput>