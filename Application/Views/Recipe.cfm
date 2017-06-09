<cfprocessingdirective pageEncoding="utf-8" />

<cfparam name="attributes.RecipeID" default="0" />
<cfparam name="attributes.Name" default="[no name]" />
<cfparam name="attributes.DateCreated" default="" />
<cfparam name="attributes.DateTimeLastModified" default="" />
<cfparam name="attributes.CreatedByUser" default="" />
<cfparam name="attributes.LastModifiedByUser" default="" />
<cfparam name="attributes.Ingredients" default="[no Ingredients]" />
<cfparam name="attributes.Description" default="[no description]" />
<cfparam name="attributes.Picture" default="" />
<cfparam name="attributes.Instructions" default="[no Instructions]" />
<cfparam name="attributes.Comments" default="#arrayNew(1)#" />

<cfoutput>

<div id="Recipe-Container" class="row" >

	<div class="recipe col-md-6 col-md-offset-3" >

		<div class="row">
			<div id="Recipe-Title-Container" class="olive-text-color-center" >
				<h3 id="Recipe-Title" >#attributes.Name#</h3>
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

	<cfif attributes.CreatedByUser EQ session.CurrentUser.getUserId() >
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
					#attributes.Description#
				</p>
				<!-- <textarea id="Recipe-Description-Edit" ></textarea> -->

			</div>
		</div>
		<br/>

		<div class="row" >
			<div name="Recipe-Header" id="Ingredients-Header" class="recipe-section-header inline-block standard-top-radius" >INGREDIENTS</div>
			<div id="Ingredients-Body" class="recipe-section-body" >

				<p id="Recipe-Ingredients-Container" >
					#attributes.Ingredients#
				</p>
				<!-- <textarea id="Recipe-Ingredients-Edit" ></textarea> -->

			</div>
		</div>
		<br/>

		<div class="row" >
			<div name="Recipe-Header" id="Instructions-Header" class="recipe-section-header inline-block standard-top-radius" >INSTRUCTIONS</div>
			<div id="Instructions-Body" class="recipe-section-body" >

				<p id="Recipe-Instructions-Container" >
					#attributes.Description#
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
					<p>Created by: #attributes.CreatedByUser#</p>
					<p>Date created: #attributes.DateCreated#</p>
					<p>Modified by: #attributes.LastModifiedByUser#</p>
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