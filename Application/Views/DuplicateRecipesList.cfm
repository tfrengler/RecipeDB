<cfparam name="NonceValue" type="string" default="" />
<cfoutput>
<!--- MODULE --->

<cfparam name="attributes.DuplicateAmount" type="numeric" default="0" />
<cfparam name="attributes.ExcessDuplicateAmount" type="numeric" default=0 />
<cfparam name="attributes.DuplicateRecipes" type="array" default="#arrayNew(1)#" />

<div class="standard-olive-wrapper standard-rounded-corners" >
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

</cfoutput>