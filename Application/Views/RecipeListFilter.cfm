<cfparam name="NonceValue" type="string" default="" />
<!--- MODULE --->

<cfparam name="attributes.listSwitchButtonType" type="string" default="" />
<cfparam name="attributes.filter" type="struct" default=#structNew()# />
<cfparam name="attributes.filter.mineOnly" type="boolean" default="false" />
<cfparam name="attributes.filter.minePublic" type="boolean" default="false" />
<cfparam name="attributes.filter.minePrivate" type="boolean" default="false" />
<cfparam name="attributes.filter.mineEmpty" type="boolean" default="false" />
<cfparam name="attributes.filter.mineNoPicture" type="boolean" default="false" />
<cfparam name="attributes.filter.otherUsersOnly" type="boolean" default="false" />

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
		<input type="checkbox" class="FilterOption" name="MineOnly" id="Filter-Mine" <cfif attributes.filter.mineOnly >checked</cfif> >mine only</input><br/>
		<input type="checkbox" class="FilterOption" name="MinePublic" id="Filter-MinePublic" <cfif attributes.filter.minePublic >checked</cfif> >mine only that are public</input><br/>
		<input type="checkbox" class="FilterOption" name="MinePrivate" id="Filter-MinePrivate" <cfif attributes.filter.minePrivate >checked</cfif> >mine only that are private</input><br/>
	</div>

	<div class="inline-block" >
		<input type="checkbox" class="FilterOption" name="MineEmpty" id="Filter-MineEmpty" <cfif attributes.filter.mineEmpty >checked</cfif> >mine only that are empty</input><br/>
		<input type="checkbox" class="FilterOption" name="MineNoPicture" id="Filter-MineNoPicture" <cfif attributes.filter.mineNoPicture >checked</cfif> >mine only without a picture</input><br/>
		<input type="checkbox" class="FilterOption" name="OtherUsersOnly" id="Filter-Others" <cfif attributes.filter.otherUsersOnly >checked</cfif> >from other users only</input><br/>
	</div>

	<br/><br/>
	<span><i>By default the list shows all recipes that belong to you and all public recipes from other users</i></span>
	<br/><br/>

	<span id="ApplyFilter" class="standard-button" >APPLY FILTER</span>
	<span id="ClearFilter" class="standard-button" >DE-SELECT ALL</span>
	<cfif attributes.listSwitchButtonType IS "simple" >
		<span id="SwitchListType" class="standard-button" title="Switch to a simpler, picture-type list of recipes" ><a href="FindRecipesAsThumbnails.cfm">SWITCH TO SIMPLE LIST</a></span>
	<cfelseif attributes.listSwitchButtonType IS "full" >
		<span id="SwitchListType" class="standard-button" title="Switch to a table-like list of recipes" ><a href="FindRecipes.cfm">SWITCH TO FULL LIST</a></span>
	</cfif>
</section>