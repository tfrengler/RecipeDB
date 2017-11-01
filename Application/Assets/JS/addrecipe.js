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
	var RecipeName = $("#" + RecipeDB.AddRecipe.DOM.ElementData.NewRecipeName.ID).val();
	var CheckForDuplicates = $("#" + RecipeDB.AddRecipe.DOM.ElementData.DuplicateCheckBox.ID).prop("checked");
	var AddNewRecipeAnyway = $("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeAnywayFlag.ID).val();;

	if ( AddNewRecipeAnyway == 1) {
		CheckForDuplicates = false;
	};

	$('#' + RecipeDB.AddRecipe.DOM.ElementData.DuplicateAlertBox.ID).hide();

	if (RecipeName.length === "" || RecipeName.length === 0) {
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.MessageBox.ID).html("The name of the recipe can't be blank. Please fill in something.");
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.MessageBox.ID).fadeIn(1000);
		return false;
	};

	$.ajax({
		type: "post",
		url: "Controllers/Recipes.cfc",
		data: {
			method: "addNewRecipe",
			Name: RecipeName,
			CheckForDuplicates: CheckForDuplicates
		},
		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.Utils.ajaxLoadButton(
				false,
				$('#' + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID),
				"OK"
			);
			RecipeDB.AddRecipe.Methods.onAddRecipeSuccess(ResponseData);
		},
		error: function() {
			RecipeDB.Main.Methods.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			$("#" + RecipeDB.AddRecipe.DOM.ElementData.MessageBox.ID).hide().html("");

			RecipeDB.Utils.ajaxLoadButton(
				true,
				$('#' + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID)
			);
		},
		complete: function() {

		}
	});
};

RecipeDB.page.onAddRecipeSuccess = function(AjaxResponse) {
	if (AjaxResponse instanceof Object === false && typeof AjaxResponse.NewRecipeID === "undefined") {
		RecipeDB.Main.onAJAXCallError();
	};

	if (AjaxResponse.DuplicatesFound === true) {
		$('#' + RecipeDB.AddRecipe.DOM.ElementData.DuplicateAlertBox.ID).html( AjaxResponse.DuplicatesView );
		$('#' + RecipeDB.AddRecipe.DOM.ElementData.DuplicateAlertBox.ID).fadeIn(1000);
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID).val("ADD ANYWAY");
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeAnywayFlag.ID).val(1);
		return false;
	}

	RecipeDB.Recipe.Methods.viewRecipe( AjaxResponse.NewRecipeID );
};

RecipeDB.page.init = function() {
	$("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID).click(function() {
		RecipeDB.AddRecipe.Methods.addNewRecipe(false);
	});
};