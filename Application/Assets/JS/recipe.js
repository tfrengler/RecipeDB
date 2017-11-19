"use strict";
RecipeDB.page = {};
RecipeDB.page.transient = {};

RecipeDB.page.transient.descriptionBodyHeight = 0;
RecipeDB.page.transient.ingredientsBodyHeight = 0;
RecipeDB.page.transient.instructionsBodyHeight = 0;
RecipeDB.page.transient.commentsBodyHeight = 0;
RecipeDB.page.transient.statusBodyHeight = 0;

RecipeDB.page.constants = {};

RecipeDB.page.constants.SECTION_HEADERS_NAME = "Recipe-Header";
RecipeDB.page.constants.DESCRIPTION_BODY_ID = "Description-Body";
RecipeDB.page.constants.INGREDIENTS_BODY_ID = "Ingredients-Body";
RecipeDB.page.constants.INSTRUCTIONS_BODY_ID = "Instructions-Body";
RecipeDB.page.constants.COMMENTS_BODY_ID = "Comments-Body";
RecipeDB.page.constants.STATUS_BODY_ID = "Status-Body";
RecipeDB.page.constants.PICTURE_ID = "Recipe-Picture";
RecipeDB.page.constants.PICTURE_EDIT_ID = "Recipe-Picture-Edit";
RecipeDB.page.constants.EDIT_BUTTON_ID = "Edit-Recipe-Button";
RecipeDB.page.constants.SAVE_BUTTON_ID = "Save-Recipe-Button";
RecipeDB.page.constants.RECIPE_TITLE_VIEW_ID = "Recipe-Title";
RecipeDB.page.constants.RECIPE_TITLE_EDIT_ID = "Recipe-Title-Edit";
RecipeDB.page.constants.RECIPE_DESCRIPTION_VIEW_ID = "Recipe-Description-Container";
RecipeDB.page.constants.RECIPE_INGREDIENTS_VIEW_ID = "Recipe-Ingredients-Container";
RecipeDB.page.constants.RECIPE_INSTRUCTIONS_VIEW_ID = "Recipe-Instructions-Container";
RecipeDB.page.constants.RECIPE_DESCRIPTION_EDIT_ID = "Recipe-Description-Edit";
RecipeDB.page.constants.RECIPE_INGREDIENTS_EDIT_ID = "Recipe-Ingredients-Edit";
RecipeDB.page.constants.RECIPE_INSTRUCTIONS_EDIT_ID = "Recipe-Instructions-Edit";
RecipeDB.page.constants.RECIPEID_ID = "RecipeID";
RecipeDB.page.constants.NOTICATION_ELEMENT_ID = "Notification-Box";
RecipeDB.page.constants.VIEW_SECTION_NAME = "ViewSection";
RecipeDB.page.constants.EDIT_SECTION_NAME = "EditSection";
RecipeDB.page.constants.PUBLISH_RECIPE_BUTTON_ID = "Publish-Recipe-Button";
RecipeDB.page.constants.PUBLISHED_STATUS_ID = "Published-Status";
RecipeDB.page.constants.DELETE_RECIPE_BUTTON = "Delete-Recipe-Button";

RecipeDB.page.init = function() {
	this.setSectionDimensions();

	$( "[name='" + this.constants.SECTION_HEADERS_NAME + "']" ).click(function() {
		this.openCloseSection(this)
	});
	$(document).resize(this.onResize);

	$("#" + this.constants.PICTURE_ID).load(this.setPictureEditDimensions);
	$("#" + this.constants.EDIT_BUTTON_ID).click(this.enableEditing);
	$("#" + this.constants.SAVE_BUTTON_ID).click(this.saveChanges);
	$("#" + this.constants.PUBLISH_RECIPE_BUTTON_ID).click(this.changePublicStatus);
	$("#" + this.constants.DELETE_RECIPE_BUTTON).click(this.deleteRecipe);

	console.log("Page init complete");
};

RecipeDB.page.onResize = function() {
	RecipeDB.page.setSectionDimensions();
	RecipeDB.page.setPictureEditDimensions();
};

RecipeDB.page.setSectionDimensions = function() {

	RecipeDB.page.transient.descriptionBodyHeight = parseFloat( 
		$("#" + RecipeDB.page.constants.DESCRIPTION_BODY_ID).css("height") 
	);
	RecipeDB.page.transient.ingredientsBodyHeight = parseFloat( 
		$("#" + RecipeDB.page.constants.INGREDIENTS_BODY_ID).css("height") 
	);
	RecipeDB.page.transient.instructionsBodyHeight = parseFloat( 
		$("#" + RecipeDB.page.constants.INSTRUCTIONS_BODY_ID).css("height") 
	);
	RecipeDB.page.transient.commentsBodyHeight = parseFloat( 
		$("#" + RecipeDB.page.constants.COMMENTS_BODY_ID).css("height") 
	);
	RecipeDB.page.transient.statusBodyHeight = parseFloat( 
		$("#" + RecipeDB.page.constants.STATUS_BODY_ID).css("height") 
	);
};

RecipeDB.page.setPictureEditDimensions = function() {

	$('#' + RecipeDB.page.constants.PICTURE_EDIT_ID).css(
		'height', 
		$('#' + RecipeDB.page.constants.PICTURE_ID).css('height')
	);

	$('#' + RecipeDB.page.constants.PICTURE_EDIT_ID).css(
		'width', 
		$('#' + RecipeDB.page.constants.PICTURE_ID).css('width')
	);
};

RecipeDB.page.openCloseSection = function(Caller) {

	var HeaderSection = Caller;
	var BodySection = Caller.nextElementSibling;
	var DesiredHeight = 0;
	var Key = "";
	var CurrentElementData = {};
	var DesiredHeightLocation = BodySection.id.substring(0, BodySection.id.indexOf("-") ).toLowerCase() + "BodyHeight";

	DesiredHeight = RecipeDB.page.transient[ DesiredHeightLocation ];

	if (typeof DesiredHeight === 'undefined' ) {
		console.warn("DesiredHeight is undefined :(");
		return false;
	};

	if ( $(BodySection).css("display") == "block" ) {
		$(BodySection).animate({height: 0}, 500, function() {
			$(BodySection).hide();
			$(HeaderSection).css({display: "block", "text-align": "center"});
		});
	}
	else {
		$(BodySection).show();
		$(BodySection).animate({height: DesiredHeight}, 500, function() {
			$(BodySection).css("height", "");
			$(HeaderSection).css({display: "inline-block", "text-align": ""});
		});
	}
};

RecipeDB.page.enableEditing = function() {

	$("#" + RecipeDB.page.constants.SAVE_BUTTON_ID).show();

	$("[name='" + RecipeDB.page.constants.VIEW_SECTION_NAME + "']").hide();
	$("[name='" + RecipeDB.page.constants.EDIT_SECTION_NAME + "']").show();

	tinyMCE.init(
		{
			selector: "textarea",
			plugins: "paste,lists,code",
			paste_as_text: true
		}
	);

	$("#" + RecipeDB.page.constants.EDIT_BUTTON_ID).unbind("click", RecipeDB.page.enableEditing);
	$("#" + RecipeDB.page.constants.EDIT_BUTTON_ID).click(RecipeDB.page.disableEditing);
};

RecipeDB.page.disableEditing = function() {
	
	$("#" + RecipeDB.page.constants.SAVE_BUTTON_ID).hide();
	tinyMCE.remove();

	$("[name='" + RecipeDB.page.constants.VIEW_SECTION_NAME + "']").show();
	$("[name='" + RecipeDB.page.constants.EDIT_SECTION_NAME + "']").hide();

	$("#" + RecipeDB.page.constants.EDIT_BUTTON_ID).unbind("click", RecipeDB.page.disableEditing);
	$("#" + RecipeDB.page.constants.EDIT_BUTTON_ID).click(RecipeDB.page.enableEditing);
};

RecipeDB.page.saveChanges = function() {

	var RecipeDescription = tinyMCE.get(RecipeDB.page.constants.RECIPE_DESCRIPTION_EDIT_ID).getContent();
	var RecipeIngredients = tinyMCE.get(RecipeDB.page.constants.RECIPE_INGREDIENTS_EDIT_ID).getContent();
	var RecipeInstructions = tinyMCE.get(RecipeDB.page.constants.RECIPE_INSTRUCTIONS_EDIT_ID).getContent();
	var RecipeTitle = document.getElementById(RecipeDB.page.constants.RECIPE_TITLE_EDIT_ID).value.trim();
	var RecipeID = parseInt(document.getElementById(RecipeDB.page.constants.RECIPEID_ID).value);

	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);

	var UpdatedRecipeData = {
		name: RecipeTitle,
		description: RecipeDescription,
		ingredients: RecipeIngredients,
		instructions: RecipeInstructions
	};

	if (RecipeDB.main.transient.ajaxCallInProgress === false) {
		RecipeDB.main.transient.ajaxCallInProgress = true
	} else {
		return false;
	};

	$.ajax({
		type: "post",
		url: "Components/AjaxProxy.cfc",
		data: {
			method: "call",
			argumentCollection: JSON.stringify({
				component: "Recipes",
				function: "updateRecipe",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					recipeid: RecipeID,
					updatedata: UpdatedRecipeData
				}
			}),
		},

		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.page.onSavedChangesSuccess();
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			RecipeDB.main.ajaxLoadIconButton(true, $('#' + RecipeDB.page.constants.SAVE_BUTTON_ID));
			RecipeDB.main.notifyUserOfLoading( MessageBox );
		},
		complete: function() {
			RecipeDB.main.ajaxLoadIconButton(false, $('#' + RecipeDB.page.constants.SAVE_BUTTON_ID));
		}
	});	
};

RecipeDB.page.onSavedChangesSuccess = function() {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);

	RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES SAVED", 2000 );

	$("#" + RecipeDB.page.constants.RECIPE_TITLE_VIEW_ID).html( 
		$("#" + RecipeDB.page.constants.RECIPE_TITLE_EDIT_ID).val()
	);
	$("#" + RecipeDB.page.constants.RECIPE_DESCRIPTION_VIEW_ID).html(
		tinyMCE.get(RecipeDB.page.constants.RECIPE_DESCRIPTION_EDIT_ID).getContent()
	);
	$("#" + RecipeDB.page.constants.RECIPE_INGREDIENTS_VIEW_ID).html(
		tinyMCE.get(RecipeDB.page.constants.RECIPE_INGREDIENTS_EDIT_ID).getContent()
	);
	$("#" + RecipeDB.page.constants.RECIPE_INSTRUCTIONS_VIEW_ID).html(
		tinyMCE.get(RecipeDB.page.constants.RECIPE_INSTRUCTIONS_EDIT_ID).getContent()
	);
};

RecipeDB.page.changePublicStatus = function() {

	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);
	var RecipeID = parseInt(document.getElementById(RecipeDB.page.constants.RECIPEID_ID).value);

	if (RecipeDB.main.transient.ajaxCallInProgress === false) {
		RecipeDB.main.transient.ajaxCallInProgress = true
	} else {
		return false;
	};

	$.ajax({
		type: "post",
		url: "Components/AjaxProxy.cfc",
		data: {
			method: "call",
			argumentCollection: JSON.stringify({
				component: "Recipes",
				function: "flipPublishedStatus",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					recipeid: RecipeID
				}
			}),
		},

		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.page.onChangedPublicStatusSuccess();
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			RecipeDB.main.ajaxLoadInnerHTML(true, $('#' + RecipeDB.page.constants.PUBLISH_RECIPE_BUTTON_ID));
			RecipeDB.main.notifyUserOfLoading( MessageBox );
		},
		complete: function() {
			RecipeDB.main.ajaxLoadInnerHTML(false, $('#' + RecipeDB.page.constants.PUBLISH_RECIPE_BUTTON_ID));
		}
	});	

};

RecipeDB.page.onChangedPublicStatusSuccess = function() {

	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);
	var PublishedStatusElement = $("#" + RecipeDB.page.constants.PUBLISHED_STATUS_ID);

	if (PublishedStatusElement.attr("class") === "true") {

		PublishedStatusElement.removeClass();
		PublishedStatusElement.addClass("false");
		PublishedStatusElement.text("no");

	} else {

		PublishedStatusElement.removeClass();
		PublishedStatusElement.addClass("true");
		PublishedStatusElement.text("yes");

	};

	RecipeDB.main.notifyUserOfSuccess( MessageBox, "VISIBILITY CHANGED", 2000 );
};

RecipeDB.page.deleteRecipe = function() {

	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);
	var RecipeID = parseInt(document.getElementById(RecipeDB.page.constants.RECIPEID_ID).value);

	if (window.confirm("Are you sure you want to delete this recipe? This cannot be undone") === false ) {
		return false;
	};

	if (RecipeDB.main.transient.ajaxCallInProgress === false) {
		RecipeDB.main.transient.ajaxCallInProgress = true
	} else {
		return false;
	};

	$.ajax({
		type: "post",
		url: "Components/AjaxProxy.cfc",
		data: {
			method: "call",
			argumentCollection: JSON.stringify({
				component: "Recipes",
				function: "deleteRecipe",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					recipeid: RecipeID
				}
			}),
		},

		dataType: "json",

		success: function(ResponseData) {
			var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);
			RecipeDB.main.notifyUserOfSuccess( MessageBox, "RECIPE DELETED" );

			setTimeout(
				function() {
					window.location.href = "FindRecipes.cfm";
				},
				500
			);
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			RecipeDB.main.notifyUserOfLoading(MessageBox);
		}
	});	

};