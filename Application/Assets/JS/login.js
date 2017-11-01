"use strict";
RecipeDB.page = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.MESSAGEBOX_ID = "Notification-Box";
RecipeDB.page.constants.LOGIN_BUTTON_ID = "Login-Button";
RecipeDB.page.constants.PASSWORD_FIELD_ID = "Password";
RecipeDB.page.constants.USERNAME_FIELD_ID = "Username";
RecipeDB.page.constants.LOGIN_FORM_ID = "Login-Form";

RecipeDB.page.init = function() {

	if ( document.querySelector("nav#side-menu") != null ) {
		window.location.replace("../Login.cfm");
		return false;
	};

	$("#" + this.constants.LOGIN_BUTTON_ID).click(function() {
		RecipeDB.page.attemptLogin();
	});

};

RecipeDB.page.attemptLogin = function() {
	var MessageBox = $('#' + this.constants.MESSAGEBOX_ID);
	var PasswordField = $('#' + this.constants.PASSWORD_FIELD_ID);
	var UsernameField = $('#' + this.constants.USERNAME_FIELD_ID);
	var LoginButton = $('#' + RecipeDB.page.constants.LOGIN_BUTTON_ID);

	MessageBox.removeClass("green-success-text");
	MessageBox.addClass("red-error-text");
	MessageBox.hide();

	if ( UsernameField.val().length === 0 || UsernameField.val() === " " ) {
		MessageBox.html("Please enter a username");
		MessageBox.fadeIn(1000);
		return false;
	};

	if ( PasswordField.val().length === 0 || PasswordField.val() === " " ) {
		MessageBox.html("Please enter a password");
		MessageBox.fadeIn(1000);
		return false;
	};

	$('#' + RecipeDB.page.constants.LOGIN_BUTTON_ID).val("");
	$('#' + RecipeDB.page.constants.LOGIN_BUTTON_ID).addClass("ajax-loading");
	document.getElementById(this.constants.LOGIN_FORM_ID).submit();
};