"use strict";
RecipeDB.page = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.DISPLAYNAME_BOX_ID = "DisplayName";
RecipeDB.page.constants.USERNAME_BOX_ID = "Username";
RecipeDB.page.constants.SAVE_BUTTON_ID = "Save-UserSettings-Button";
RecipeDB.page.constants.NOTIFICATION_BOX_ID = "Notification-Box";
RecipeDB.page.constants.CHANGE_PASSWORD_ID = "Change-Password-Button";

RecipeDB.page.init = function() {
	$("#" + this.constants.SAVE_BUTTON_ID).click(this.saveChanges);
	console.log("Page init complete");
};

RecipeDB.page.saveChanges = function() {
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
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.SAVE_BUTTON_ID));
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		success: function() {
			RecipeDB.page.onChangesSaved(arguments[0])
		},
		complete: function() {
			RecipeDB.main.transient.ajaxCallInProgress = false;
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.SAVE_BUTTON_ID));
		}
	});

	return true;
};

RecipeDB.page.onChangesSaved = function(ControllerResponse) {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);

	if (ControllerResponse.statuscode === 0) {
		RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES SAVED", 2000 );
	}
	else if (ControllerResponse.statuscode === 2) {
		RecipeDB.main.notifyUserOfError( MessageBox, "That username is already in use. Please choose another", 4000 );
	}
	else if (ControllerResponse.statuscode === 1) {
		RecipeDB.main.onJavascriptError(ControllerResponse, "RecipeDB.page.onChangesSaved");
	} 
};