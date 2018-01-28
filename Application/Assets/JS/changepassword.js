"use strict";
RecipeDB.page = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants = {};
RecipeDB.page.constants.SHOW_PASSWORDS_BUTTON_ID = "Show-Password-Button";
RecipeDB.page.constants.CHANGE_PASSWORD_BUTTON_ID = "Change-Password-Button";
RecipeDB.page.constants.NOTIFICATION_BOX_ID = "Notification-Box";
RecipeDB.page.constants.CHANGE_PASSWORD_FIELDS_NAME = "Change-Password";
RecipeDB.page.constants.FIRST_NEW_PASSWORD_FIELD_ID = "Change-Password-1";
RecipeDB.page.constants.SECOND_NEW_PASSWORD_FIELD_ID = "Change-Password-2";

RecipeDB.page.init = function() {

	$("#"+ this.constants.SHOW_PASSWORDS_BUTTON_ID).click(this.flipPasswordFieldTypes);
	$("#"+ this.constants.CHANGE_PASSWORD_BUTTON_ID).click(this.changePassword);

	console.log("Page init complete");
};

RecipeDB.page.flipPasswordFieldTypes = function() {
	var PasswordFields = $("[name='" + RecipeDB.page.constants.CHANGE_PASSWORD_FIELDS_NAME + "']" );
	var ShowPasswordCharactersField = $("#" + RecipeDB.page.constants.SHOW_PASSWORDS_BUTTON_ID);

	if (PasswordFields.attr("type") === "password") {
		PasswordFields.attr("type", "text");
		ShowPasswordCharactersField.val("HIDE CHARACTERS");
	}
	else if (PasswordFields.attr("type") === "text") {
		PasswordFields.attr("type", "password");
		ShowPasswordCharactersField.val("SHOW CHARACTERS");
	}
};

RecipeDB.page.changePassword = function() {

	var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);
	var NewPasswordField1 = $("#" + RecipeDB.page.constants.FIRST_NEW_PASSWORD_FIELD_ID);
	var NewPasswordField2 = $("#" + RecipeDB.page.constants.SECOND_NEW_PASSWORD_FIELD_ID);

	var MinLength = 4;
	var MaxLength = 24;
	var ValidationFail = false;
	var ValidationErrorText = "";

	MessageBox.hide();

	if (NewPasswordField1.val().length === 0 || NewPasswordField1.val() === "") {
		ValidationErrorText = "The new password is empty";
		ValidationFail = true;
	};

	if (ValidationFail === false && NewPasswordField1.val().trim().length < 4) {
		ValidationErrorText = "The new password is less than 4 characters";
		ValidationFail = true;
	};

	if (ValidationFail === false && NewPasswordField1.val().trim().length > 24) {
		ValidationErrorText = "The new password is greater than 24 characters";
		ValidationFail = true;
	};

	if (ValidationFail === false && (NewPasswordField2.val().length === 0 || NewPasswordField2.val() === "")) {
		ValidationErrorText = "The second new password is empty";
		ValidationFail = true;
	};

	if (ValidationFail === false && NewPasswordField2.val().trim().length < 4) {
		ValidationErrorText = "The second new password is less than 4 characters";
		ValidationFail = true;
	};

	if (ValidationFail === false && NewPasswordField2.val().trim().length > 24) {
		ValidationErrorText = "The second new password is greater than 24 characters";
		ValidationFail = true;
	};

	if (ValidationFail === false && (NewPasswordField1.val() !== NewPasswordField2.val())) {
		ValidationErrorText = "The two passwords aren't the same";
		ValidationFail = true;
	};

	if (ValidationFail) {
		RecipeDB.main.notifyUserOfError(MessageBox, ValidationErrorText, 3000);
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
				controller: "ChangePassword",
				authKey: RecipeDB.main.constants.AUTH_KEY,
				parameters: {
					newPassword: NewPasswordField2.val().trim()
				}
			}),
		},

		dataType: "json",

		success: function(ResponseData) {
			var MessageBox = $("#" + RecipeDB.page.constants.NOTIFICATION_BOX_ID);
			RecipeDB.main.notifyUserOfSuccess( MessageBox, "PASSWORD CHANGED" );

			setTimeout(
				function() {
					window.location.href = "MySettings.cfm";
				},
				1000
			);
		},
		error: function() {
			RecipeDB.main.onAJAXCallError(arguments);
			RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.page.constants.CHANGE_PASSWORD_BUTTON_ID));
		},
		beforeSend: function() {
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.page.constants.CHANGE_PASSWORD_BUTTON_ID));
		}
	});	

};