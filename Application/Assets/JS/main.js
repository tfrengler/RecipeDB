"use strict";

/* ESLint rules */
/* global $:readonly */

const RecipeDB = {};

RecipeDB.main = {};
RecipeDB.main.debug = false;
RecipeDB.dialog = {};

RecipeDB.main.transient = {};
RecipeDB.main.transient.ajaxCallInProgress = false;
RecipeDB.main.transient.ajaxLoaderIconClass = "";
RecipeDB.main.transient.ajaxLoaderInnerHTML = "";
RecipeDB.main.transient.ajaxLoaderValue = "";

RecipeDB.main.constants = {};
RecipeDB.main.constants.AUTH_KEY = "";
RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID = "MainContent"
RecipeDB.main.constants.DIALOG_ID = "Popup-Dialog";
RecipeDB.main.constants.AJAX_TIMEOUT = 30000;

const AlertClasses = Object.freeze(["red-error-text","yellow-warning-text","green-success-text"]);

RecipeDB.main.onAJAXCallError = function(AjaxResponse) {

	var MainContentContainer = $("#" + RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID);
	var MessageBox = $("#Notification-Box");

	if (RecipeDB.main.debug) {
		MainContentContainer.html( AjaxResponse[0].responseText );
	} else {

		MessageBox.classList.remove(AlertClasses);
		MessageBox.removeClass("ajax-loading");
		MessageBox.addClass("red-error-text");

		MessageBox.html("Ooops, something went wrong. Sorry about that! A team of highly trained monkeys has been dispatched to deal with the situation. If you see them tell them what you did when this happened.");
		MessageBox.fadeIn(1000);
	}

	console.warn("onAJAXCallError triggered");
	console.warn(AjaxResponse[0]);
};

RecipeDB.main.onJavascriptError = function(ErrorContent, MethodName) {

	//var MainContentContainer = $("#" + RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID);
	var MessageBox = $("#Notification-Box");
	var DebugOutput = "";
	var FriendlyErrorMessage = "Ooops, something went wrong! A team of highly trained monkeys has been dispatched to deal with the situation. If you see them tell them what you did when this happened."

	if (typeof ErrorContent === "object") {
		// DebugOutput = structuredClone(ErrorContent);
		console.error(ErrorContent);
	}

	if (RecipeDB.main.debug) {
		RecipeDB.main.notifyUserOfError( MessageBox, DebugOutput, 0 );

	} else {
		RecipeDB.main.notifyUserOfError( MessageBox, FriendlyErrorMessage, 0 );
	}

	console.warn("onJavascriptError triggered by " + MethodName);
	console.warn(ErrorContent);
};

RecipeDB.main.ajaxLoadButton = function(Enable, DOMPointer, Value) {

	// To be removed once jQuery is gone!
	if (DOMPointer.__proto__.jquery)
		DOMPointer = DOMPointer[0];

	if (Enable) {
		DOMPointer.disabled = true;
		this.transient.ajaxLoaderValue = DOMPointer.value;
		DOMPointer.value = "";
		DOMPointer.classList.add("ajax-loading");
	}
	else {
		DOMPointer.disabled = false;
		DOMPointer.classList.remove("ajax-loading");

		if (Value !== undefined && Value.length > 0) {
			DOMPointer.value = Value.trim();
		} else {
			DOMPointer.value = this.transient.ajaxLoaderValue;
		}

		this.transient.ajaxLoaderValue = "";
	}
};

RecipeDB.main.ajaxLoadIconButton = function(Enable, DOMPointer) {

	// To be removed once jQuery is gone!
	if (DOMPointer.__proto__.jquery)
		DOMPointer = DOMPointer[0];

	if (Enable) {
		DOMPointer.disabled = true;
		this.transient.ajaxLoaderIconClass = DOMPointer.children[0].className;
		DOMPointer.children[0].className = "";
		DOMPointer.children[0].className = "fa fa-cog fa-spin";
	}
	else {
		DOMPointer.disabled = false;
		DOMPointer.children[0].className = this.transient.ajaxLoaderIconClass;
		this.transient.ajaxLoaderIconClass = "";
	}

};

RecipeDB.main.ajaxLoadInnerHTML = function(Enable, DOMPointer, Content) {

	// To be removed once jQuery is gone!
	if (DOMPointer.__proto__.jquery)
		DOMPointer = DOMPointer[0];

	if (Enable) {
		this.transient.ajaxLoaderInnerHTML = DOMPointer.innerHTML;
		DOMPointer.innerHTML = ("<span style='visibility:hidden'>" + this.transient.ajaxLoaderInnerHTML + "</span>");
		DOMPointer.classList.add("ajax-loading");
	}
	else {
		DOMPointer.classList.remove("ajax-loading");
		if (Content !== undefined && Content.length > 0) {
			DOMPointer.innerHTML = Content.trim();
		} else {
			DOMPointer.innerHTML = this.transient.ajaxLoaderInnerHTML;
			this.transient.ajaxLoaderInnerHTML = "";
		}
	}

};

/**
 *
 * @param {HTMLElement} NotificationBoxPointer
 * @param {String} Message
 * @param {Boolean} Fadeout
 */
RecipeDB.main.notifyUserOfSuccess = function(NotificationBoxPointer, Message, Fadeout) {
	this.notify(NotificationBoxPointer, "success", Message, Fadeout);
};

/**
 *
 * @param {HTMLElement} NotificationBoxPointer
 * @param {Boolean} Fadeout
 */
RecipeDB.main.notifyUserOfLoading = function(NotificationBoxPointer, Fadeout) {
	this.notify(NotificationBoxPointer, "ajax", "", Fadeout);
};

/**
 *
 * @param {HTMLElement} NotificationBoxPointer
 * @param {String} Message
 * @param {Boolean} Fadeout
 */
RecipeDB.main.notifyUserOfError = function(NotificationBoxPointer, Message, Fadeout) {
	this.notify(NotificationBoxPointer, "error", Message, Fadeout);
};

/**
 *
 * @param {HTMLElement} NotificationBoxPointer
 * @param {String} Message
 * @param {Boolean} Fadeout
 */
RecipeDB.main.notifyUserOfWarning = function(NotificationBoxPointer, Message, Fadeout) {
	this.notify(NotificationBoxPointer, "warning", Message, Fadeout);
};

/**
 *
 * @param {Element} NotificationBoxPointer
 * @param {String} Type
 * @param {String} Message
 * @param {Number} FadeoutTime
 */
RecipeDB.main.notify = function(NotificationBoxPointer, Type, Message, fadeout = true) {

	if (typeof fadeout === typeof Number)
		fadeout = true;

	// To be removed once jQuery is gone!
	if (NotificationBoxPointer.__proto__.jquery)
		NotificationBoxPointer = NotificationBoxPointer[0];

	var CSSClassMap = {
		success: ["green-success-text"],
		error: ["red-error-text"],
		warning: ["yellow-warning-text"],
		ajax: ["yellow-warning-text", "ajax-loading"]
	};

	NotificationBoxPointer.classList.remove(...AlertClasses);
	NotificationBoxPointer.classList.remove("ajax-loading");
	NotificationBoxPointer.classList.remove("fadeOut");

	NotificationBoxPointer.classList.add( ...CSSClassMap[Type] );
	NotificationBoxPointer.classList.add("visible");
	NotificationBoxPointer.innerHTML = Message;

	if (fadeout === true)
	{
		setTimeout(()=> NotificationBoxPointer.classList.add("fadeOut"), 2000);
		setTimeout(()=> {
			NotificationBoxPointer.classList.remove("fadeOut")
			NotificationBoxPointer.classList.remove("visible");
		}, 3050);
	}
};

RecipeDB.main.onNavigate = function() {
	var NotificationBox = $(".notification-box");
	var Message = "<i class='fa fa-cog fa-spin'></i> LOADING";

	if (NotificationBox.length > 0) {
		RecipeDB.main.notify(NotificationBox, "success", Message);
	};
};

RecipeDB.main.removeAlertClasses = function(DOMPointer) {
	DOMPointer.removeClass("red-error-text yellow-warning-text green-success-text");
};

RecipeDB.main.createDialog = function(Options) {

	if (typeof Options !== "object") {
		this.onJavascriptError("Argument 'Options' is not an object", "RecipeDB.main.createDialog");
		return {};
	};

	var InitializedDialog = {};
	var DialogElement = document.createElement("div");
	DialogElement.setAttribute("id", RecipeDB.main.constants.DIALOG_ID);

	document.getElementsByTagName("body")[0].appendChild(DialogElement);
	InitializedDialog = $("#" + RecipeDB.main.constants.DIALOG_ID).dialog(Options);

	return InitializedDialog;
};

RecipeDB.main.removeDialog = function(DialogElement) {

	DialogElement.dialog("destroy");
	DialogElement.remove();
	RecipeDB.dialog = {};

	return true;
};

RecipeDB.main.AJAXFileSubmitSupported = function() {
	if (	typeof Blob !== "undefined"
			&& typeof File !== "undefined"
			&& typeof FileList !== "undefined"
			&& typeof FormData !== "undefined"
		) {
		return true
	} else {
		return false
	}
};

RecipeDB.main.onPictureNotLoaded = function(IMGElement) {
	// This pathing should be safe because we're always related to the application-root folder
	$(IMGElement).attr("src", "Assets/Pictures/Standard/ImageNotFound.jpeg");
};

RecipeDB.main.init = function ()
{
	console.log("Main init complete");
};