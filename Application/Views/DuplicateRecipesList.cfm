<cfprocessingdirective pageEncoding="utf-8" />

<cfparam name="attributes.DuplicateAmount" default="0" />
<cfparam name="attributes.ExcessDuplicateAmount" default=0 />
<cfparam name="attributes.DuplicateRecipes" default="#arrayNew(1)#" />

<cfoutput>

<div class="standard-olive-wrapper" >
	<p>We found #attributes.DuplicateAmount# recipes that have a similar name to the new recipe you want to add:</p>
	<ul>
		<cfloop array="#attributes.DuplicateRecipes#" index="CurrentRecipe" >
			<li>(ID #CurrentRecipe.ID#) <a href="##" title="#encodeForHTML( CurrentRecipe.Name )#" >#encodeForHTML( CurrentRecipe.Name )#</a>, created by #encodeForHTML( CurrentRecipe.Owner )#</li>
		</cfloop>
	</ul>
	<cfif attributes.ExcessDuplicateAmount GT 0 >
		<div>...plus #attributes.ExcessDuplicateAmount# more</div>
	</cfif>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.DuplicatesRecipesList.init();
	});
</script>

</cfoutput>