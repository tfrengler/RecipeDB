"use strict";

var RecipeDB = {};

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
}

/* MAIN MENU */

RecipeDB.Menu = {
	MenuID :"side-menu",
	MenuOptionsID :"menu-options"
};

RecipeDB.Menu.SetMenuDimensions = function() {
	this.MenuWidth = parseFloat( $("#" + RecipeDB.Menu.MenuID).css("width") );
};

RecipeDB.Menu.Show = function() {
	$("#" + this.MenuID).animate({width: this.MenuWidth}, 500);
	$("#" + this.MenuOptionsID).show(500);
};

RecipeDB.Menu.Hide = function() {
	$("#" + this.MenuOptionsID).hide(200);
	$("#" + this.MenuID).animate({width: 0}, 500);
};

/* SETTING EVENT HANDLERS */

$(document).ready(function() {
	RecipeDB.Recipe.SetSectionDimensions();
	RecipeDB.Menu.SetMenuDimensions();

	$("[name='Recipe-Header']").click(function() {
		RecipeDB.Recipe.OpenCloseSection(this)
	});

	$("#Recipe-Picture").load(function() {
		RecipeDB.Recipe.SetPictureEditDimensions();
	});

	$("#Close-Menu-Button").click(function() {
		RecipeDB.Menu.Hide();
	});
	$("#Open-Menu-Button").click(function() {
		RecipeDB.Menu.Show();
	});
});

$(window).resize(function() {
	RecipeDB.Recipe.SetSectionDimensions();
	RecipeDB.Recipe.SetPictureEditDimensions();
	RecipeDB.Menu.SetMenuDimensions
});