"use strict";

RecipeDB.dialog = {};
RecipeDB.dialog.transient = {};
RecipeDB.dialog.constants = {};

RecipeDB.dialog.constants.UPLOAD_BUTTON_ID = "Upload-Picture-Button";
RecipeDB.dialog.constants.NOTIFICATION_BOX_ID = "Dialog-Notification-Box";
RecipeDB.dialog.constants.SELECT_PICTURE_BUTTON_ID = "Select-Picture-Button";
RecipeDB.dialog.constants.IMAGE_PREVIEW_ID = "Preview-Image";
RecipeDB.dialog.constants.NEW_PICTURE_ID = "New-Picture";
RecipeDB.dialog.constants.PICTURE_UPLOAD_FORM_ID = "Change-Picture-Form";
RecipeDB.dialog.constants.MAX_FILE_SIZE = 0; // Values will be generated by CF upon init
RecipeDB.dialog.constants.ACCEPTED_MIME_TYPES = ""; // Values will be generated by CF upon init

RecipeDB.dialog.init = function() {

	// If the browser doesn't support client side binary handling we make sure file uploads are disabled
	if (RecipeDB.main.AJAXFileSubmitSupported() === false) {

		RecipeDB.main.notifyUserOfError(
			$("#" + RecipeDB.dialog.constants.NOTIFICATION_BOX_ID),
			"Your browser is decrepit and cannot handle the modern ways of technology. No file uploading for you!"
		);
		$("#" + RecipeDB.dialog.constants.NEW_PICTURE_ID).prop("disabled", true);

	};

	RecipeDB.dialog.constants.MAX_FILE_SIZE = parseInt(RecipeDB.dialog.constants.MAX_FILE_SIZE); //Thanks Lucee for casting my numeric value to a string...
	$("#" + RecipeDB.dialog.constants.NEW_PICTURE_ID).attr("accept", RecipeDB.dialog.constants.ACCEPTED_MIME_TYPES);

	/* Event handlers */
	$("#" + RecipeDB.dialog.constants.NEW_PICTURE_ID).change(RecipeDB.dialog.onChangeFile);
	$("#" + RecipeDB.dialog.constants.UPLOAD_BUTTON_ID).click(RecipeDB.dialog.uploadPicture);

	console.log("Change picture init complete");
};

RecipeDB.dialog.uploadPicture = function() {

	var AjaxQueryString = "";
	var RecipeID = parseInt($("#" + RecipeDB.page.constants.RECIPEID_ID).val());
	var FormToPost = new FormData(
		document.getElementById(RecipeDB.dialog.constants.PICTURE_UPLOAD_FORM_ID)
	);

	var ControllerArguments = {
		recipeID: RecipeID
	};

	if (RecipeDB.main.transient.ajaxCallInProgress === false) {
		RecipeDB.main.transient.ajaxCallInProgress = true
	} else {
		return false;
	};

	AjaxQueryString = "Components/AjaxProxy.cfc?method=callWithFileUpload&controller=ChangeRecipePicture";
	AjaxQueryString = AjaxQueryString + "&authKey=" + RecipeDB.main.constants.AUTH_KEY;
	AjaxQueryString = AjaxQueryString + "&parameters=" + encodeURIComponent(JSON.stringify(ControllerArguments));

	$.ajax({
		type: "POST",
		timeout: RecipeDB.main.constants.AJAX_TIMEOUT,
		url: AjaxQueryString,
		dataType: "json",
		enctype: "multipart/form-data",
		processData: false, // These two are required for file posting via AJAX to work
		contentType: false, // These two are required for file posting via AJAX to work
		data: FormToPost,

		complete: function() {
			RecipeDB.main.transient.ajaxCallInProgress = false;
			// RecipeDB.main.ajaxLoadButton(false, $('#' + RecipeDB.dialog.constants.UPLOAD_BUTTON_ID));
		},
		error: function() {
			$("#" + RecipeDB.main.constants.DIALOG_ID).dialog("close");
			RecipeDB.main.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			RecipeDB.main.ajaxLoadButton(true, $('#' + RecipeDB.dialog.constants.UPLOAD_BUTTON_ID));
		},
		success: function() {
			RecipeDB.dialog.onPictureUploaded(arguments[0]);
		}

	});
};

RecipeDB.dialog.onChangeFile = function() {

	var PictureFileInput,FileSize,FileType,FormattedSize,Message,FileAccepted;

	$("#" + RecipeDB.dialog.constants.NOTIFICATION_BOX_ID).hide();
	PictureFileInput = document.getElementById(RecipeDB.dialog.constants.NEW_PICTURE_ID);

	if (PictureFileInput.files.length === 0) {
		return
	};

	FileSize = PictureFileInput.files[0].size;
	FileType = PictureFileInput.files[0].type;
	FormattedSize = RecipeDB.dialog.getFormattedSize(FileSize);

	if (FileSize > RecipeDB.dialog.constants.MAX_FILE_SIZE) {
		Message = "The file you selected is too big: " + FormattedSize
		FileAccepted = false;
	} else {
		FileAccepted = true;
	};

	if ( RecipeDB.dialog.constants.ACCEPTED_MIME_TYPES.indexOf(FileType) === -1 || FileType.length === 0 ) {

		if (Message.length > 0) {
			Message += "<br/>"
		}
		if (FileType.length === 0) {
			Message += "Filetype is unknown, which usually means it's not accepted"
		} else {
			Message += "The file you selected is not an accepted type: " + FileType
		}
		FileAccepted = false

	} else {
		FileAccepted = true;
	};

	if (FileAccepted === false) {

		RecipeDB.main.notifyUserOfError( $("#" + RecipeDB.dialog.constants.NOTIFICATION_BOX_ID), Message);
		RecipeDB.dialog.disableUpload(true);

	} 
	else if (FileAccepted === true) {
		RecipeDB.dialog.disableUpload(false)
	}
	else {
		RecipeDB.main.onJavascriptError("FileAccepted variable is unknown, a logic error must have happened", "RecipeDB.dialog.onChangeFile")
	}
};

RecipeDB.dialog.getFormattedSize = function(SizeInBytes) {
	SizeInBytes = parseInt(SizeInBytes);

	if (SizeInBytes < 1024) {
		return SizeInBytes.toFixed(2) + " bytes";
	}
	if (SizeInBytes < Math.pow(1024,2)) {
		return (SizeInBytes/1024).toFixed(2) + " kilobytes";
	}
	if (SizeInBytes < Math.pow(1024,3)) {
		return (SizeInBytes/Math.pow(1024,2)).toFixed(2) + " megabytes";
	}

	return (SizeInBytes/Math.pow(1024,3)).toFixed(2) + " gigabytes";
};

RecipeDB.dialog.disableUpload = function(State) {

	var UploadButton = $("#" + RecipeDB.dialog.constants.UPLOAD_BUTTON_ID);

	if (State === true) {
		UploadButton.prop("disabled", true);
		UploadButton.removeClass("standard-button");
		UploadButton.addClass("disabled-input");
	}
	else if (State === false) {
		UploadButton.prop("disabled", false);
		UploadButton.removeClass("disabled-input");
		UploadButton.addClass("standard-button");
	}
};

RecipeDB.dialog.onPictureUploaded = function(ControllerResponse) {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT_ID);

	if (ControllerResponse.statuscode === 0) {

		$("#" + RecipeDB.page.constants.PICTURE_ID).attr("src", "Modules/RecipeImageDownloader.cfm?fileName=" + ControllerResponse.data);
		RecipeDB.main.notifyUserOfSuccess( MessageBox, "PICTURE CHANGED", 2000);
		$("#" + RecipeDB.main.constants.DIALOG_ID).dialog("close");

	} else {
		$("#" + RecipeDB.main.constants.DIALOG_ID).dialog("close");
		RecipeDB.main.onJavascriptError(ControllerResponse, "RecipeDB.dialog.onPictureUploaded");
	}
};