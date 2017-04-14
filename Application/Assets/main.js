"use strict";

/* Main container, a namespace for all our functionality */
var RecipeDB = {};

/* MAIN.CFM */

RecipeDB.Main = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.Main.DOM.ElementData = {
	MainContentContainer: {
		ID: "MainContent"
	}
};

RecipeDB.Main.init = function() {

};

/* LOGIN.CFM */

RecipeDB.LoginPage = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.LoginPage.DOM.ElementData = {

	MessageBox: {
		ID: "Login-MessageBox"
	},

	LoginButton: {
		ID: "Login-Button"
	},

	Password: {
		ID: "Password"
	},

	Username: {
		ID: "Username"
	}
};

RecipeDB.LoginPage.init = function() {

	$('#Login-Button').click(function() {
		RecipeDB.LoginPage.Methods.attemptLogin();
	});

};

RecipeDB.LoginPage.Methods = {

	attemptLogin: function() {
		$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).hide();

		var Password = $('#' + RecipeDB.LoginPage.DOM.ElementData.Password.ID).val();
		var Username = $('#' + RecipeDB.LoginPage.DOM.ElementData.Username.ID).val();

		if ( Username.length === 0 || Username === " " ) {
			$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).html("Please enter a username");
			$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).fadeIn(1000);
			return false;
		};

		$.ajax({
			type: "post",
			url: "AuthenticationManager.cfc",
			data: {
				method: "attemptLogin",
				password: String(Password),
				username: String(Username)
			},
			dataType: "json",

			success: function(ResponseData) {
				RecipeDB.LoginPage.Methods.onLoginComplete(ResponseData);
			},
			error: function() {
				RecipeDB.LoginPage.Methods.onLoginError(arguments);
			},
			beforeSend: function() {
				$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).prop("disabled", true);
				$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).val("OK");
				$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).addClass("ajax-loading");
			
			},
			complete: function() {
				$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).prop("disabled", false);
				$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).removeClass("ajax-loading");
				$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).val("OK");
			}
		});
	},

	onLoginComplete: function(AjaxResponse) {

		$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).hide();

		if (AjaxResponse.Result === false) {
			if (AjaxResponse.Code > 0) {
				$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).html("Your username and/or password is wrong");
			}

			$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).fadeIn(1000);
			return false;
		};

		window.location.replace("Application/Views/Main.cfm");
	},

	onLoginError: function(AjaxResponse) {
		$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).html("Internal error. Please try again or contact the administrator");
		console.warn(AjaxResponse);
	}
};

/* USER SETTINGS.CFM */

RecipeDB.UserSettings = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.UserSettings.DOM.ElementData = {

	DisplayNameBox: {
		ID: "DisplayName"
	},

	UsernameBox: {
		ID: "Username"
	},

	PasswordBox: {
		ID: "SecretKey"
	},

	AccountCreationDateBox: {
		ID: "AccountCreationDate"
	},

	LoginCountBox: {
		ID: "TimesLoggedIn"
	},

	BrowserLastUsedBox: {
		ID: "BrowserLastUsed"
	}
};

RecipeDB.UserSettings.init = function() {

};

/* MENU.CFM */

RecipeDB.Menu = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.Menu.DOM.ElementData = {
	Menu: {
		ID :"side-menu",
		Width: 0
	},

	MenuOptions: {
		ID :"menu-options"
	},

	CloseButton: {
		ID: "Close-Menu-Button"
	},

	OpenButton: {
		ID: "Open-Menu-Button"
	},

	LogoutOption: {
		ID: "Logout"
	},

	UserSettingsOption: {
		ID: "UserSettings"
	}
}

RecipeDB.Menu.init = function() {
	RecipeDB.Menu.Methods.setMenuDimensions();
	
	$(document).resize(function() {
		RecipeDB.Menu.Methods.onResize();
	});

	$("#" + RecipeDB.Menu.DOM.ElementData.CloseButton.ID).click(function() {
		RecipeDB.Menu.Methods.hide();
	});

	$("#" + RecipeDB.Menu.DOM.ElementData.OpenButton.ID).click(function() {
		RecipeDB.Menu.Methods.show();
	});

	$("#" + RecipeDB.Menu.DOM.ElementData.LogoutOption.ID).click(function() {
		RecipeDB.Menu.Methods.logout();
	});

	$("#" + RecipeDB.Menu.DOM.ElementData.UserSettingsOption.ID).click(function() {
		RecipeDB.Menu.Methods.getUserSettings();
	});

	RecipeDB.Menu.Methods.hide();
};

RecipeDB.Menu.Methods = {

	logout: function() {
		$.ajax({
			type: "post",
			url: "../../AuthenticationManager.cfc",
			data: {
				method: "gracefulLogout",
				Reason: 2
			},
			dataType: "json",

			success: function(ResponseData) {
				RecipeDB.Menu.Methods.onLogoutComplete(ResponseData);
			}
		});
	},

	getUserSettings: function() {
		$.ajax({
			type: "post",
			url: "../Controllers/UserController.cfc",
			data: {
				method: "getUserSettingsView"
			},
			dataType: "html",

			success: function(ResponseData) {
				RecipeDB.Menu.Methods.onGetUserSettingsComplete(ResponseData);
			}
		});
	},

	onGetUserSettingsComplete: function(AjaxResponse) {
		$("#" + RecipeDB.Main.DOM.ElementData.MainContentContainer.ID).html( String(AjaxResponse) );
	},

	onLogoutComplete: function(AjaxResponse) {
		window.location.replace("../../Login.cfm?Reason=2");
	},

	hide: function() {
		$("#" + RecipeDB.Menu.DOM.ElementData.MenuOptions.ID).hide(200);
		$("#" + RecipeDB.Menu.DOM.ElementData.Menu.ID).animate({width: 0}, 500);
	},

	show: function() {
		$("#" + RecipeDB.Menu.DOM.ElementData.Menu.ID).animate({width: RecipeDB.Menu.DOM.ElementData.Menu.Width}, 500);
		$("#" + RecipeDB.Menu.DOM.ElementData.MenuOptions.ID).show(500);
	},

	onResize: function() {
		RecipeDB.Menu.Methods.setMenuDimensions();
	},

	setMenuDimensions: function() {
		RecipeDB.Menu.DOM.ElementData.Menu.Width = parseFloat( $("#" + RecipeDB.Menu.DOM.ElementData.Menu.ID).css("width") ) + 1;
	}
};

/* RECIPE.CFM */

RecipeDB.Recipe = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.Recipe.DOM.ElementData = {

	SectionHeaders: {
		Name: "Recipe-Header"
	},

	DescriptionBody: {
		ID: "Description-Body",
		Height: 0
	},

	IngredientsBody: {
		ID: "Ingredients-Body",
		Height: 0
	},
	
	InstructionsBody: {
		ID: "Instructions-Body",
		Height: 0
	},
	
	CommentsBody: {
		ID: "Comments-Body",
		Height: 0
	},

	StatusBody: {
		ID: "Status-Body",
		Height: 0
	},

	Picture: {
		ID: "Recipe-Picture"
	},

	PictureEdit: {
		ID: "Recipe-Picture-Edit"
	}
};

RecipeDB.Recipe.init = function() {
	RecipeDB.Recipe.Methods.setSectionDimensions();

	$( trim(" [name=' " + RecipeDB.Recipe.DOM.ElementData.SectionHeaders.Name + " '] ") ).click(function() {
		RecipeDB.Recipe.Methods.openCloseSection(this)
	});

	$("#" + RecipeDB.Recipe.DOM.ElementData.Picture).load(function() {
		RecipeDB.Recipe.Methods.setPictureEditDimensions();
	});

	$(document).resize( function() {
		RecipeDB.Recipe.Methods.onResize();
	});
};

RecipeDB.Recipe.Methods = {

	onResize: function() {
		RecipeDB.Recipe.Methods.setSectionDimensions();
		RecipeDB.Recipe.Methods.setPictureEditDimensions();
	},

	setSectionDimensions: function() {

		RecipeDB.Recipe.DOM.ElementData.DescriptionBody.Height = parseFloat( 
			$("#" + RecipeDB.Recipe.DOM.ElementData.DescriptionBody.ID).css("height") 
		);

		RecipeDB.Recipe.DOM.ElementData.IngredientsBody.Height = parseFloat( 
			$("#" + RecipeDB.Recipe.DOM.ElementData.IngredientsBody.ID).css("height") 
		);

		RecipeDB.Recipe.DOM.ElementData.InstructionsBody.Height = parseFloat( 
			$("#" + RecipeDB.Recipe.DOM.ElementData.InstructionsBody.ID).css("height") 
		);

		RecipeDB.Recipe.DOM.ElementData.CommentsBody.Height = parseFloat( 
			$("#" + RecipeDB.Recipe.DOM.ElementData.CommentsBody.ID).css("height") 
		);

		RecipeDB.Recipe.DOM.ElementData.StatusBody.Height = parseFloat( 
			$("#" + RecipeDB.Recipe.DOM.ElementData.StatusBody.ID).css("height") 
		);

	},

	setPictureEditDimensions: function() {

		$('#' + RecipeDB.Recipe.DOM.ElementData.PictureEdit.ID).css(
			'height', 
			$('#' + RecipeDB.Recipe.DOM.ElementData.Picture.ID).css('height')
		);

		$('#' + RecipeDB.Recipe.DOM.ElementData.PictureEdit.ID).css(
			'width', 
			$('#' + RecipeDB.Recipe.DOM.ElementData.Picture.ID).css('width')
		);

	},

	openCloseSection: function(Caller) {
		
		var HeaderSection = Caller;
		var BodySection = Caller.nextElementSibling;
		var DesiredHeight = 0;
		var Key = "";
		var CurrentElementData = {};

		for (Key in RecipeDB.Recipe.DOM.ElementData) {
			CurrentElementData = RecipeDB.Recipe.DOM.ElementData[Key];
			
			if ( CurrentElementData.ID === BodySection.id) {
				DesiredHeight = CurrentElementData.Height;
				break;
			}
		};

		if (typeof DesiredHeight === 'undefined' ) {
			console.warn("DesiredHeight is undefined :(");
			return false;
		};

		if ( $(BodySection).css("display") == "block" ) {
			$(BodySection).animate({height: 0}, 500, function() {
				$(BodySection).hide();
				$(HeaderSection).css({display: "block", "text-align": "center"});
			});
		}
		else {
			$(BodySection).show();
			$(BodySection).animate({height: DesiredHeight}, 500, function() {
				$(BodySection).css("height", "");
				$(HeaderSection).css({display: "inline-block", "text-align": ""});
			});
		}
	}
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