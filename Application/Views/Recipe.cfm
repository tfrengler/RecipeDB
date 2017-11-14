<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<cfparam name="attributes.RecipeID" default="0" />
<cfparam name="attributes.Name" type="string" default="[no name]" />
<cfparam name="attributes.DateCreated" type="string" default="" />
<cfparam name="attributes.DateTimeLastModified" type="string" default="" />
<cfparam name="attributes.CreatedByUserName" type="string" default="[unknown user]" />
<cfparam name="attributes.CreatedByUserID" type="numeric" default=0 />
<cfparam name="attributes.LastModifiedByUser" type="string" default="[unknown user]" />
<cfparam name="attributes.Ingredients" type="string" default="[no ingredients]" />
<cfparam name="attributes.Description" type="string" default="[no description]" />
<cfparam name="attributes.Picture" default="" />
<cfparam name="attributes.Instructions" type="string" default="[no instructions]" />
<cfparam name="attributes.Comments" type="array" default="#arrayNew(1)#" />
<cfparam name="attributes.DisplayToolbar" type="boolean" default="false" />
<cfparam name="attributes.Published" type="boolean" default="false" />

<section id="Recipe-Container" class="row" >

	<div id="Recipe" class="col-lg-6 col-lg-offset-3" >

		<input type="hidden" id="RecipeID" value="#attributes.RecipeID#" />

		<div>
			<div id="Recipe-Title-Container" class="olive-text-color-center" >
				<h3 id="Recipe-Title" name="ViewSection" >#encodeForHTML(attributes.Name)#</h3>
				<input id="Recipe-Title-Edit" name="EditSection" class="h3 display-none" type="text" value="#attributes.Name#" maxlength="100" />
			</div>
			
			<div id="Recipe-Picture-Container" class="center-block recipe-picture" >
				<!-- <div id="Recipe-Picture-Edit-Container" >
					<div id="Recipe-Picture-Edit" >CLICK TO CHANGE</div>
				</div> -->
				<img id="Recipe-Picture" src="Assets/Pictures/Standard/foodexample.jpg" class="img-responsive img-thumbnail" />
			</div>
		</div>
		<br/>

		<cfif attributes.CreatedByUserID EQ session.CurrentUser.getID() >
			<div id="Toolbar-Row">
				<div id="Toolbar-Header" class="standard-rounded-corners-top" >TOOLBAR</div>

				<div id="Recipe-Toolbar" class="olive-wrapper-white-background" >
					<button type="button" id="Edit-Recipe-Button" class="toolbar-button standard-button" title="Edit the recipe" ><i class="fa fa-pencil-square-o"></i></button>
					<button type="button" id="Delete-Recipe-Button" class="toolbar-button standard-button" title="Delete the recipe" ><i class="fa fa-times"></i></button>
					<button type="button" id="Publish-Recipe-Button" class="toolbar-button standard-button" title="Change whether the recipe is visible to other users or not" >CHANGE VISIBILITY</button>
					<button type="button" id="Save-Recipe-Button" class="toolbar-button standard-button display-none" title="Save changes"><i class="fa fa-floppy-o"></i></button>
				</div>
			</div>
			<br/>
		</cfif>

		<div>
			<div name="Recipe-Header" id="Description-Header" class="recipe-section-header inline-block standard-rounded-corners-top" >DESCRIPTION</div>
			<div id="Description-Body" class="recipe-section-body standard-olive-wrapper" >

				<div id="Recipe-Description-Container" name="ViewSection" >
					<cfif len(attributes.Description) IS 0 >
						<i>No description yet</i>
					<cfelse>
						#attributes.Description#
					</cfif>
				</div>
				<textarea id="Recipe-Description-Edit" name="EditSection" class="display-none" >#attributes.Description#</textarea>

			</div>
		</div>
		<br/>

		<div>
			<div name="Recipe-Header" id="Ingredients-Header" class="recipe-section-header inline-block standard-rounded-corners-top" >INGREDIENTS</div>
			<div id="Ingredients-Body" class="recipe-section-body standard-olive-wrapper" >

				<div id="Recipe-Ingredients-Container" name="ViewSection" >
					<cfif len(attributes.Ingredients) IS 0 >
						<i>No ingredients yet</i>
					<cfelse>
						#attributes.Ingredients#
					</cfif>
				</div>
				<textarea id="Recipe-Ingredients-Edit" name="EditSection" class="display-none" >#attributes.Ingredients#</textarea>

			</div>
		</div>
		<br/>

		<div>
			<div name="Recipe-Header" id="Instructions-Header" class="recipe-section-header inline-block standard-rounded-corners-top" >INSTRUCTIONS</div>
			<div id="Instructions-Body" class="recipe-section-body standard-olive-wrapper" >

				<div id="Recipe-Instructions-Container" name="ViewSection" >
					<cfif len(attributes.Instructions) IS 0 >
						<i>No instructions yet</i>
					<cfelse>
						#attributes.Instructions#
					</cfif>
				</div>
				<textarea id="Recipe-Instructions-Edit" name="EditSection" class="display-none" >#attributes.Instructions#</textarea>

			</div>
		</div>
		<br/>

		<!--- <div>
			<div name="Recipe-Header" id="Comments-Header" class="recipe-section-header inline-block standard-rounded-corners-top" >COMMENTS</div>
			<div id="Comments-Body" class="recipe-section-body standard-olive-wrapper" >

				<div id="Comments-Container" >
					<p id="Comment_123456" >
						<div class="standard-olive-wrapper olive-background-color" >Thomas | 27-03-1984 13:37</div>
						<div class="standard-olive-wrapper" >COMMENT</div>
					</p>
					<p id="Comment_123456" >
						<div class="standard-olive-wrapper olive-background-color" >Carlette | 29-09-1983 14:47</div>
						<div class="standard-olive-wrapper" >COMMENT</div>
					</p>
				</div>
				<div id="Recipe-Comments-Toolbar" >
					<span id="Comments-AddNew" class="standard-button" >Add comment</span>
				</div>

			</div>
		</div>
		<br/> --->

		<div>
			<div name="Recipe-Header" id="Status-Header" class="recipe-section-header inline-block standard-rounded-corners-top" >STATUS</div>
			<div id="Status-Body" class="recipe-section-body standard-olive-wrapper" >

				<div id="Recipe-Status-Container" >
					<p><b>RecipeID: </b>#attributes.RecipeID#</p>
					<p><b>Created by:</b> #encodeForHTML(attributes.CreatedByUserName)#</p>
					<p><b>Created on:</b> #LSDateFormat(attributes.DateCreated, "dd-mm-yyyy")#</p>
					<p><b>Modified by:</b> #encodeForHTML(attributes.LastModifiedByUser)#</p>
					<p><b>Last modified:</b> #LSDateTimeFormat(attributes.DateTimeLastModified, "dd-mm-yyyy HH:nn:ss")#</p>
					<p>
						<b>Visible to other users:</b>
						<cfif attributes.Published >
							<span id="Published-Status" class="true" >yes</span>
						<cfelse>
							<span id="Published-Status" class="false" >no</span>
						</cfif>
					</p>
				</div>

			</div>
		</div>

	</div>
</section>

</cfoutput>