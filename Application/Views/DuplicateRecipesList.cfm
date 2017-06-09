<cfprocessingdirective pageEncoding="utf-8" />

<cfparam name="attributes.DuplicateAmount" default="#arrayNew(1)#" />
<cfparam name="attributes.ExcessDuplicateAmount" default=0 />
<cfparam name="attributes.DuplicateRecipeObjects" default=0 />

<cfoutput>

<div class="standard-olive-wrapper" >
	<p>We found #attributes.DuplicateAmount# recipes that have a similar name to the new recipe you want to add:</p>
	<ul>
		<cfloop array="#attributes.DuplicateRecipeObjects#" index="CurrentRecipe" >
			<li>(ID #CurrentRecipe.getRecipeID()#) <a href="##" title="#encodeForHTML( CurrentRecipe.getName() )#" >#encodeForHTML( CurrentRecipe.getName() )#</a>, created by #encodeForHTML( CurrentRecipe.getCreatedByUser().getDisplayName() )#</li>
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