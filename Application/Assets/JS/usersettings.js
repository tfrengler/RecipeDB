"use strict";
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
	listType: "",
	sortOnColumn: "",
	filter: {
		mineOnly: false,
		minePublic: false,
		minePrivate: false,
		mineEmpty: false,
		mineNoPicture: false,
		othersOnly: false
	}
};

RecipeDB.page.init = function() {
	$("#" + this.constants.SAVE_USER_BUTTON_ID).click(this.saveUserChanges);
	$("#" + this.constants.SAVE_FINDRECIPES_BUTTON_ID).click(this.saveFindRecipesChanges);

	$("input[name='" + this.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME + "']").click(this.onChangeFindRecipesSetting);
	$("input[name='" + this.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME + "']").click(this.onChangeFindRecipesSetting);
	$("input[name='" + this.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME + "']").click(this.onChangeFindRecipesSetting);

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
	};
	if (Username.length === 0 || Username === " ") {
		if (NotificationMessage.length > 0) {
			NotificationMessage += "<br/>"
		}
		NotificationMessage += "User name is empty!";
	};

	if (NotificationMessage.length > 0) {

		RecipeDB.main.notifyUserOfError( MessageBox, NotificationMessage, 2000 );
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
		RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES SAVED", 2000 );
	}
	else if (ControllerResponse.statuscode === 2) {
		RecipeDB.main.notifyUserOfError( MessageBox, "That username is already in use. Please choose another", 4000 );
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
			RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES SAVED", 2000 );
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

	if (checkbox.prop("name") === RecipeDB.page.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME) {
		$("input[name='" + RecipeDB.page.constants.FIND_RECIPES_FILTER_CHECKBOXES_NAME + "']").prop("checked", false);
		checkbox.prop("checked", true);

		for (option in RecipeDB.page.transient.findRecipesSettings.filter) {
			RecipeDB.page.transient.findRecipesSettings.filter[option] = false;
		};

		RecipeDB.page.transient.findRecipesSettings.filter[ checkbox.val() ] = checkbox.prop("checked");
		return true;
	};

	if (checkbox.prop("name") === RecipeDB.page.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME) {
		$("input[name='" + RecipeDB.page.constants.FIND_RECIPES_SORT_ON_CHECKBOXES_NAME + "']").prop("checked", false);
		checkbox.prop("checked", true);
		
		RecipeDB.page.transient.findRecipesSettings.sortOnColumn = checkbox.val();
		return true;
	}
	
	if (checkbox.prop("name") === RecipeDB.page.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME) {
		$("input[name='" + RecipeDB.page.constants.FIND_RECIPES_LIST_TYPE_CHECKBOXES_NAME + "']").prop("checked", false);
		checkbox.prop("checked", true);

		RecipeDB.page.transient.findRecipesSettings.listType = checkbox.val();
		return true;
	};
};