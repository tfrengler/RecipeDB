<cfprocessingdirective pageEncoding="utf-8" />
<cfparam name="attributes.recipes" type="array" />

<cfoutput>

<section>
	<h1 id="RecipeList-Welcome" class="olive-text-color-center" >List of recipes (#arrayLen(attributes.recipes)#)</h1>
</section>

<form id="FilterForm" action="FindRecipesAsThumbnails.cfm" method="POST" enctype="application/x-www-form-urlencoded" >
	<cfmodule template="RecipeListFilter.cfm" listSwitchButtonType="full" >
</form>

<section id="RecipeList-Container" class="container-fluid olive-wrapper-grey-background standard-rounded-corners" >

	<cfset LoopIndex = 1 >
	<cfloop array=#attributes.recipes# index="recipe" >

		<div class="recipe-thumbnail-wrapper col-lg-3 col-md-3 col-sm-6" >
			<div class="olive-wrapper-grey-background standard-rounded-corners standard-box-shadow" >

				<a href="Recipe.cfm?RecipeID=#recipe.recipeID#">
					<img src="#recipe.picture#" class="center-block img-responsive" />
				</a>

				<div id="Recipe-Name" class="olive-background-color" >#encodeForHTML(recipe.name)#</div>
			</div>
		</div>

		<cfif LoopIndex MOD 4 IS 0 >
			<div style="clear:both"></div>
		</cfif>

		<cfset LoopIndex++ />
	</cfloop>

</section>

<cfif structKeyExists(REQUEST, "filtersettings")>
	<script type="text/javascript">

	<cfloop collection=#REQUEST.filtersettings# item="filterSetting" >
	
		<cfif filterSetting IS "fieldnames" >
			<cfcontinue/>
		<cfelse>
			$("[name='#filterSetting#']").prop("checked", true);
		</cfif>

	</cfloop>

		RecipeDB.page.openCloseFilterMenu(true);
	</script>
</cfif>

</cfoutput>