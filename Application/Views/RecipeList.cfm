<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section>
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes</h1>
</section>

<section id="Open-Filter-Menu" class="standard-button display-none" >
	<i class="fa fa-filter" aria-hidden="true"></i>
	FILTERS&nbsp;
</section>

<section id="Filter-Menu" >
	<div id="Filter-Menu-Header" >
		<i id="Close-Filter-Menu" class="fa fa-window-close fa-lg" aria-hidden="true"></i>
		<b class="olive-text-color" >FILTER RECIPES:</b>
	</div>

	<br/>

	<div class="inline-block" >
		<input type="checkbox" name="FilterOption" id="Filter-Mine" >mine only</input><br/>
		<input type="checkbox" name="FilterOption" id="Filter-MinePublic" >mine only that are public</input><br/>
		<input type="checkbox" name="FilterOption" id="Filter-MinePrivate" >mine only that are private</input><br/>
	</div>

	<div class="inline-block" >
		<input type="checkbox" name="FilterOption" id="Filter-MineEmpty" >mine only that are empty</input><br/>
		<input type="checkbox" name="FilterOption" id="Filter-MineNoPicture" >mine only without a picture</input><br/>
		<input type="checkbox" name="FilterOption" id="Filter-Others" >from other users only</input><br/>
	</div>

	<br/><br/>
	<span><i>By default the list shows all recipes that belong to you and all public recipes from other users</i></span>
	<br/><br/>

	<span id="ApplyFilter" class="standard-button" >APPLY FILTER</span>
	<span id="ClearFilter" class="standard-button" >DE-SELECT ALL</span>
</section>

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