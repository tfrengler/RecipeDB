<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section>
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes</h1>
</section>

<section id="RecipeList-Container">
	<div class="col-lg-8 col-lg-offset-2 olive-wrapper-grey-background standard-rounded-corners standard-box-shadow" >

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

</cfoutput>