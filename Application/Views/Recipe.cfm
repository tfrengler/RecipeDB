<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<cfparam name="attributes.RecipeID" default="0" />
<cfparam name="attributes.Name" type="string" default="[no name]" />
<cfparam name="attributes.DateCreated" type="string" default="" />
<cfparam name="attributes.DateTimeLastModified" default="" />
<cfparam name="attributes.CreatedByUserName" type="string" default="[unknown owner]" />
<cfparam name="attributes.CreatedByUserID" default=0 />
<cfparam name="attributes.LastModifiedByUser" default="0" />
<cfparam name="attributes.Ingredients" type="string" default="[no ingredients]" />
<cfparam name="attributes.Description" type="string" default="[no description]" />
<cfparam name="attributes.Picture" default="" />
<cfparam name="attributes.Instructions" type="string" default="[no instructions]" />
<cfparam name="attributes.Comments" type="array" default="#arrayNew(1)#" />
<cfparam name="attributes.DisplayToolbar" type="boolean" default="false" />

<section id="Recipe-Container" class="row" >

	<div id="Recipe" class="col-lg-6 col-lg-offset-3" >

		<input type="hidden" id="RecipeID" value="#attributes.RecipeID#" />

		<div>
			<div id="Recipe-Title-Container" class="olive-text-color-center" >
				<h3 id="Recipe-Title" name="ViewSection" >#encodeForHTML(attributes.Name)#</h3>
				<input id="Recipe-Title-Edit" name="EditSection" class="h3 display-none" type="text" value="#attributes.Name#" />
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
					<span id="Edit-Recipe-Button" class="standard-button" >Make editable</span>
					<span id="Save-Recipe-Button" class="standard-button display-none" >Save changes</span>
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
					<p>RecipeID: #attributes.RecipeID#</p>
					<p>Created by: #encodeForHTML(attributes.CreatedByUserName)#</p>
					<p>Created on: #LSDateFormat(attributes.DateCreated, "dd-mm-yyyy")#</p>
					<p>Modified by: #encodeForHTML(attributes.LastModifiedByUser)#</p>
					<p>Last modified: #LSDateTimeFormat(attributes.DateTimeLastModified, "dd-mm-yyyy HH:nn:ss")#</p>
				</div>

			</div>
		</div>

	</div>
</section>

</cfoutput>