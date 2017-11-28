<!--- THIS IS AN INCLUDE FILE --->

<nav class="side-menu" id="side-menu" >

	<div id="Close-Menu-Button-Wrapper" >
		<div class="inline-block" >
			<img id="Close-Menu-Button" src="Assets/Pictures/Standard/menu-icon-close.png" class="img-responsive" />
		</div>
	</div>

	<ul id="Menu-Options">
		<li><a id="AddRecipe" href="AddNewRecipe.cfm" >
			<i class="fa fa-plus fa-fw dark-green-text-color"></i>
			Add recipe
		</a></li>

		<li><a id="RecipeList" href="FindRecipes.cfm" >
			<i class="fa fa-search fa-fw dark-green-text-color"></i>
			Find recipes
		</a></li>

		<li><a id="UserSettings" href="MySettings.cfm" >
			<i class="fa fa-cog fa-fw dark-green-text-color"></i>
			My settings
		</a></li>

		<li><a id="Logout" href="../../Login.cfm?Reason=6" >
			<i class="fa fa-times fa-fw dark-green-text-color"></i>
			Logout
		</a></li>

		<hr/>

		<li><a id="PatchNotes" href="WhatChanged.cfm" >
			<i class="fa fa-book fa-fw dark-green-text-color"></i>
			Recent changes
		</a></li>
		
		<li><a id="Roadmap" href="PlannedChanges.cfm" >
			<i class="fa fa-book fa-fw dark-green-text-color"></i>
			Planned changes
		</a></li>

		<li><a id="About" href="About.cfm" >
			<i class="fa fa-question-circle fa-fw dark-green-text-color"></i>
			About / FAQ
		</a></li>
	</ul>
</nav>

<div id="Open-Menu-Wrapper" >
	<img id="Open-Menu-Button" src="Assets/Pictures/Standard/menu-icon.png" class="img-responsive" />
	<div>MENU</div>
</div>