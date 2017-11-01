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
RecipeDB.page.constants.RECIPE_TITLE_EDIT_ID = "Recipe-Title-Edit";
RecipeDB.page.constants.RECIPE_DESCRIPTION_EDIT_ID = "Recipe-Description-Edit";
RecipeDB.page.constants.RECIPE_INGREDIENTS_EDIT_ID = "Recipe-Ingredients-Edit";
RecipeDB.page.constants.RECIPE_INSTRUCTIONS_EDIT_ID = "Recipe-Instructions-Edit";
RecipeDB.page.constants.RECIPEID_ID = "RecipeID";
RecipeDB.page.constants.NOTICATION_ELEMENT_ID = "Notification-Box";
RecipeDB.page.constants.VIEW_SECTION_NAME = "ViewSection";
RecipeDB.page.constants.EDIT_SECTION_NAME = "EditSection";

RecipeDB.page.init = function() {
	this.setSectionDimensions();

	$( "[name='" + this.constants.SECTION_HEADERS_NAME + "']" ).click(function() {
		RecipeDB.page.openCloseSection(this)
	});

	$("#" + this.constants.PICTURE_ID).load(function() {
		RecipeDB.page.setPictureEditDimensions();
	});

	$(document).resize( function() {
		RecipeDB.page.onResize();
	});

	$("#" + this.constants.EDIT_BUTTON_ID).click(
		RecipeDB.page.enableEditing
	);

	$("#" + this.constants.SAVE_BUTTON_ID).click(
		RecipeDB.page.saveChanges
	);

	$(document).resize(function() {
		RecipeDB.page.onResize();
	});

	console.log("Page init complete");
};

RecipeDB.page.onResize = function() {
	this.setSectionDimensions();
	this.setPictureEditDimensions();
};

RecipeDB.page.setSectionDimensions = function() {

	this.transient.descriptionBodyHeight = parseFloat( 
		$("#" + this.constants.DESCRIPTION_BODY_ID).css("height") 
	);

	this.transient.ingredientsBodyHeight = parseFloat( 
		$("#" + this.constants.INGREDIENTS_BODY_ID).css("height") 
	);

	this.transient.instructionsBodyHeight = parseFloat( 
		$("#" + this.constants.INSTRUCTIONS_BODY_ID).css("height") 
	);

	this.transient.commentsBodyHeight = parseFloat( 
		$("#" + this.constants.COMMENTS_BODY_ID).css("height") 
	);

	this.transient.statusBodyHeight = parseFloat( 
		$("#" + this.constants.STATUS_BODY_ID).css("height") 
	);
};

RecipeDB.page.setPictureEditDimensions = function() {

	$('#' + this.constants.PICTURE_EDIT_ID).css(
		'height', 
		$('#' + this.constants.PICTURE_ID).css('height')
	);

	$('#' + this.constants.PICTURE_EDIT_ID).css(
		'width', 
		$('#' + this.constants.PICTURE_ID).css('width')
	);
};

RecipeDB.page.openCloseSection = function(Caller) {

	var HeaderSection = Caller;
	var BodySection = Caller.nextElementSibling;
	var DesiredHeight = 0;
	var Key = "";
	var CurrentElementData = {};
	var DesiredHeightLocation = BodySection.id.substring(0, BodySection.id.indexOf("-") ).toLowerCase() + "BodyHeight";

	DesiredHeight = this.transient[ DesiredHeightLocation ];

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
	$("#" + RecipeDB.page.constants.EDIT_BUTTON_ID).html("Disable editing");

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
	$("#" + RecipeDB.page.constants.EDIT_BUTTON_ID).html("Make editable");
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

	var UpdatedRecipeData = {
		name: RecipeTitle,
		description: RecipeDescription,
		ingredients: RecipeIngredients,
		instructions: RecipeInstructions
	};

	$.ajax({
		type: "post",
		url: "Controllers/Recipes.cfc",
		data: {
			method: "updateRecipe",
			recipeid: RecipeID,
			updatedata: JSON.stringify(UpdatedRecipeData)
		},
		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.page.onSavedChangesSuccess();
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			$("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID).show();
		}
	});	
};

RecipeDB.page.onSavedChangesSuccess = function() {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);

	MessageBox.removeClass("green-success-text");
	MessageBox.html("Changes saved!");
	tinyMCE.remove();

	$("[name='" + RecipeDB.page.constants.EDIT_SECTION_NAME + "']").hide();
	$("[name='" + RecipeDB.page.constants.VIEW_SECTION_NAME + "']").show();

	$("#" + RecipeDB.page.constants.SAVE_BUTTON_ID).show();
	MessageBox.delay(3000).fadeOut();
};