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

RecipeDB.Main.Methods.onGetViewComplete = function(AjaxResponse) {
	if (AjaxResponse instanceof String == false) {
		String( AjaxResponse )
	};

	$("#" + RecipeDB.Main.DOM.ElementData.MainContentContainer.ID).html( AjaxResponse );
};

RecipeDB.Main.Methods.onAJAXCallStart = function() {
	$('#' + RecipeDB.Main.DOM.ElementData.MainContentContainer.ID).html("<img class='center-block ajax-loader-container' src='../Assets/Pictures/Standard/ajax-loader.gif' />");
};

RecipeDB.Main.Methods.onAJAXCallError = function(AjaxResponse) {
	$('#' + RecipeDB.Main.DOM.ElementData.MainContentContainer.ID).html("<br/><div class='error-box col-md-2 col-md-offset-5' >Oh noes, something went wrong :( <br/>Please try again or contact the admin");
	$('.error-box').show();
	console.warn(AjaxResponse);
};

RecipeDB.Main.init = function() {
	console.log("Main init complete");
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
				RecipeDB.Utils.ajaxLoadButton(
					true,
					$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).prop("disabled", true)
				);
			
			},
			complete: function() {
				RecipeDB.Utils.ajaxLoadButton(
					false,
					$('#' + RecipeDB.LoginPage.DOM.ElementData.LoginButton.ID).prop("disabled", true),
					"OK"
				);
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
		$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).hide();

		$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).html("Internal error. Please try again or contact the administrator");
		$('#' + RecipeDB.LoginPage.DOM.ElementData.MessageBox.ID).fadeIn(1000);

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
	},

	AddRecipeOption: {
		ID: "AddRecipe"
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

	$("#" + RecipeDB.Menu.DOM.ElementData.AddRecipeOption.ID).click(function() {
		RecipeDB.Menu.Methods.getAddRecipe();
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

			beforeSend: function() {
				RecipeDB.Main.Methods.onAJAXCallStart();
			},
			error: function() {
				RecipeDB.Main.Methods.onAJAXCallError(arguments);
			},
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

			beforeSend: function() {
				RecipeDB.Main.Methods.onAJAXCallStart();
			},
			error: function() {
				RecipeDB.Main.Methods.onAJAXCallError(arguments);
			},
			success: function(ResponseData) {
				RecipeDB.Main.Methods.onGetViewComplete(ResponseData);
			}
		});
	},

	getAddRecipe: function() {
		$.ajax({
			type: "post",
			url: "../Controllers/RecipeController.cfc",
			data: {
				method: "getAddRecipeView"
			},
			dataType: "html",

			beforeSend: function() {
				RecipeDB.Main.Methods.onAJAXCallStart();
			},
			error: function() {
				RecipeDB.Main.Methods.onAJAXCallError(arguments);
			},
			success: function(ResponseData) {
				RecipeDB.Main.Methods.onGetViewComplete(ResponseData);
			}
		});
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

RecipeDB.Recipe.Methods.onResize = function() {
	RecipeDB.Recipe.Methods.setSectionDimensions();
	RecipeDB.Recipe.Methods.setPictureEditDimensions();
};

RecipeDB.Recipe.Methods.setSectionDimensions = function() {

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

};

RecipeDB.Recipe.Methods.setPictureEditDimensions = function() {

	$('#' + RecipeDB.Recipe.DOM.ElementData.PictureEdit.ID).css(
		'height', 
		$('#' + RecipeDB.Recipe.DOM.ElementData.Picture.ID).css('height')
	);

	$('#' + RecipeDB.Recipe.DOM.ElementData.PictureEdit.ID).css(
		'width', 
		$('#' + RecipeDB.Recipe.DOM.ElementData.Picture.ID).css('width')
	);

};

RecipeDB.Recipe.Methods.openCloseSection = function(Caller) {

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
};

RecipeDB.Recipe.Methods.onRecipeAdded = function(NewRecipeID) {
	$.ajax({
		type: "post",
		url: "../Controllers/RecipeController.cfc",
		data: {
			method: "getRecipeView",
			recipeID: 0
		},
		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.Main.Methods.onGetViewComplete(ResponseData);
		},
		error: function() {
			RecipeDB.Main.Methods.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			RecipeDB.Main.Methods.onAJAXCallStart();
		},
		complete: function() {

		}
	});	
};

/* ADD RECIPE.CFM */

RecipeDB.AddRecipe = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.AddRecipe.DOM.ElementData = {
	DuplicateAlertBox: {
		ID: "AddRecipe-DuplicateAlertBox"
	},
	AddRecipeButton: {
		ID: "AddNewRecipe-Button"
	},
	AddRecipeAnywayFlag: {
		ID: "AddNewRecipe-Anyway"
	},
	NewRecipeName: {
		ID: "AddRecipe-Name"
	},
	MessageBox: {
		ID: "AddRecipe-MessageBox"
	},
	DuplicateCheckBox: {
		ID: "DuplicateCheck"
	}
};

RecipeDB.AddRecipe.Methods.addNewRecipe = function() {
	var RecipeName = $("#" + RecipeDB.AddRecipe.DOM.ElementData.NewRecipeName.ID).val();
	var CheckForDuplicates = $("#" + RecipeDB.AddRecipe.DOM.ElementData.DuplicateCheckBox.ID).prop("checked");
	var AddNewRecipeAnyway = $("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeAnywayFlag.ID).val();;

	if ( AddNewRecipeAnyway == 1) {
		CheckForDuplicates = false;
	};

	$('#' + RecipeDB.AddRecipe.DOM.ElementData.DuplicateAlertBox.ID).hide();

	if (RecipeName.length === "" || RecipeName.length === 0) {
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.MessageBox.ID).html("The name of the recipe can't be blank. Please fill in something.");
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.MessageBox.ID).fadeIn(1000);
		return false;
	};

	$.ajax({
		type: "post",
		url: "../Controllers/RecipeController.cfc",
		data: {
			method: "addNewRecipe",
			Name: RecipeName,
			CheckForDuplicates: CheckForDuplicates
		},
		dataType: "json",

		success: function(ResponseData) {
			RecipeDB.Utils.ajaxLoadButton(
				false,
				$('#' + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID),
				"OK"
			);
			RecipeDB.AddRecipe.Methods.onAddRecipeSuccess(ResponseData);
		},
		error: function() {
			RecipeDB.Main.Methods.onAJAXCallError(arguments);
		},
		beforeSend: function() {
			$("#" + RecipeDB.AddRecipe.DOM.ElementData.MessageBox.ID).hide().html("");

			RecipeDB.Utils.ajaxLoadButton(
				true,
				$('#' + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID)
			);
		},
		complete: function() {

		}
	});
};

RecipeDB.AddRecipe.Methods.onAddRecipeSuccess = function(AjaxResponse) {
	if (AjaxResponse instanceof Object === false && typeof AjaxResponse.NewRecipeID === "undefined") {
		RecipeDB.Main.onAJAXCallError();
	};

	if (AjaxResponse.DuplicatesFound === true) {
		$('#' + RecipeDB.AddRecipe.DOM.ElementData.DuplicateAlertBox.ID).html( AjaxResponse.DuplicatesView );
		$('#' + RecipeDB.AddRecipe.DOM.ElementData.DuplicateAlertBox.ID).fadeIn(1000);
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID).val("ADD ANYWAY");
		$("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeAnywayFlag.ID).val(1);
		return false;
	}

	RecipeDB.Recipe.Methods.onRecipeAdded( AjaxResponse.NewRecipeID );
};

RecipeDB.AddRecipe.init = function() {
	$("#" + RecipeDB.AddRecipe.DOM.ElementData.AddRecipeButton.ID).click(function() {
		RecipeDB.AddRecipe.Methods.addNewRecipe(false);
	});
};

/* DUPLICATES RECIPES LIST CFM */

RecipeDB.DuplicatesRecipesList = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.DuplicatesRecipesList.init = function() {

};

/* UTILITIES */

RecipeDB.Utils = {};

RecipeDB.Utils.upperCaseStructKeys = function(Structure) {
	var ReturnData = {};
	var Key = {};

	for (Key in Structure) {
		ReturnData[ Key.toUpperCase() ] = Structure[Key];
	};

	return ReturnData;
};

RecipeDB.Utils.ajaxLoadButton = function(Enable, DOMPointer, Label) {

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