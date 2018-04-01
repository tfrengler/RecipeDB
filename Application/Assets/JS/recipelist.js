"use strict";
RecipeDB.page = {};
RecipeDB.page.transient = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.RECIPE_LIST_TABLE_ID = "RecipeList-Table";
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

RecipeDB.page.constants.RECIPE_LIST_COLUMNS_SETUP = [
	{
		data: "NAME",
		render: {
			_:"display"
		}
	},
	{
		data: "CREATEDBYUSER",
		render: {
			_:"display"
		}
	},
	{
		data: "DATECREATED",
		render: {  
			_:"display",
			sort: "sortdata"
		}
	},
	{
		data: "DATETIMELASTMODIFIED",
		render: {
			_:"display",
			sort: "sortdata"
		}
	},
	{
		data: "PUBLISHED",
		render: function(data, type, row, meta) {
			if (type === "sort") {
				return parseInt(data.display);
			}

			if (data.display == 0) {
				return "no"
			}
			else if (data.display == 1) {
				return "yes"
			} else {
				return data.display
			}
		}
	},
	{
		data: "RECIPEID",
		render: {  
			_:"display"
		}
	}					
];

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

	this.setupRecipeList();

	console.log("Page init complete");
};

RecipeDB.page.onListUpdated = function() {
	$("#" + RecipeDB.page.constants.RECIPE_LIST_TABLE_ID + " tbody tr").click( function() {
		RecipeDB.page.openRecipe(this);
	});
};

RecipeDB.page.openRecipe = function(Caller) {
	/* Caller is the row, so we need to get the last child, which SHOULD be the RecipeID */

	var RecipeID = 0;
	RecipeID = Caller.children[ (Caller.children.length-1) ].innerHTML.trim();
	RecipeID = parseInt(RecipeID);

	if ( Number.isNaN(RecipeID) === true || RecipeID < 1) {
		RecipeDB.main.onJavascriptError("RecipeID is not a number or less than 1!", "RecipeDB.page.openRecipe");
		return false;
	};
	
	window.location.href = "Recipe.cfm?RecipeID=" + RecipeID;
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
	FilterOption = $(FilterOption);

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

RecipeDB.page.setupRecipeList = function() {
	try {
		$("#" + RecipeDB.page.constants.RECIPE_LIST_TABLE_ID).DataTable(
			{
				// initComplete: RecipeDB.RecipeList.Methods.onListUpdated,
				drawCallback: RecipeDB.page.onListUpdated,
				columnDefs: [
					{ targets: '_all', className: "dt-head-center dt-body-left" }, /* This is for adding classes that control the alignment of the data, in this case centered th-text and left aligned td-text */
				],
				order: [[2, "desc"]], /* Which column you want to order the table by, in this case the third colum (Created on) in ascending order */
				paging: true, /* enabling or disabling pagination. Set this to false and the lengthChange and lengthMenu will be ignored. Enable this if you want to test pagination */
				fixedHeader: false, /* A plugin for datatables that allows the header row to stay in place when scrolling*/
				searching: true, /* Self-explanatory */
				lengthChange: true, /* Whether to allow users to change the amount of rows shown */
				lengthMenu: [10,20,30,40,50], /* The options shown in the length menu */
				autoWidth: true, /* Auto scales the cell sizes based on content, if false it divides the cell width equally among all the cells */
				sPaginationType: "simple_numbers", /* The type of pagination, see the manual for more examples */
				columns: RecipeDB.page.constants.RECIPE_LIST_COLUMNS_SETUP,

				ajax: {
					dataSrc: "data",
					type: "post",
					url: "Components/AjaxProxy.cfc",
					data: this.getAJAXData
				}
			}
		);
	}
	catch(CatchError) {
		RecipeDB.main.onJavascriptError(CatchError, "RecipeDB.page.setupRecipeList");
	};

};

RecipeDB.page.getFilter = function() {

	var filter = {};

	if ($("#" + RecipeDB.page.constants.FILTER_MINE_ID).prop("checked") == true) {
		filter.mineOnly = true;
	};
	if ( $("#" + RecipeDB.page.constants.FILTER_MINE_PUBLIC_ID).prop("checked") == true) {
		filter.minePublic = true;
	}
	if ( $("#" + RecipeDB.page.constants.FILTER_MINE_PRIVATE_ID).prop("checked") == true) {
		filter.minePrivate = true;
	}
	if ( $("#" + RecipeDB.page.constants.FILTER_MINE_EMPTY_ID).prop("checked") == true) {
		filter.mineEmpty = true;
	}
	if ( $("#" + RecipeDB.page.constants.FILTER_MINE_NO_PICTURE_ID).prop("checked") == true) {
		filter.mineNoPicture = true;
	}
	if ( $("#" + RecipeDB.page.constants.FILTER_OTHER_ID).prop("checked") == true) {
		filter.othersOnly = true;
	};

	return filter;
};

RecipeDB.page.applyFilter = function() {
	RecipeDB.main.ajaxLoadInnerHTML(true, $('#' + RecipeDB.page.constants.APPLY_FILTER_BUTTON_ID));
	RecipeDB.main.notifyUserOfLoading($('#' + RecipeDB.page.constants.NOTIFICATION_BOX));
	$("#" + RecipeDB.page.constants.RECIPE_LIST_TABLE_ID).DataTable().ajax.reload(RecipeDB.page.onApplyFilterComplete);
};

RecipeDB.page.getAJAXData = function() {

	var data = {
		method: "call",
		argumentCollection: {
			controller: "GetRecipeListDataFull",
			authKey: RecipeDB.main.constants.AUTH_KEY,
			parameters: {}
		}
	};

	var filterSettings = RecipeDB.page.getFilter();

	if (Object.keys(filterSettings).length > 0) {
		data.argumentCollection.parameters.filterSettings = filterSettings;
	};

	data.argumentCollection = JSON.stringify(data.argumentCollection);
	return data;
};

RecipeDB.page.onApplyFilterComplete = function() {
	RecipeDB.main.ajaxLoadInnerHTML(false, $('#' + RecipeDB.page.constants.APPLY_FILTER_BUTTON_ID));
	$('#' + RecipeDB.page.constants.NOTIFICATION_BOX).hide();
};