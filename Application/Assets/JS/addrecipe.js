"use strict";

RecipeDB.page = {};
RecipeDB.page.transient = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID = "AddNewRecipe-Button";
RecipeDB.page.constants.NEW_RECIPE_NAME_ID = "AddRecipe-Name";
RecipeDB.page.constants.MESSAGEBOX_ID = "Notification-Box";

RecipeDB.page.addNewRecipe = function() {
	var RecipeName = $("#" + RecipeDB.page.constants.NEW_RECIPE_NAME_ID).val();
	var MessageBox = $("#" + RecipeDB.page.constants.MESSAGEBOX_ID);

	if (RecipeName.length === "" || RecipeName.length === 0) {

		RecipeDB.main.removeAlertClasses(MessageBox);
		MessageBox.addClass("red-error-text");
		MessageBox.html("The name of the recipe can't be blank. Please fill in something.");
		MessageBox.fadeIn(1000).delay(3000).fadeOut();

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
					name: RecipeName
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
			MessageBox.html("");
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID));

			RecipeDB.main.removeAlertClasses(MessageBox);
			MessageBox.addClass("yellow-warning-text");
			RecipeDB.main.ajaxLoadInnerHTML(true, MessageBox);
			
			MessageBox.show();
		},
		complete: function() {
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID), "ADD");
		}
	});
};

RecipeDB.page.onAddRecipeSuccess = function(AjaxResponse) {
	if (AjaxResponse instanceof Object === false && typeof AjaxResponse.data === "undefined") {
		RecipeDB.main.onAJAXCallError();
	};

	var MessageBox = $("#" + RecipeDB.page.constants.MESSAGEBOX_ID);

	RecipeDB.main.removeAlertClasses(MessageBox);
	MessageBox.addClass("green-success-text");

	RecipeDB.main.ajaxLoadInnerHTML(false, MessageBox);
	MessageBox.html("NEW RECIPE ADDED");
	MessageBox.show();

	setTimeout(
		function() {
			window.location.href = "Recipe.cfm?RecipeID=" + AjaxResponse.data
		},
		500
	);
};

RecipeDB.page.init = function() {
	$("#" + RecipeDB.page.constants.ADD_RECIPE_BUTTON_ID).click(function() {
		RecipeDB.page.addNewRecipe();
	});

	console.log("Page init complete");
};