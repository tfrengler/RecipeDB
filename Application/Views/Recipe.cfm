<cfprocessingdirective pageEncoding="utf-8" />

<cfparam name="attributes.RecipeID" default="0" />
<cfparam name="attributes.Name" default="[no name]" />
<cfparam name="attributes.DateCreated" default="" />
<cfparam name="attributes.DateTimeLastModified" default="" />
<cfparam name="attributes.CreatedByUserName" default="[unknown owner]" />
<cfparam name="attributes.CreatedByUserID" default=0 />
<cfparam name="attributes.LastModifiedByUser" default="" />
<cfparam name="attributes.Ingredients" default="[no Ingredients]" />
<cfparam name="attributes.Description" default="[no description]" />
<cfparam name="attributes.Picture" default="" />
<cfparam name="attributes.Instructions" default="[no Instructions]" />
<cfparam name="attributes.Comments" default="#arrayNew(1)#" />

<cfoutput>

<!--- 
	Still not sure how to deal with editing the recipe. Choices are along the lines of:
	1: Use dialogs per section. Pops up, you edit stuff, press OK/SAVE and only that section is saved
	2: Click an edit-button to make the recipe (or specific sections) editable. Press a button to save the entire thing (ajax form submit, no page reload)
	3: Similar to 2 but using form submission and page reload
	4: Not an actual method for saving but maybe implement some sort of autosave later on?
--->

<div id="Recipe-Container" class="row" >

	<div class="recipe col-md-6 col-md-offset-3" >

		<div class="row">
			<div id="Recipe-Title-Container" class="olive-text-color-center" >
				<h3 id="Recipe-Title" >#encodeForHTML(attributes.Name)#</h3>
				<!-- <input id="Recipe-Title-Edit" class="h3" type="text" value="TITLE OF RECIPE" /> -->
			</div>
			
			<div id="Recipe-Picture-Container" class="center-block recipe-picture" >
				<!-- <div id="Recipe-Picture-Edit-Container" >
					<div id="Recipe-Picture-Edit" >CLICK TO CHANGE</div>
				</div> -->
				<img id="Recipe-Picture" src="../Assets/Pictures/Standard/foodexample.jpg" class="img-responsive img-thumbnail" />
			</div>
		</div>
		<br/>

		<cfif attributes.CreatedByUserID EQ session.CurrentUser.getID() >
			<div class="row">
				<div id="Recipe-Toolbar" class="olive-wrapper-white-background" >
					<span id="Edit-Recipe-Button" class="standard-button" >Make editable</span>
					<span id="Save-Recipe-Button" class="standard-button" >Save changes</span>
				</div>
			</div>
			<br/>
		</cfif>

		<div class="row" >
			<div name="Recipe-Header" id="Description-Header" class="recipe-section-header inline-block standard-top-radius" >DESCRIPTION</div>
			<div id="Description-Body" class="recipe-section-body" >

				<p id="Recipe-Description-Container" >
					#encodeForHTML(attributes.Description)#
				</p>
				<!-- <textarea id="Recipe-Description-Edit" ></textarea> -->

			</div>
		</div>
		<br/>

		<div class="row" >
			<div name="Recipe-Header" id="Ingredients-Header" class="recipe-section-header inline-block standard-top-radius" >INGREDIENTS</div>
			<div id="Ingredients-Body" class="recipe-section-body" >

				<p id="Recipe-Ingredients-Container" >
					#encodeForHTML(attributes.Ingredients)#
				</p>
				<!-- <textarea id="Recipe-Ingredients-Edit" ></textarea> -->

			</div>
		</div>
		<br/>

		<div class="row" >
			<div name="Recipe-Header" id="Instructions-Header" class="recipe-section-header inline-block standard-top-radius" >INSTRUCTIONS</div>
			<div id="Instructions-Body" class="recipe-section-body" >

				<p id="Recipe-Instructions-Container" >
					#encodeForHTML(attributes.Instructions)#
				</p>
				<!-- <textarea id="Recipe-Instructions-Edit" ></textarea> -->

			</div>
		</div>
		<br/>

		<div class="row" >
			<div name="Recipe-Header" id="Comments-Header" class="recipe-section-header inline-block standard-top-radius" >COMMENTS</div>
			<div id="Comments-Body" class="recipe-section-body" >

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
		<br/>

		<div class="row" >
			<div name="Recipe-Header" id="Status-Header" class="recipe-section-header inline-block standard-top-radius" >STATUS</div>
			<div id="Status-Body" class="recipe-section-body" >

				<div id="Recipe-Status-Container" >
					<p>RecipeID: #attributes.RecipeID#</p>
					<p>Created by: #encodeForHTML(attributes.CreatedByUserName)#</p>
					<p>Date created: #attributes.DateCreated#</p>
					<p>Modified by: #encodeForHTML(attributes.LastModifiedByUser)#</p>
					<p>Date modified: #attributes.DateTimeLastModified#</p>
				</div>

			</div>
		</div>
		<br/>

	</div>

</div>

</cfoutput>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.Recipe.init();
	});

	$(document).resize(function() {
		RecipeDB.Recipe.onResize();
	});
</script>