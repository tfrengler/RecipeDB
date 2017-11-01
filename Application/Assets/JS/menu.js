"use strict";
RecipeDB.menu = {};

RecipeDB.menu.transient = {};
RecipeDB.menuWidth = 0;

RecipeDB.menu.constants = {};

RecipeDB.menu.constants.MENU_ID = "side-menu";
RecipeDB.menu.constants.MENU_OPTIONS_ID = "menu-options";
RecipeDB.menu.constants.CLOSE_BUTTON_ID = "Close-Menu-Button";
RecipeDB.menu.constants.OPEN_BUTTON_ID = "Open-Menu-Button";

RecipeDB.menu.init = function() {
	this.setMenuDimensions();
	
	$(document).resize(function() {
		this.onResize();
	});
	$("#" + this.constants.CLOSE_BUTTON_ID).click(function() {
		RecipeDB.menu.hide();
	});
	$("#" + this.constants.OPEN_BUTTON_ID).click(function() {
		RecipeDB.menu.show();
	});

	$(document).resize(function() {
		RecipeDB.menu.onResize();
	});

	console.log("Menu init complete");
};

RecipeDB.menu.hide = function() {
	$("#" + this.constants.MENU_OPTIONS_ID).hide(200);
	$("#" + this.constants.MENU_ID).animate({width: 0}, 500);
};

RecipeDB.menu.show = function() {
	$("#" + this.constants.MENU_ID).animate({width: this.transient.menuWidth}, 500);
	$("#" + this.constants.MENU_OPTIONS_ID).show(500);
};

RecipeDB.menu.onResize = function() {
	this.setMenuDimensions();
};

RecipeDB.menu.setMenuDimensions = function() {
	this.transient.menuWidth = parseFloat( $("#" + this.constants.MENU_ID).css("width") ) + 1;
};