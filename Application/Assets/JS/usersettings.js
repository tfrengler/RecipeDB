"use strict";
RecipeDB.page = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.DISPLAYNAME_BOX_ID = "DisplayName";
RecipeDB.page.constants.USERNAME_BOX_ID = "Username";
RecipeDB.page.constants.SAVE_BUTTON_ID = "Save-UserSettings-Button";
RecipeDB.page.constants.NOTIFICATION_BOX_ID = "Notification-Box";

RecipeDB.page.init = function() {
	$("#" + this.constants.SAVE_BUTTON_ID).click(
		RecipeDB.page.saveChanges
	);
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

		$(MessageBox).removeClass("success-box");
		$(MessageBox).addClass("error-box");

		$(MessageBox).html(NotificationMessage);
		$(MessageBox).show();
		$(MessageBox).delay(3000).fadeOut();

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

		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
		},
		success: function() {
			RecipeDB.page.onSaveChangesSuccess()
		}
	});

	return true;
};

RecipeDB.page.onSaveChangesSuccess = function() {

	var MessageBox = $("#" + this.constants.NOTIFICATION_BOX_ID);
	MessageBox.html("");

	$(MessageBox).removeClass("red-error-text");
	$(MessageBox).addClass("green-success-text");

	$(MessageBox).html("Changes saved");
	$(MessageBox).fadeIn(1000);
	$(MessageBox).delay(3000).fadeOut();

};