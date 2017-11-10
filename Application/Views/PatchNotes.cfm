<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<cfparam name="attributes.patchNoteCollection" type="array" default="#arrayNew(1)#" />

<section>
	<h1 id="PatchNotes-Welcome" class="olive-text-color-center" >What has changed?</h1>
</section>

<section id="PatchNotesContainer" class="olive-wrapper-grey-background standard-rounded-corners col-lg-8 col-lg-offset-2" >

	<p>Source code and changes can also be found <a href="https://github.com/tfrengler/RecipeDB/commits/">on GitHub</a></p>

	<cfif arrayLen(attributes.patchNoteCollection) GT 0 >

		<cfloop array="#attributes.patchNoteCollection#" index="CurrentPatchNotes" >
			
			<fieldset>
				<legend>PATCH:</legend>

				<div name="PatchNote" >
					#CurrentPatchNotes#
				</div>
			</fieldset>

		</cfloop>

	<cfelse>
		<div>
			<i>No patch notes...</i>
		</div>
	</cfif>

</section>

</cfoutput>