"use strict";
RecipeDB.page = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.MESSAGEBOX_ID = "Notification-Box";
RecipeDB.page.constants.LOGIN_BUTTON_ID = "Login-Button";
RecipeDB.page.constants.PASSWORD_FIELD_ID = "Password";
RecipeDB.page.constants.USERNAME_FIELD_ID = "Username";
RecipeDB.page.constants.LOGIN_FORM_ID = "Login-Form";

RecipeDB.page.init = function() {

	if ( document.querySelector("nav#side-menu") !== null ) {
		window.location.replace("../Login.cfm");
		return false;
	};

	$("#" + this.constants.LOGIN_BUTTON_ID).click(RecipeDB.page.attemptLogin);
};

RecipeDB.page.attemptLogin = function() {

	var MessageBox = $('#' + RecipeDB.page.constants.MESSAGEBOX_ID);
	var PasswordField = $('#' + RecipeDB.page.constants.PASSWORD_FIELD_ID);
	var UsernameField = $('#' + RecipeDB.page.constants.USERNAME_FIELD_ID);
	var LoginButton = $('#' + RecipeDB.page.constants.LOGIN_BUTTON_ID);

	MessageBox.hide();

	if ( UsernameField.val().trim().length === 0) {

		RecipeDB.main.notifyUserOfError(MessageBox, "Please enter a username");
		return false;
	};

	if ( PasswordField.val().trim().length === 0) {
		RecipeDB.main.notifyUserOfError(MessageBox, "Please enter a password");
		return false;
	};

	RecipeDB.main.ajaxLoadButton(true, LoginButton);
	document.getElementById(RecipeDB.page.constants.LOGIN_FORM_ID).submit();
};