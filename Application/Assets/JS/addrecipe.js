"use strict";

RecipeDB.page = {};
RecipeDB.page.transient = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID = "AddNewRecipe-Button";
RecipeDB.page.constants.NEW_RECIPE_NAME_ID = "AddRecipe-Name";
RecipeDB.page.constants.MESSAGEBOX_ID = "Notification-Box";

RecipeDB.page.init = function() {
	$("#" + this.constants.ADD_RECIPE_BUTTON_ID).click(this.addNewRecipe);
	console.log("Page init complete");
};

RecipeDB.page.addNewRecipe = function() {
	var RecipeName = $("#" + RecipeDB.page.constants.NEW_RECIPE_NAME_ID).val();
	var MessageBox = $("#" + RecipeDB.page.constants.MESSAGEBOX_ID);

	if (RecipeName.trim().length === 0) {
		RecipeDB.main.notifyUserOfError(MessageBox, "The name of the recipe cannot be empty", 4000);
		return false;
	};

	if (RecipeDB.main.transient.ajaxCallInProgress === false) {
		RecipeDB.main.transient.ajaxCallInProgress = true
	} else {
		return false;
	};

	$.ajax({
		type: "post",
		timeout: RecipeDB.main.constants.AJAX_TIMEOUT,
		url: "Components/AjaxProxy.cfc",
		data: {
			method: "call",
			argumentCollection: JSON.stringify({
				component: "Recipes",
				function: "addNewRecipe",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					name: RecipeName
				}
			}),
		},

		dataType: "json",

		success: function(ResponseData) {
			if (ResponseData instanceof Object === false && typeof ResponseData.data === "undefined") {
				RecipeDB.main.onAJAXCallError(arguments);
			};

			RecipeDB.main.notifyUserOfSuccess( $("#" + RecipeDB.page.constants.MESSAGEBOX_ID), "RECIPE ADDED" );

			setTimeout(
				function() {
					window.location.href = "Recipe.cfm?RecipeID=" + parseInt(ResponseData.data)
				},
				1000
			);
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID));
		},
		complete: function() {
			RecipeDB.main.transient.ajaxCallInProgress = false;
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID));
		}
	});
};