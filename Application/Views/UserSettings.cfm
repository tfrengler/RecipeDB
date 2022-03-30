<cfparam name="NonceValue" type="string" default="" />
<cfoutput>

<cfparam name="attributes.Username" type="string" default="[unknown username]" />
<cfparam name="attributes.DisplayName" type="string" default="[unknown display name]" />
<cfparam name="attributes.AccountCreationDate" type="string" default="[unknown creation date]" />
<cfparam name="attributes.TimesLoggedIn" type="numeric" default="[unknown login count]" />
<cfparam name="attributes.BrowserLastUsed" type="string" default="[unknown browser]" />

<cfparam name="attributes.RecipeListFilter" type="struct" default=#structNew()# />
<cfparam name="attributes.RecipeListType" type="string" />
<cfparam name="attributes.RecipeListSortColumn" type="string" />

<section>
	<h1 id="UserSettings-Welcome" class="olive-text-color-center" >My Settings</h1>
</section>

<section id="UserSettings-Wrapper" >

	<form id="User-Settings-Form" class="olive-wrapper-grey-background standard-rounded-corners col-lg-4 col-lg-offset-4 col-sm-8 col-sm-offset-2 standard-box-shadow" >
		<h3 class="olive-text-color-center" >USER</h3>

		<span id="DisplayNameLegend">DISPLAY NAME:</span> <i>(max 30 characters)</i>
		<input id="DisplayName" class="form-control" type="text" maxlength="30"  value="#encodeForHTML( attributes.DisplayName )#" />
		<br/>

		<span id="UsernameLegend">USERNAME:</span> <i>(max 20 characters)</i>
		<input id="Username" class="form-control" type="text" maxlength="20" value="#encodeForHTML( attributes.Username )#" />
		<br/>

		<span id="PasswordLegend">PASSWORD:&nbsp;</span><a href="ChangePassword.cfm"><input id="Change-Password-Button" class="standard-button" type="button" value="CHANGE" /></a>
		<input id="ObscuredPassword" class="form-control" type="text" value="********" disabled="disabled" />
		<br/>

		<span id="AccountCreationDateLegend">ACCOUNT CREATED:</span>
		<input id="AccountCreationDate" class="form-control" type="text" value="#encodeForHTML( DateFormat(attributes.AccountCreationDate, "dd/mm/yyyy") )#" disabled="disabled" />
		<br/>

		<span id="TimesLoggedInLegend">TIMES LOGGED IN:</span>
		<input id="TimesLoggedIn" class="form-control" type="text" value="#encodeForHTML( attributes.TimesLoggedIn )#" disabled="disabled" />
		<br/>

		<span id="BrowserLastUsedLegend">LOGGED IN WITH:</span>
		<input id="BrowserLastUsed" class="form-control" type="text" value="#encodeForHTML( attributes.BrowserLastUsed )#" disabled="disabled" />
		<br/>

		<button id="Save-User-Settings-Button" class="standard-button btn-block">
			<i class="fa fa-floppy-o" aria-hidden="true"></i>
			SAVE CHANGES
		</button>

	</form>

	<form id="RecipeList-Settings-Form" class="olive-wrapper-grey-background standard-rounded-corners col-lg-4 col-lg-offset-4 col-sm-8 col-sm-offset-2 standard-box-shadow" style="margin-top: 2em" >
		<h3 class="olive-text-color-center" >FIND RECIPES</h3>

		<div id="DefaultRecipeFilterLegend">DEFAULT RECIPE FILTER:</div>

		<div class="form-control-wrapper-white" >
			<div class="inline-block" >
				<input type="checkbox" name="FindRecipes-Filter" value="mineOnly" <cfif attributes.RecipeListFilter.mineOnly >checked</cfif> >&nbsp;mine only</input><br/>
				<input type="checkbox" name="FindRecipes-Filter" value="minePublic" <cfif attributes.RecipeListFilter.minePublic >checked</cfif> >&nbsp;mine only that are public</input><br/>
				<input type="checkbox" name="FindRecipes-Filter" value="minePrivate" <cfif attributes.RecipeListFilter.minePrivate >checked</cfif> >&nbsp;mine only that are private</input><br/>
			</div>

			<div class="inline-block" >
				<input type="checkbox" name="FindRecipes-Filter" value="mineEmpty" <cfif attributes.RecipeListFilter.mineEmpty >checked</cfif> >&nbsp;mine only that are empty</input><br/>
				<input type="checkbox" name="FindRecipes-Filter" value="mineNoPicture" <cfif attributes.RecipeListFilter.mineNoPicture >checked</cfif> >&nbsp;mine only without a picture</input><br/>
				<input type="checkbox" name="FindRecipes-Filter" value="othersOnly" <cfif attributes.RecipeListFilter.otherUsersOnly >checked</cfif> >&nbsp;from other users only</input><br/>
			</div>
		</div>
		<br/>

		<div id="SortOnColumnLegend">SORT RECIPE LIST ON COLUMN:</div>

		<div class="form-control-wrapper-white" >
			<div class="inline-block" >
				<input type="radio" name="FindRecipes-SortOn" value="Name" <cfif attributes.RecipeListSortColumn IS "Name" >checked</cfif> >&nbsp;Name</input><br/>
				<input type="radio" name="FindRecipes-SortOn" value="CreatedBy" <cfif attributes.RecipeListSortColumn IS "CreatedBy" >checked</cfif> >&nbsp;Created by</input><br/>
				<input type="radio" name="FindRecipes-SortOn" value="CreatedOn" <cfif attributes.RecipeListSortColumn IS "CreatedOn" >checked</cfif> >&nbsp;Created on</input>
			</div>

			<div class="inline-block" >
				<input type="radio" name="FindRecipes-SortOn" value="ModifiedOn" <cfif attributes.RecipeListSortColumn IS "ModifiedOn" >checked</cfif> >&nbsp;Modified on</input><br/>
				<input type="radio" name="FindRecipes-SortOn" value="Published" <cfif attributes.RecipeListSortColumn IS "Published" >checked</cfif> >&nbsp;Published</input><br/>
				<input type="radio" name="FindRecipes-SortOn" value="ID" <cfif attributes.RecipeListSortColumn IS "ID" >checked</cfif> >&nbsp;ID</input>
			</div>
		</div>
		<br/>

		<div id="ListTypeLegend">DEFAULT LIST TYPE:</div>

		<div class="form-control-wrapper-white" >
			<input type="radio" name="FindRecipes-ListType" value="full" <cfif attributes.RecipeListType IS "full">checked</cfif> >&nbsp;Full</input>
			<input type="radio" name="FindRecipes-ListType" value="simple" <cfif attributes.RecipeListType IS "simple">checked</cfif> >&nbsp;Simple</input>
		</div>
		<br/>

		<button id="Save-FindRecipes-Settings-Button" class="standard-button btn-block">
			<i class="fa fa-floppy-o" aria-hidden="true"></i>
			SAVE CHANGES
		</button>
	</form>
</section>

</cfoutput>