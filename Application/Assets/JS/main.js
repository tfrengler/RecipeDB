"use strict";

/* Main container, a namespace for all our functionality */
var RecipeDB = {};
RecipeDB.main = {}

RecipeDB.main.constants = {};
RecipeDB.main.constants.AUTH_KEY = "";


RecipeDB.main.onAJAXCallStart = function() {
	// $('#' + ).html("<img class='center-block ajax-loader-container' src='../Assets/Pictures/Standard/ajax-loader.gif' />");
};

RecipeDB.main.onAJAXCallError = function(AjaxResponse) {
	document.getElementById("MainContent").innerHTML = AjaxResponse["0"].responseText;
	// $('#' + RecipeDB.Main.DOM.ElementData.MainContentContainer.ID).html("<br/><div class='error-box col-md-2 col-md-offset-5' >Oh noes, something went wrong :( <br/>Please try again or contact the admin");
	// $('.error-box').show();
	console.warn("onAJAXCallError triggered");
	console.warn(AjaxResponse);
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

RecipeDB.main.onNotificationSuccess = function() {

};

RecipeDB.main.onNotificationError = function() {

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
/*
$.ajax({
	type: "post",
	url: "../Components/AjaxProxy.cfc",
	data: {
		method: "call",
		argumentCollection: JSON.stringify({
			component: "1385A39A4884C42B25F4E2F24D4F52DC",
			function: "getPatchNotesView",
			authKey: RecipeDB.authKey
		}),
	},
	dataType: "html",

	beforeSend: function() {
		RecipeDB.Main.Methods.onAJAXCallStart();
	},
	error: function() {
		RecipeDB.Main.Methods.onAJAXCallError(arguments);
	},
	success: function(ResponseData) {
		RecipeDB.Main.Methods.onGetViewSuccess(ResponseData);
	}
});
*/