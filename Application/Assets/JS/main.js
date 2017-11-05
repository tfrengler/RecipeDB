"use strict";

/* Main container, a namespace for all our functionality */
var RecipeDB = {};
RecipeDB.main = {};
RecipeDB.main.debug = false;

RecipeDB.main.constants = {};
RecipeDB.main.constants.AUTH_KEY = "";
RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID = "MainContent"

RecipeDB.main.onAJAXCallError = function(AjaxResponse) {

	var MainContentContainer = $("#" + RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID);
	var MessageBox = $("#Notification-Box");

	if (RecipeDB.main.debug) {
		MainContentContainer.html( AjaxResponse["0"].responseText );
	} else {
	
		RecipeDB.main.removeAlertClasses(MessageBox);
		MessageBox.removeClass("ajax-loading");
		MessageBox.addClass("red-error-text");

		MessageBox.html("Oops, something went wrong. Please try again and contact the admin if the problem persists");
		MessageBox.fadeIn(1000);
	};

	console.warn("onAJAXCallError triggered");
	console.warn(AjaxResponse["0"]);
};

RecipeDB.main.ajaxLoadButton = function(Enable, DOMPointer, Label) {

	if (Enable) {
		DOMPointer.prop("disabled", true);
		DOMPointer.val("");
		DOMPointer.addClass("ajax-loading");
	}
	else {
		DOMPointer.prop("disabled", false);
		DOMPointer.removeClass("ajax-loading");
		DOMPointer.val( Label );
	};

};

RecipeDB.main.ajaxLoadInnerHTML = function(Enable, DOMPointer, Content) {

	if (Enable) {
		DOMPointer.html("");
		DOMPointer.addClass("ajax-loading");
	}
	else {
		DOMPointer.removeClass("ajax-loading");
		DOMPointer.html( Content );
	};

};

RecipeDB.main.removeAlertClasses = function(DOMPointer) {
	DOMPointer.removeClass("red-error-text yellow-warning-text green-success-text");
};

RecipeDB.main.init = function() {

	/* Polyfill for Number.isNan(), which is not supported by IE */
	if (Number.isNan === "undefined") {
		Number.isNaN = Number.isNaN || function(value) {
			return value !== value;
		}
	};

	console.log("Main init complete");
};