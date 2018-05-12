"use strict";
RecipeDB.page = {};
RecipeDB.page.transient = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.OPEN_FILTER_MENU_BUTTON_ID = "Open-Filter-Menu";
RecipeDB.page.constants.CLOSE_FILTER_MENU_BUTTON_ID = "Close-Filter-Menu";
RecipeDB.page.constants.FILTER_MENU_ID = "Filter-Menu";
RecipeDB.page.constants.FILTER_CHECKBOXES_CLASS = "FilterOption";
RecipeDB.page.constants.FILTER_MINE_ID = "Filter-Mine";
RecipeDB.page.constants.FILTER_MINE_PUBLIC_ID = "Filter-MinePublic";
RecipeDB.page.constants.FILTER_MINE_PRIVATE_ID = "Filter-MinePrivate";
RecipeDB.page.constants.FILTER_MINE_EMPTY_ID = "Filter-MineEmpty";
RecipeDB.page.constants.FILTER_MINE_NO_PICTURE_ID = "Filter-MineNoPicture";
RecipeDB.page.constants.FILTER_OTHER_ID = "Filter-Others";
RecipeDB.page.constants.CLEAR_FILTER_BUTTON_ID = "ClearFilter";
RecipeDB.page.constants.APPLY_FILTER_BUTTON_ID = "ApplyFilter";
RecipeDB.page.constants.NOTIFICATION_BOX = "Notification-Box";

RecipeDB.page.init = function() {

	$("#" + this.constants.CLOSE_FILTER_MENU_BUTTON_ID).click(function() {
		RecipeDB.page.openCloseFilterMenu(false);
	});

	$("#" + this.constants.OPEN_FILTER_MENU_BUTTON_ID).click(function() {
		RecipeDB.page.openCloseFilterMenu(true);
	});

	$("[class='" + this.constants.FILTER_CHECKBOXES_CLASS + "']").click(function() {
		RecipeDB.page.onSelectFilterOption(this)
	});

	$("#" + this.constants.CLEAR_FILTER_BUTTON_ID).click(function() {
		$("[class='" + RecipeDB.page.constants.FILTER_CHECKBOXES_CLASS + "']").prop("checked", false);
	});

	$("#" + this.constants.APPLY_FILTER_BUTTON_ID).click(this.applyFilter);
};

RecipeDB.page.openCloseFilterMenu = function(action) {
	var FilterMenu = $("#" + RecipeDB.page.constants.FILTER_MENU_ID);
	
	if (action === true) {
		FilterMenu.show();
	}
	else if (action === false) {
		FilterMenu.hide();
	}

};
RecipeDB.page.onSelectFilterOption = function(FilterOption) {
	var FilterOption = $(FilterOption);

	if (FilterOption.prop("checked") === false) {
		return;
	}

	if (FilterOption.attr("id") === RecipeDB.page.constants.FILTER_MINE_ID || FilterOption.attr("id") === RecipeDB.page.constants.FILTER_OTHER_ID) {
		$("[class='" + RecipeDB.page.constants.FILTER_CHECKBOXES_CLASS + "']").prop("checked", false);
		FilterOption.prop("checked", true);
	}

	if (FilterOption.attr("id") !== RecipeDB.page.constants.FILTER_MINE_ID && FilterOption.attr("id") !== RecipeDB.page.constants.FILTER_OTHER_ID) {
		$("#" + RecipeDB.page.constants.FILTER_MINE_ID).prop("checked", false);
		$("#" + RecipeDB.page.constants.FILTER_OTHER_ID).prop("checked", false);
	}
};

RecipeDB.page.applyFilter = function() {
	RecipeDB.main.ajaxLoadInnerHTML(true, $('#' + RecipeDB.page.constants.APPLY_FILTER_BUTTON_ID));
	RecipeDB.main.notifyUserOfLoading($('#' + RecipeDB.page.constants.NOTIFICATION_BOX));
	
	$("#FilterForm").submit();
};

RecipeDB.page.onRecipeImageLoaded = function(imageIdentifier) {
	var imagePointer = $("#RecipeImage_" + imageIdentifier);

	imagePointer.prev().hide();
	imagePointer.css("display", "block");
};