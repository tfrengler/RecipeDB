"use strict";

/* ESLint rules */
/* global RecipeDB:readonly */
/* global $:readonly */

RecipeDB.page = {};
RecipeDB.page.constants = {};
RecipeDB.page.transient = {};

RecipeDB.page.constants.DISPLAYNAME_BOX_ID = "DisplayName";
RecipeDB.page.constants.USERNAME_BOX_ID = "Username";
RecipeDB.page.constants.SAVE_USER_BUTTON_ID = "Save-User-Settings-Button";
RecipeDB.page.constants.SAVE_FINDRECIPES_BUTTON_ID = "Save-FindRecipes-Settings-Button";
RecipeDB.page.constants.NOTIFICATION_BOX_ID = "Notification-Box";
RecipeDB.page.constants.CHANGE_PASSWORD_ID = "Change-Password-Button";
RecipeDB.page.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME = "FindRecipes-Filter";
RecipeDB.page.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME = "FindRecipes-SortOn";
RecipeDB.page.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME = "FindRecipes-ListType";

RecipeDB.page.transient.findRecipesSettings = {
	listType: undefined,
	sortOnColumn: undefined,
	filter: {
		mineOnly: undefined,
		minePublic: undefined,
		minePrivate: undefined,
		mineEmpty: undefined,
		mineNoPicture: undefined,
		othersOnly: undefined
	}
};

RecipeDB.page.init = function() {

	document.querySelector("#User-Settings-Form").addEventListener("submit", event=> event.preventDefault());
	document.querySelector("#RecipeList-Settings-Form").addEventListener("submit", event=> event.preventDefault());

	$("#" + this.constants.SAVE_USER_BUTTON_ID).click(this.saveUserChanges);
	$("#" + this.constants.SAVE_FINDRECIPES_BUTTON_ID).click(this.saveFindRecipesChanges);

	$("input[name='" + this.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME + "']").click(this.onChangeFindRecipesSetting);
	$("input[name='" + this.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME + "']").click(this.onChangeFindRecipesSetting);
	$("input[name='" + this.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME + "']").click(this.onChangeFindRecipesSetting);

	$("input[name='" + this.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME + "']").each(function() {
		if ($(this).prop("checked")) {
			RecipeDB.page.transient.findRecipesSettings.listType = $(this).val()
		}
	});

	$("input[name='" + this.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME + "']").each(function() {
		if ($(this).prop("checked")) {
			RecipeDB.page.transient.findRecipesSettings.sortOnColumn = $(this).val()
		}
	});

	this.transient.findRecipesSettings.filter.mineOnly = $("input[value='mineOnly']").prop("checked");
	this.transient.findRecipesSettings.filter.minePublic = $("input[value='minePublic']").prop("checked");
	this.transient.findRecipesSettings.filter.minePrivate = $("input[value='minePrivate']").prop("checked");
	this.transient.findRecipesSettings.filter.mineEmpty = $("input[value='mineEmpty']").prop("checked");
	this.transient.findRecipesSettings.filter.mineNoPicture = $("input[value='mineNoPicture']").prop("checked");
	this.transient.findRecipesSettings.filter.othersOnly = $("input[value='othersOnly']").prop("checked");

	console.log("Page init complete");
};

RecipeDB.page.saveUserChanges = function() {
	var NotificationMessage = "";

	var DisplayName = document.getElementById(RecipeDB.page.constants.DISPLAYNAME_BOX_ID).value.trim();
	var Username = document.getElementById(RecipeDB.page.constants.USERNAME_BOX_ID).value.trim();

	var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);
	MessageBox.html("");

	if (DisplayName.length === 0 || DisplayName === " ") {
		NotificationMessage += "Display name is empty!";
	}
	if (Username.length === 0 || Username === " ") {
		if (NotificationMessage.length > 0) {
			NotificationMessage += "<br/>"
		}
		NotificationMessage += "User name is empty!";
	}

	if (NotificationMessage.length > 0) {

		RecipeDB.main.notifyUserOfError( MessageBox, NotificationMessage, 2000 );
		return false;
	}

	if (RecipeDB.main.transient.ajaxCallInProgress === false) {
		RecipeDB.main.transient.ajaxCallInProgress = true
	} else {
		return false;
	}

	$.ajax({
		type: "post",
		timeout: RecipeDB.main.constants.AJAX_TIMEOUT,
		url: "Components/AjaxProxy.cfc",
		data: {
			method: "call",
			argumentCollection: JSON.stringify({
				controller: "ChangeUserSettings",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					newusername: Username,
					newdisplayName: DisplayName
				}
			}),
		},
		dataType: "json",

		beforeSend: function() {
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.SAVE_USER_BUTTON_ID));
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		success: function() {
			RecipeDB.page.onUserChangesSaved(arguments[0])
		},
		complete: function() {
			RecipeDB.main.transient.ajaxCallInProgress = false;
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.SAVE_USER_BUTTON_ID));
		}
	});

	return true;
};

RecipeDB.page.onUserChangesSaved = function(ControllerResponse) {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);

	if (ControllerResponse.statuscode === 0) {
		RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES SAVED", true );
	}
	else if (ControllerResponse.statuscode === 2) {
		RecipeDB.main.notifyUserOfError( MessageBox, "That username is already in use. Please choose another", true );
	}
	else if (ControllerResponse.statuscode === 1) {
		RecipeDB.main.onJavascriptError(ControllerResponse, "RecipeDB.page.onUserChangesSaved");
	}
};

RecipeDB.page.saveFindRecipesChanges = function() {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);

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
				controller: "ChangeFindRecipesSettings",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					settings: RecipeDB.page.transient.findRecipesSettings
				}
			}),
		},
		dataType: "json",

		beforeSend: function() {
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.SAVE_FINDRECIPES_BUTTON_ID));
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		success: function() {
			RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES SAVED", true );
		},
		complete: function() {
			RecipeDB.main.transient.ajaxCallInProgress = false;
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.SAVE_FINDRECIPES_BUTTON_ID));
		}
	});

	return true;
};

RecipeDB.page.onChangeFindRecipesSetting = function() {
	var checkbox = $(this);
	var option = "";

	// Filters have more complex combinations of conditions that are allowed
	if (checkbox.prop("name") === RecipeDB.page.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME) {

		// If the filter setting we clicked is mineOnly or othersOnly...
		if (checkbox.val() === "mineOnly" || checkbox.val() === "othersOnly") {
			// ...then deselect all other options in memory...
			for (option in RecipeDB.page.transient.findRecipesSettings.filter) {
				RecipeDB.page.transient.findRecipesSettings.filter[option] = false
			};
			// ...then set the memory value to whatever the DOM element is checked as...
			RecipeDB.page.transient.findRecipesSettings.filter[ checkbox.val() ] = checkbox.prop("checked");
			// ...then uncheck all checkboxes on the page...
			$("[name='" + RecipeDB.page.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME + "']").prop("checked", false);
			// ...if the value if the checkbox we just clicked is true then re-check it in the DOM
			if ( RecipeDB.page.transient.findRecipesSettings.filter[ checkbox.val() ] === true ) {
				checkbox.prop("checked", true)
			};

		} // And if the filter setting is NOT any of these two..
		else if (checkbox.val() !== "mineOnly" || checkbox.val() !== "othersOnly") {
			// ...then de-select those two
			$("[value='mineOnly']").prop("checked", false);
			$("[value='othersOnly']").prop("checked", false);
		}

		RecipeDB.page.transient.findRecipesSettings.filter[ checkbox.val() ] = checkbox.prop("checked");
		return true;
	};

	if (checkbox.prop("name") === RecipeDB.page.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME) {
		RecipeDB.page.transient.findRecipesSettings.sortOnColumn = checkbox.val();
		return true;
	};

	if (checkbox.prop("name") === RecipeDB.page.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME) {
		RecipeDB.page.transient.findRecipesSettings.listType = checkbox.val();
		return true;
	};
};