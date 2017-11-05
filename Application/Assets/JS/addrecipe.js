"use strict";
RecipeDB.page = {};
RecipeDB.page.transient = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.DUPLICATE_ALERT_BOX_ID = "AddRecipe-DuplicateAlertBox";
RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID = "AddNewRecipe-Button";
RecipeDB.page.constants.ADD_RECIPE_ANYWAY_FLAG_ID = "AddNewRecipe-Anyway";
RecipeDB.page.constants.NEW_RECIPE_NAME_ID = "AddRecipe-Name";
RecipeDB.page.constants.MESSAGEBOX_ID = "Notification-Box";
RecipeDB.page.constants.DUPLICATE_CHECK_CHECKBOX_ID = "DuplicateCheck";

RecipeDB.page.addNewRecipe = function() {
	var RecipeName = $("#" + RecipeDB.page.constants.NEW_RECIPE_NAME_ID).val();
	var CheckForDuplicates = $("#" + RecipeDB.page.constants.DUPLICATE_CHECK_CHECKBOX_ID).prop("checked");
	var AddNewRecipeAnyway = $("#" + RecipeDB.page.constants.ADD_RECIPE_ANYWAY_FLAG_ID).val();
	var MessageBox = $("#" + RecipeDB.page.constants.MESSAGEBOX_ID);

	if ( AddNewRecipeAnyway == 1) {
		CheckForDuplicates = false;
	};

	$('#' + RecipeDB.page.constants.DUPLICATE_ALERT_BOX_ID).hide();

	if (RecipeName.length === "" || RecipeName.length === 0) {

		RecipeDB.main.removeAlertClasses(MessageBox);
		MessageBox.addClass("red-error-text");
		MessageBox.html("The name of the recipe can't be blank. Please fill in something.");
		MessageBox.fadeIn(1000);

		return false;
	};

	$.ajax({
		type: "post",
		url: "Components/AjaxProxy.cfc",
		data: {
			method: "call",
			argumentCollection: JSON.stringify({
				component: "Recipes",
				function: "addNewRecipe",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					name: RecipeName,
					checkforduplicates: CheckForDuplicates
				}
			}),
		},

		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.page.onAddRecipeSuccess(ResponseData);
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			MessageBox.hide().html("");
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID));
		},
		complete: function() {
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID), "OK");
		}
	});
};

RecipeDB.page.onAddRecipeSuccess = function(AjaxResponse) {
	if (AjaxResponse instanceof Object === false && typeof AjaxResponse.NewRecipeID === "undefined") {
		RecipeDB.main.onAJAXCallError();
	};

	var DuplicateAlertBox = $("#" + RecipeDB.page.constants.DUPLICATE_ALERT_BOX_ID);

	if (AjaxResponse.DuplicatesFound === true) {
		DuplicateAlertBox.html( AjaxResponse.DuplicatesView );
		DuplicateAlertBox.fadeIn(1000);
		$("#" + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID).val("ADD ANYWAY");
		$("#" + RecipeDB.page.constants.ADD_RECIPE_ANYWAY_FLAG_ID).val(1);
		return false;
	};

	window.location.href = "Recipe.cfm?RecipeID=" + AjaxResponse.NewRecipeID;
};

RecipeDB.page.init = function() {
	$("#" + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID).click(function() {
		RecipeDB.page.addNewRecipe(false);
	});
};