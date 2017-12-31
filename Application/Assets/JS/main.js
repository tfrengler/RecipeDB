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
RecipeDB.main.constants.DIALOG_ID = "Popup-Dialog";
RecipeDB.main.constants.AJAX_TIMEOUT = 30000;

RecipeDB.main.onAJAXCallError = function(AjaxResponse) {

	var MainContentContainer = $("#" + RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID);
	var MessageBox = $("#Notification-Box");

	if (RecipeDB.main.debug) {
		MainContentContainer.html( AjaxResponse[0].responseText );
	} else {
	
		RecipeDB.main.removeAlertClasses(MessageBox);
		MessageBox.removeClass("ajax-loading");
		MessageBox.addClass("red-error-text");

		MessageBox.html("Ooops, something went wrong. Sorry about that! A team of highly trained monkeys has been dispatched to deal with the situation. If you see them tell them what you did when this happened.");
		MessageBox.fadeIn(1000);
	};

	console.warn("onAJAXCallError triggered");
	console.warn(AjaxResponse[0]);
};

RecipeDB.main.onJavascriptError = function(ErrorContent, MethodName) {

	var MainContentContainer = $("#" + RecipeDB.main.constants.MAINCONTENT_CONTAINER_ID);
	var MessageBox = $("#Notification-Box");
	var DebugOutput = "";
	var FriendlyErrorMessage = "Ooops, something went wrong! A team of highly trained monkeys has been dispatched to deal with the situation. If you see them tell them what you did when this happened."

	if (typeof ErrorContent === "object") {
		DebugOutput = JSON.stringify(ErrorContent);
	};

	if (RecipeDB.main.debug) {
		RecipeDB.main.notifyUserOfError( MessageBox, DebugOutput, 0 );

	} else {
		RecipeDB.main.notifyUserOfError( MessageBox, FriendlyErrorMessage, 0 );
	};

	console.warn("onJavascriptError triggered by " + MethodName);
	console.warn(ErrorContent);
};

RecipeDB.main.ajaxLoadButton = function(Enable, DOMPointer, Value) {

	if (Enable) {
		DOMPointer.prop("disabled", true);
		this.transient.ajaxLoaderValue = DOMPointer.val();
		DOMPointer.val("");
		DOMPointer.addClass("ajax-loading");
	}
	else {
		DOMPointer.prop("disabled", false);
		DOMPointer.removeClass("ajax-loading");

		if (Value !== undefined && Value.length > 0) {
			DOMPointer.val(Value.trim())
		} else {
			DOMPointer.val( this.transient.ajaxLoaderValue );
		}

		this.transient.ajaxLoaderValue = "";
	};
};

RecipeDB.main.ajaxLoadIconButton = function(Enable, DOMPointer) {

	if (Enable) {
		DOMPointer.prop("disabled", true);
		this.transient.ajaxLoaderIconClass = DOMPointer.children().attr("class");
		DOMPointer.children().removeClass();
		DOMPointer.children().addClass("fa fa-cog fa-spin");
	}
	else {
		DOMPointer.prop("disabled", false);
		DOMPointer.children().removeClass("fa fa-cog fa-spin");
		DOMPointer.children().addClass( this.transient.ajaxLoaderIconClass );
		this.transient.ajaxLoaderIconClass = "";
	};
	
};

RecipeDB.main.ajaxLoadInnerHTML = function(Enable, DOMPointer, Content) {

	if (Enable) {
		this.transient.ajaxLoaderInnerHTML = DOMPointer.html();
		DOMPointer.html("<span style='visibility:hidden'>" + this.transient.ajaxLoaderInnerHTML + "</span>");
		DOMPointer.addClass("ajax-loading");
	}
	else {
		DOMPointer.removeClass("ajax-loading");
		if (Content !== undefined && Content.length > 0) {
			DOMPointer.html(Content.trim())
		} else {
			DOMPointer.html( this.transient.ajaxLoaderInnerHTML );
			this.transient.ajaxLoaderInnerHTML = "";
		}
	};
	
};

RecipeDB.main.notifyUserOfSuccess = function(NotificationBoxPointer, Message, FadeoutTime) {
	if (FadeoutTime !== undefined && FadeoutTime > 0) {
		FadeoutTime = FadeoutTime
	} else {
		var FadeoutTime = 0;
	}

	this.notify(NotificationBoxPointer, "success", Message, FadeoutTime);
};

RecipeDB.main.notifyUserOfLoading = function(NotificationBoxPointer) {
	if (FadeoutTime !== undefined && FadeoutTime > 0) {
		FadeoutTime = FadeoutTime
	} else {
		var FadeoutTime = 0;
	}

	this.notify(NotificationBoxPointer, "ajax", "", FadeoutTime);
};

RecipeDB.main.notifyUserOfError = function(NotificationBoxPointer, Message, FadeoutTime) {
	if (FadeoutTime !== undefined && FadeoutTime > 0) {
		FadeoutTime = FadeoutTime
	} else {
		var FadeoutTime = 0;
	}

	this.notify(NotificationBoxPointer, "error", Message, FadeoutTime);
};

RecipeDB.main.notifyUserOfWarning = function(NotificationBoxPointer, Message, FadeoutTime) {
	if (FadeoutTime !== undefined && FadeoutTime > 0) {
		FadeoutTime = FadeoutTime
	} else {
		var FadeoutTime = 0;
	}

	this.notify(NotificationBoxPointer, "warning", Message, FadeoutTime);
};

RecipeDB.main.notify = function(NotificationBoxPointer, Type, Message, FadeoutTime) {

	var CSSClassMap = {
		success: "green-success-text",
		error: "red-error-text",
		warning: "yellow-warning-text",
		ajax: "yellow-warning-text ajax-loading"
	};

	NotificationBoxPointer.hide();
	this.removeAlertClasses(NotificationBoxPointer);
	NotificationBoxPointer.removeClass("ajax-loading");

	NotificationBoxPointer.addClass( CSSClassMap[Type] );
	NotificationBoxPointer.html(Message);
	NotificationBoxPointer.show();

	if (FadeoutTime !== undefined && FadeoutTime > 0) {
		setTimeout(
			function() {
				NotificationBoxPointer.fadeOut(1000);
			},
			parseInt(FadeoutTime)
		)
	};

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

RecipeDB.page.onPictureNotLoaded = function(IMGElement) {
	IMGElement.src = "../Assets/Pictures/Standard/ImageNotFound.jpeg";
};

RecipeDB.main.init = function() {
	// $("a").click(RecipeDB.main.onNavigate);

	/* Polyfill for Number.isNan(), which is not supported by IE */
	if (Number.isNan === "undefined") {
		Number.isNaN = Number.isNaN || function(value) {
			return value !== value;
		}
	};

	console.log("Main init complete");
};