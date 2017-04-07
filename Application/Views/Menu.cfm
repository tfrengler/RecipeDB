<nav class="side-menu" id="side-menu" >

	<div id="Close-Menu-Button-Wrapper" >
		<div class="inline-block" >
			<img id="Close-Menu-Button" src="../Assets/Pictures/Standard/menu-icon-close.png" class="img-responsive" />
		</div>
	</div>

	<ul id="Menu-Options">
		<li><a href="#">Add recipe</a></li>
		<li><a href="#">Find recipes</a></li>
		<li><a id="Logout" href="#">Logout</a></li>
		<li><a id="UserSettings" href="#">My settings</a></li>
		<li><a href="#">Statistics</a></li>
		<li><a href="#">Favorites</a></li>
	</ul>
</nav>

<div id="Main-Screen-Content">
	<img id="Open-Menu-Button" src="../Assets/Pictures/Standard/menu-icon.png" class="img-responsive" />
</div>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.Menu.init();
	});

	$(document).resize(function() {
		RecipeDB.Menu.onResize();
	});
</script>