<cfprocessingdirective pageEncoding="utf-8" />
<!--- MODULE --->

<cfparam name="attributes.listSwitchButtonType" type="string" default="" />

<link rel="stylesheet" type="text/css" href="Assets/CSS/filtermenu.css" />

<section id="Open-Filter-Menu" class="standard-button" >
	<i class="fa fa-filter" aria-hidden="true"></i>
</section>

<section id="Filter-Menu" >
	<div id="Filter-Menu-Header" >
		<i id="Close-Filter-Menu" class="fa fa-window-close fa-lg" aria-hidden="true"></i>
		<b class="olive-text-color" >FILTER RECIPES:</b>
	</div>

	<br/>

	<div class="inline-block" >
		<input type="checkbox" class="FilterOption" name="MineOnly" id="Filter-Mine" >mine only</input><br/>
		<input type="checkbox" class="FilterOption" name="MinePublic" id="Filter-MinePublic" >mine only that are public</input><br/>
		<input type="checkbox" class="FilterOption" name="MinePrivate" id="Filter-MinePrivate" >mine only that are private</input><br/>
	</div>

	<div class="inline-block" >
		<input type="checkbox" class="FilterOption" name="MineEmpty" id="Filter-MineEmpty" >mine only that are empty</input><br/>
		<input type="checkbox" class="FilterOption" name="MineNoPicture" id="Filter-MineNoPicture" >mine only without a picture</input><br/>
		<input type="checkbox" class="FilterOption" name="OthersOnly" id="Filter-Others" >from other users only</input><br/>
	</div>

	<br/><br/>
	<span><i>By default the list shows all recipes that belong to you and all public recipes from other users</i></span>
	<br/><br/>

	<span id="ApplyFilter" class="standard-button" >APPLY FILTER</span>
	<span id="ClearFilter" class="standard-button" >DE-SELECT ALL</span>
	<cfif attributes.listSwitchButtonType IS "simple" >
		<span id="SwitchListType" class="standard-button" title="Switch to a simpler, picture-type list of recipes" ><a href="	FindRecipesAsThumbnails.cfm">SWITCH LIST TYPE</a></span>
	<cfelseif attributes.listSwitchButtonType IS "full" >
		<span id="SwitchListType" class="standard-button" title="Switch to a table-like list of recipes" ><a href="FindRecipes.cfm">SWITCH LIST TYPE</a></span>
	</cfif>
</section>