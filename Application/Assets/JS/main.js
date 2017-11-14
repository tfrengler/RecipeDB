"use strict";

/* Main container, a namespace for all our functionality */
var RecipeDB = {};
RecipeDB.main = {};
RecipeDB.main.debug = false;

RecipeDB.main.transient = {};
RecipeDB.main.transient.ajaxCallInProgress = false;
RecipeDB.main.transient.ajaxLoaderIconClass = "";
RecipeDB.main.transient.ajaxLoaderInnerHTML = "";
RecipeDB.main.transient.ajaxLoaderValue = "";

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

		MessageBox.html("Ooops, something went wrong. Sorry about that! A team of highly trained monkeys has been dispatched to deal with the situation. If you see them tell them what you did when this happened.");
		MessageBox.fadeIn(1000);
	};

	console.warn("onAJAXCallError triggered");
	console.warn(AjaxResponse["0"]);
};

RecipeDB.main.ajaxLoadButton = function(Enable, DOMPointer, ) {

	if (Enable) {
		DOMPointer.prop("disabled", true);
		this.transient.ajaxLoaderValue = DOMPointer.val();
		DOMPointer.val("");
		DOMPointer.addClass("ajax-loading");
	}
	else {
		DOMPointer.prop("disabled", false);
		DOMPointer.removeClass("ajax-loading");
		DOMPointer.val( this.transient.ajaxLoaderValue );
		this.transient.ajaxLoaderValue = "";
	};
};

RecipeDB.main.ajaxLoadIconButton = function(Enable, DOMPointer) {

	if (Enable) {
		DOMPointer.prop("disabled", true);
		this.transient.ajaxLoaderIconClass = DOMPointer.children().attr("class");
		DOMPointer.children().removeClass("");
		DOMPointer.children().addClass("fa-cog fa-spin");
	}
	else {
		DOMPointer.prop("disabled", false);
		DOMPointer.children().removeClass("fa-cog fa-spin");
		DOMPointer.children().addClass( this.transient.ajaxLoaderIconClass );
		this.transient.ajaxLoaderIconClass = "";
	};
	
};

RecipeDB.main.ajaxLoadInnerHTML = function(Enable, DOMPointer, Content) {

	if (Enable) {
		this.transient.ajaxLoaderInnerHTML = DOMPointer.html();
		DOMPointer.html("");
		DOMPointer.addClass("ajax-loading");
	}
	else {
		DOMPointer.removeClass("ajax-loading");
		if (Content !== undefined) {
			DOMPointer.html(Content)
		} else {
			DOMPointer.html( this.transient.ajaxLoaderInnerHTML );
			this.transient.ajaxLoaderInnerHTML = "";
		}
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