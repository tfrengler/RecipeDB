"use strict";

/* ESLint rules */
/* global RecipeDB:readonly */
/* global $:readonly */


var Elements = Object.freeze({

	UPLOAD_BUTTON			: () => document.querySelector("#Upload-Picture-Button"),
	NOTIFICATION_BOX		: () => document.querySelector("#Dialog-Notification-Box"),
	SELECT_PICTURE_BUTTON	: () => document.querySelector("#Select-Picture-Button"),
	IMAGE_PREVIEW			: () => document.querySelector("#Preview-Image"),
	NEW_PICTURE				: () => document.querySelector("#New-Picture"),
	PICTURE_UPLOAD_FORM		: () => document.querySelector("#Change-Picture-Form"),
	ALLOWED_FILE_TYPE_INFO	: () => document.querySelector("#AllowedFileTypesInfo"),
	ALLOWED_FILE_SIZE_INFO	: () => document.querySelector("#AllowedFileSizeInfo")

});

var MAX_FILE_SIZE 		= 5242880;
var ACCEPTED_MIME_TYPES = ["image/bmp","image/gif","image/jpeg","image/png","image/webp"];
var AjaxCallInProgress 	= false;

var Init = function() {

	// If the browser doesn't support client side binary handling we make sure file uploads are disabled
	if (RecipeDB.main.AJAXFileSubmitSupported() === false) {

		RecipeDB.main.notifyUserOfError(
			$(Elements.NOTIFICATION_BOX()),
			"Your browser is decrepit and cannot handle the modern ways of technology. No file uploading for you!"
		);
		$(Elements.NEW_PICTURE()).prop("disabled", true);

	}

	let UIFriendlyTypeNames = [];
	ACCEPTED_MIME_TYPES.forEach(typeName=> UIFriendlyTypeNames.push(typeName.split("/")[1]));

	Elements.ALLOWED_FILE_SIZE_INFO().innerText = GetFormattedSize(MAX_FILE_SIZE);
	Elements.ALLOWED_FILE_TYPE_INFO().innerHTML = UIFriendlyTypeNames.join(", ");
	$(Elements.NEW_PICTURE()).attr("accept", ACCEPTED_MIME_TYPES.join(","));

	/* Event handlers */
	$(Elements.NEW_PICTURE()).change(OnChangeFile);
	Elements.UPLOAD_BUTTON().addEventListener("click", UploadPicture);

	console.log("Change picture init complete");
};

var UploadPicture = async function() {

	DisableUpload(true);

	const RecipeID = parseInt(document.querySelector("#RecipeID").value) || 0;
	const PictureInputElement = Elements.NEW_PICTURE();
	const FileData = PictureInputElement.files[0];

	const ControllerArguments = Object.seal({
		recipeID: RecipeID,
		base64content: null,
		mimeType: FileData.type || "unknown",
		fileName: FileData.name
	});

	ControllerArguments.base64content = await GetBase64Data(FileData);

	await fetch("Components/AjaxProxy.cfc?method=call");

	DisableUpload(false);
};

var OnChangeFile = function() {

	DisableUpload(true);
	Elements.NOTIFICATION_BOX().classList.add("hidden");
	const PictureFileInput = Elements.NEW_PICTURE();

	if (PictureFileInput.files.length === 0) {
		return
	}

	const FileSize = PictureFileInput.files[0].size || 0;
	const FileType = PictureFileInput.files[0].type || "unknown";

	if (FileSize > MAX_FILE_SIZE)
	{
		RecipeDB.main.notifyUserOfError(Elements.NOTIFICATION_BOX(), "The file you selected is too big: " + GetFormattedSize(FileSize));
		return;
	}

	if ( !ACCEPTED_MIME_TYPES.includes(FileType)) {
		RecipeDB.main.notifyUserOfError(Elements.NOTIFICATION_BOX(), "The file you selected is not an accepted type: " + FileType);
		return;
	}

	DisableUpload(false);
};

/**
 * Returns a UI-friendly string interpretation of a number of bytes
 * @param {Number} sizeInBytes
 * @returns
 */
var GetFormattedSize = function(sizeInBytes) {
	sizeInBytes = parseInt(sizeInBytes);

	if (sizeInBytes < 1024) {
		return sizeInBytes.toFixed(2) + " bytes";
	}
	if (sizeInBytes < Math.pow(1024,2)) {
		return (sizeInBytes/1024).toFixed(2) + " kilobytes";
	}
	if (sizeInBytes < Math.pow(1024,3)) {
		return (sizeInBytes/Math.pow(1024,2)).toFixed(2) + " megabytes";
	}

	return (sizeInBytes/Math.pow(1024,3)).toFixed(2) + " gigabytes";
};

/**
 * Whether to enable or disable the upload-button
 * @param {boolean} state True to disable, false to enable
 */
var DisableUpload = function(state) {

	const UploadButton = Elements.UPLOAD_BUTTON();

	UploadButton.disabled = state;
	UploadButton.classList.remove(state ? "standard-button" : "disabled-input");
	UploadButton.classList.add(state ? "disabled-input" : "standard-button");
};

var OnPictureUploaded = function(ControllerResponse) {
	var MessageBox = $("#" + RecipeDB.page.constants.NOTICATION_ELEMENT);

	if (ControllerResponse.statuscode === 0) {

		$("#" + RecipeDB.page.constants.PICTURE).attr("src", "Modules/RecipeImageDownloader.cfm?fileName=" + ControllerResponse.data);
		RecipeDB.main.notifyUserOfSuccess( MessageBox, "PICTURE CHANGED", 2000);
		$("#" + RecipeDB.main.constants.DIALOG).dialog("close");

	} else {
		$("#" + RecipeDB.main.constants.DIALOG).dialog("close");
		RecipeDB.main.onJavascriptError(ControllerResponse, "RecipeDB.dialog.onPictureUploaded");
	}
};

var GetBase64Data = async function(file) {

	return new Promise((resolve, _) => {
		var Reader = new FileReader();

		Reader.onload = function () {
			let base64String = Reader.result.replace("data:", "").replace(/^.+,/, "");
			resolve(base64String);
		}

		Reader.readAsDataURL(file);
	});
}

Init();

/*
var Reader = new FileReader();

Reader.onload = function ()
{
    let base64String = Reader.result.replace("data:", "").replace(/^.+,/, "");
    console.log(base64String);
}

var file = document.querySelector("input[type='file']").files[0]
Reader.readAsDataURL(file);
*/