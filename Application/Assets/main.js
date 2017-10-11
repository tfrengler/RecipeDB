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
	if (AjaxResponse instanceof String === false) {
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
	},

	FindRecipesOption: {
		ID: "RecipeList"
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

	$("#" + RecipeDB.Menu.DOM.ElementData.FindRecipesOption.ID).click(function() {
		RecipeDB.Menu.Methods.getRecipeList();
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

	getRecipeList: function() {
		$.ajax({
			type: "post",
			url: "../Controllers/RecipeController.cfc",
			data: {
				method: "getRecipeListView"
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

	$( "[name='" + RecipeDB.Recipe.DOM.ElementData.SectionHeaders.Name + "']" ).click(function() {
		RecipeDB.Recipe.Methods.openCloseSection(this)
	});

	$("#" + RecipeDB.Recipe.DOM.ElementData.Picture.ID).load(function() {
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

RecipeDB.Recipe.Methods.viewRecipe = function(RecipeID) {
	$.ajax({
		type: "post",
		url: "../Controllers/RecipeController.cfc",
		data: {
			method: "getRecipeView",
			recipeID: RecipeID
		},
		dataType: "html",

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

	RecipeDB.Recipe.Methods.viewRecipe( AjaxResponse.NewRecipeID );
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

/* RECIPELIST.CFM*/

RecipeDB.RecipeList = {
	DOM: {
		Pointers: {},
		ElementData: {}
	},
	Methods: {}
};

RecipeDB.RecipeList.ElementData = {

	RecipeListTable: {
		ID: "RecipeList-Table"
	}

};

RecipeDB.RecipeList.init = function() {

	$("#" + RecipeDB.RecipeList.ElementData.RecipeListTable.ID).DataTable(
		{
			// initComplete: RecipeDB.RecipeList.Methods.onListUpdated,
			drawCallback: RecipeDB.RecipeList.Methods.onListUpdated,
			columnDefs: [
				{ targets: '_all', className: "dt-head-center dt-body-left" }, /* This is for adding classes that control the alignment of the data, in this case centered th-text and left aligned td-text */
			],
			order: [[2, "asc"]], /* Which column you want to order the table by, in this case the third colum (Created on) in ascending order */
			paging: true, /* enabling or disabling pagination. Set this to false and the lengthChange and lengthMenu will be ignored. Enable this if you want to test pagination */
			fixedHeader: false, /* A plugin for datatables that allows the header row to stay in place when scrolling*/
			searching: true, /* Self-explanatory */
			lengthChange: true, /* Whether to allow users to change the amount of rows shown */
			lengthMenu: [10,20,30,40,50], /* The options shown in the length menu */
			autoWidth: true, /* Auto scales the cell sizes based on content, if false it divides the cell width equally among all the cells */
			sPaginationType: "simple_numbers", /* The type of pagination, see the manual for more examples */

			columns: [
				{
					"data":"NAME",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				},
				{
					"data":"CREATEDBYUSER",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				},
				{
					"data":"DATECREATED",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				},
				{
					"data":"LASTMODIFIEDBYUSER",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				},
				{
					"data":"DATETIMELASTMODIFIED",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				},
				{
					"data":"INGREDIENTS",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				},
				{
					"data":"RECIPEID",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				}					
			],
			ajax: {
				dataSrc: "data",
				url: "../Controllers/RecipeController.cfc?method=getRecipeListData",
				type: "GET",
				dataType: "json"
			}
		}
	);
};

RecipeDB.RecipeList.Methods.onListUpdated = function() {
	$("#RecipeList-Table tbody tr").click( function() {
		RecipeDB.RecipeList.Methods.openRecipe(this);
	});
};

RecipeDB.RecipeList.Methods.openRecipe = function(Caller) {
	/* Caller is the row, so we need to get the last child, which SHOULD be the RecipeID */

	var RecipeID = 0;
	RecipeID = Caller.children[ (Caller.children.length-1) ].innerHTML.trim();
	RecipeID = parseInt(RecipeID);

	if ( Number.isNaN(RecipeID) === true && RecipeID < 1) {
		console.warn("RecipeDB.RecipeList.Methods.openRecipe(): RecipeID is not a number or less than 1!");
		RecipeDB.Main.Methods.onAJAXCallError(arguments);
		return false;
	};
	
	RecipeDB.Recipe.Methods.viewRecipe( RecipeID );
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