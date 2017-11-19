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

		RecipeDB.main.removeAlertClasses(MessageBox);
		MessageBox.addClass("red-error-text");

		MessageBox.html(NotificationMessage);
		MessageBox.fadeIn(1000);
		MessageBox.delay(2000).fadeOut();

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
				component: "Users",
				function: "changeUserSettings",
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
			var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);
			RecipeDB.main.notifyUserOfSuccess( MessageBox, "CHANGES CHANGED", 2000 );
		},
		complete: function() {
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.SAVE_BUTTON_ID));
		}
	});

	return true;
};