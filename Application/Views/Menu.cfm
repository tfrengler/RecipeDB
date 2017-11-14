<!--- THIS IS AN INCLUDE FILE --->

<nav class="side-menu" id="side-menu" >

	<div id="Close-Menu-Button-Wrapper" >
		<div class="inline-block" >
			<img id="Close-Menu-Button" src="Assets/Pictures/Standard/menu-icon-close.png" class="img-responsive" />
		</div>
	</div>

	<ul id="Menu-Options">
		<li><a id="AddRecipe" href="AddNewRecipe.cfm" >
			<i class="fa fa-plus fa-fw"></i>
			Add recipe
		</a></li>
		<li><a id="RecipeList" href="FindRecipes.cfm" >
			<i class="fa fa-search fa-fw"></i>
			Find recipes
		</a></li>
		<!--- <li><a id="Favorites" href="#" >Favorites</a></li> --->
		<li><a id="UserSettings" href="MySettings.cfm" >
			<i class="fa fa-cog fa-fw"></i>
			My settings
		</a></li>
		<li><a id="Logout" href="../../Login.cfm?Reason=6" >
			<i class="fa fa-times fa-fw"></i>
			Logout
		</a></li>
		<hr/>
		<!--- <li><a id="Statistics" href="#" >Statistics</a></li> --->
		<li><a id="PatchNotes" href="WhatChanged.cfm" >
			<i class="fa fa-book fa-fw"></i>
			Recent changes
		</a></li>
		<li><a id="Roadmap" href="PlannedChanges.cfm" >
			<i class="fa fa-book fa-fw"></i>
			Planned changes
		</a></li>
	</ul>
</nav>

<img id="Open-Menu-Button" src="Assets/Pictures/Standard/menu-icon.png" class="img-responsive" />