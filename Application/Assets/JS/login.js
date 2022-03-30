"use strict";

/* ESLint rules */
/* global RecipeDB:readonly */

const Elements = Object.freeze({

	MESSAGEBOX 		: ()=> document.querySelector("#Notification-Box"),
	LOGIN_BUTTON 	: ()=> document.querySelector("#Login-Button"),
	PASSWORD_FIELD 	: ()=> document.querySelector("#Password"),
	USERNAME_FIELD 	: ()=> document.querySelector("#Username"),
	LOGIN_FORM 		: ()=> document.querySelector("#Login-Form")

});

const Init = function() {

	// if ( document.querySelector("nav#side-menu") !== null ) {
	// 	window.location.replace("../Login.cfm");
	// 	return;
	// }

	Elements.LOGIN_BUTTON().addEventListener("click", AttemptLogin);
	Elements.LOGIN_FORM().addEventListener("submit", event=> event.preventDefault());

	const QueryParams = new URL(window.location).searchParams;

	if (QueryParams.has("Reason"))
	{
		switch(parseInt(QueryParams.get("Reason")))
		{
			case 5:
				RecipeDB.main.notifyUserOfError( Elements.MESSAGEBOX(), "Your session has expired. You need to log in again", false);
				break;
			case 7:
				RecipeDB.main.notifyUserOfSuccess( Elements.MESSAGEBOX(), "You've been logged out", false);
				break;
			default:
				RecipeDB.main.notifyUserOfError( Elements.MESSAGEBOX(), "Unknown user or credentials not correct", false);
		}
	}

	console.log("Login init complete");
};

const AttemptLogin = function() {

	const MessageBox = Elements.MESSAGEBOX();
	const PasswordField = Elements.PASSWORD_FIELD();
	const UsernameField = Elements.USERNAME_FIELD();
	const LoginButton = Elements.LOGIN_BUTTON();

	if ( UsernameField.value.trim().length === 0) {

		RecipeDB.main.notifyUserOfError(MessageBox, "Please enter a username");
		return;
	}

	if ( PasswordField.value.trim().length === 0) {
		RecipeDB.main.notifyUserOfError(MessageBox, "Please enter a password");
		return;
	}

	RecipeDB.main.ajaxLoadButton(true, LoginButton);
	Elements.LOGIN_FORM().submit();
};

Init();