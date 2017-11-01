"use strict";
RecipeDB.page = {};
RecipeDB.page.transient = {};
RecipeDB.page.constants = {};

RecipeDB.page.constants.RECIPE_LIST_TABLE_ID = "RecipeList-Table";

RecipeDB.page.init = function() {

	$("#" + this.constants.RECIPE_LIST_TABLE_ID).DataTable(
		{
			// initComplete: RecipeDB.RecipeList.Methods.onListUpdated,
			drawCallback: RecipeDB.page.onListUpdated,
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
					"data":"RECIPEID",
					"render":{  
						_:"display",
						"sort":"sortdata"
					}
				}					
			],
			ajax: {
				dataSrc: "data",
				url: "Controllers/Recipes.cfc?method=getRecipeListData",
				type: "GET",
				dataType: "json"
			}
		}
	);

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

	if ( Number.isNaN(RecipeID) === true && RecipeID < 1) {
		console.warn("openRecipe(): RecipeID is not a number or less than 1!");
		return false;
	};
	
	window.location.href = "Recipe.cfm?RecipeID=" + RecipeID;
};