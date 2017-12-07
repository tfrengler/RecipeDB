<cfprocessingdirective pageEncoding="utf-8" />

<cfoutput>

<section>
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes</h1>
</section>

<section id="RecipeList-Container">
	<div class="col-lg-8 col-lg-offset-2 olive-wrapper-grey-background standard-rounded-corners standard-box-shadow" >

		<!--- <div id="Recipe-Toolbar" class="olive-wrapper-white-background" >
			<span><b>FILTER BY:&nbsp;</b></span><br/>

			<input type="checkbox" id="" value="" >Recipes owned by me</input>
			<input type="checkbox" id="" value="" >My recipes that are public</input>
			<input type="checkbox" id="" value="" >My recipes that are private</input>
			<input type="checkbox" id="" value="" >My recipes that are empty</input>
			<input type="checkbox" id="" value="" >My recipes without a picture</input>
			<input type="checkbox" id="" value="" >Recipes by other users</input>

			<br/>
			<span id="" class="standard-button" >APPLY</span>
			<span id="" class="standard-button" >CLEAR</span>
			
			<hr/>

			<span><b>QUICK FILTERS:</b></span>
			<select>
				<option>All</option>
				<option>Recipes owned by me</option>
				<option>My recipes that are public</option>
				<option>My recipes that are private</option>
				<option>My recipes that are empty</option>
				<option>My recipes without a picture</option>
				<option>Recipes by other users</option>
			</select>
		</div> --->

		<br/>

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