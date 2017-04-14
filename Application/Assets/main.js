"use strict";

var RecipeDB = {
	MainContentContainerID: "MainContent"
};

/* RECIPE VIEW */

RecipeDB.Recipe = {
	"Description-Body": {},
	"Ingredients-Body": {},
	"Instructions-Body": {},
	"Comments-Body": {},
	"Status-Body": {}
};

RecipeDB.Recipe.OpenCloseSection = function(Caller) {
	var HeaderSection = Caller;
	var BodySection = Caller.nextElementSibling;

	if ( $(BodySection).css("display") == "block" ) {
		$(BodySection).animate({height: 0}, 500, function() {
			$(BodySection).hide();
			$(HeaderSection).css({display: "block", "text-align": "center"});
		});
	}
	else {
		$(BodySection).show();
		$(BodySection).animate({height: RecipeDB.Recipe[BodySection.id].Height}, 500, function() {
			$(BodySection).css("height", "");
			$(HeaderSection).css({display: "inline-block", "text-align": ""});
		});
	}
};

RecipeDB.Recipe.SetSectionDimensions = function() {
	RecipeDB.Recipe["Description-Body"].Height = parseFloat( $("#Description-Body").css("height") );
	RecipeDB.Recipe["Ingredients-Body"].Height = parseFloat( $("#Ingredients-Body").css("height") );
	RecipeDB.Recipe["Instructions-Body"].Height = parseFloat( $("#Instructions-Body").css("height") );
	RecipeDB.Recipe["Comments-Body"].Height = parseFloat( $("#Comments-Body").css("height") );
	RecipeDB.Recipe["Status-Body"].Height = parseFloat( $("#Status-Body").css("height") );
};

RecipeDB.Recipe.SetPictureEditDimensions = function() {
	$('#Recipe-Picture-Edit').css('height', $('#Recipe-Picture').css('height'));
	$('#Recipe-Picture-Edit').css('width', $('#Recipe-Picture').css('width'));
};

RecipeDB.Recipe.init = function() {
	this.SetSectionDimensions();

	$("[name='Recipe-Header']").click(function() {
		RecipeDB.Recipe.OpenCloseSection(this)
	});

	$("#Recipe-Picture").load(function() {
		RecipeDB.Recipe.SetPictureEditDimensions();
	});
};

RecipeDB.Recipe.onResize = function() {
	RecipeDB.Recipe.SetSectionDimensions();
	RecipeDB.Recipe.SetPictureEditDimensions();
	RecipeDB.Menu.SetMenuDimensions();
};

/* MAIN MENU */

RecipeDB.Menu = {
	MenuID :"side-menu",
	MenuOptionsID :"menu-options",
	CloseButtonID: "Close-Menu-Button",
	OpenButtonID: "Open-Menu-Button",
	LogoutOptionID: "Logout",
	UserSettingsOptionID: "UserSettings"
};

RecipeDB.Menu.SetMenuDimensions = function() {
	this.MenuWidth = parseFloat( $("#" + this.MenuID).css("width") ) + 1;
};

RecipeDB.Menu.onResize = function() {
	this.SetMenuDimensions();
};

RecipeDB.Menu.Show = function() {
	$("#" + this.MenuID).animate({width: this.MenuWidth}, 500);
	$("#" + this.MenuOptionsID).show(500);
};

RecipeDB.Menu.Hide = function() {
	$("#" + this.MenuOptionsID).hide(200);
	$("#" + this.MenuID).animate({width: 0}, 500);
};

RecipeDB.Menu.init = function() {
	this.SetMenuDimensions();

	$("#" + this.CloseButtonID).click(function() {
		RecipeDB.Menu.Hide();
	});

	$("#" + this.OpenButtonID).click(function() {
		RecipeDB.Menu.Show();
	});

	$("#" + this.LogoutOptionID).click(function() {
		RecipeDB.Menu.Logout();
	});

	$("#" + this.LogoutOptionID).click(function() {
		RecipeDB.Menu.Logout();
	});

	$("#" + this.UserSettingsOptionID).click(function() {
		RecipeDB.Menu.UserSettings();
	});

	this.Hide();
};

RecipeDB.Menu.Logout = function() {
	$.ajax({
		type: "post",
		url: "../../AuthenticationManager.cfc",
		data: {
			method: "gracefulLogout",
			Reason: 2
		},
		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.Menu.OnLogoutComplete(ResponseData);
		}
	});
};

RecipeDB.Menu.UserSettings = function() {
	$.ajax({
		type: "post",
		url: "../Controllers/UserController.cfc",
		data: {
			method: "getUserSettingsView"
		},
		dataType: "html",

		success: function(ResponseData) {
			RecipeDB.Menu.OnGetUserSettingsComplete(ResponseData);
		}
	});
};

RecipeDB.Menu.OnGetUserSettingsComplete = function(AjaxResponse) {
	$("#" + RecipeDB.MainContentContainerID).html(AjaxResponse);
};

RecipeDB.Menu.OnLogoutComplete = function(AjaxResponse) {	
	window.location.replace("../../Login.cfm?Reason=2");
};

RecipeDB.Menu.OnLogoutError = function(AjaxResponse) {
	// $('#' + this.MessageBoxID).html("Internal error. Please try again or contact the administrator");
	console.warn(AjaxResponse);
};

/* LOGIN PAGE */

RecipeDB.LoginPage = {
	MessageBoxID: "Login-MessageBox",
	LoginButtonID: "Login-Button",
	PasswordID: "Password",
	UsernameID: "Username"
};

RecipeDB.LoginPage.attemptLogin = function() {
	$('#' + RecipeDB.LoginPage.MessageBoxID).hide();

	var Password = $('#' + this.PasswordID).val();
	var Username = $('#' + this.UsernameID).val();

	if ( Username.length === 0 ) {
		$('#' + RecipeDB.LoginPage.MessageBoxID).html("Please enter a username");
		$('#' + RecipeDB.LoginPage.MessageBoxID).fadeIn(1000);
		return false;
	};

	$.ajax({
		type: "post",
		url: "AuthenticationManager.cfc",
		data: {
			method: "attemptLogin",
			password: Password,
			username: Username
		},
		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.LoginPage.OnLoginComplete(ResponseData);
		},
		error: function(ResponseData) {
			RecipeDB.LoginPage.OnLoginError(ResponseData);
		},
		beforeSend: function() {
			$('#' + RecipeDB.LoginPage.LoginButtonID).prop("disabled", true);
			$('#' + RecipeDB.LoginPage.LoginButtonID).val("OK");
			$('#' + RecipeDB.LoginPage.LoginButtonID).addClass("ajax-loading");
		
		},
		complete: function() {
			$('#' + RecipeDB.LoginPage.LoginButtonID).prop("disabled", false);
			$('#' + RecipeDB.LoginPage.LoginButtonID).removeClass("ajax-loading");
			$('#' + RecipeDB.LoginPage.LoginButtonID).val("OK");
		}
	});
};

RecipeDB.LoginPage.OnLoginComplete = function(AjaxResponse) {

	$('#' + this.MessageBoxID).hide();

	if (AjaxResponse.Result === false) {
		if (AjaxResponse.Code > 0) {
			$('#' + this.MessageBoxID).html("Your username and/or password is wrong");
		}

		$('#' + this.MessageBoxID).fadeIn(1000);
		return false;
	};

	window.location.replace("Application/Views/Main.cfm");
};

RecipeDB.LoginPage.OnLoginError = function(AjaxResponse) {
	$('#' + this.MessageBoxID).html("Internal error. Please try again or contact the administrator");
	console.warn(AjaxResponse);
};

RecipeDB.LoginPage.init = function() {
	$('#Login-Button').click(function() {
		RecipeDB.LoginPage.attemptLogin();
	});
};

/* USER SETTINGS */

RecipeDB.UserSettings = {
	DisplayNameBoxID: "DisplayName",
	UsernameBoxID: "Username",
	PasswordBoxID: "SecretKey",
	AccountCreationDateBoxID: "AccountCreationDate",
	LoginCountBoxID: "TimesLoggedIn",
	BrowserLastUsedBoxID: "BrowserLastUsed"
};

RecipeDB.UserSettings.init = function() {

};

/* MAIN */

RecipeDB.Main = {};

RecipeDB.Main.init = function() {

};

/* UTILITIES */

RecipeDB.Utils = {};

RecipeDB.Utils.UpperCaseStructKeys = function(Structure) {
	var ReturnData = {};
	var Key = {};

	for (Key in Structure) {
		ReturnData[ Key.toUpperCase() ] = Structure[Key];
	};

	return ReturnData;
};