<cfprocessingdirective pageEncoding="utf-8" />

<cfparam name="attributes.Username" default="[unknown username]" />
<cfparam name="attributes.DisplayName" default="[unknown display name]" />
<cfparam name="attributes.AccountCreationDate" default="[unknown creation date]" />
<cfparam name="attributes.TimesLoggedIn" default="[unknown login count]" />
<cfparam name="attributes.BrowserLastUsed" default="[unknown browser]" />

<cfoutput>

<h1 id="UserSettings-Welcome" class="olive-text-color-center" >My Settings</h1>

<form id="UserSettings-Form" class="olive-wrapper-grey-background col-md-4 col-md-offset-4" >

	<span id="DisplayNameLegend">DISPLAY NAME:</span> 
	<input id="DisplayName" class="form-control" type="text" value="#encodeForHTML( attributes.DisplayName )#" />
	<br/>

	<span id="UsernameLegend">USERNAME:</span> 
	<input id="Username" class="form-control" type="text" value="#encodeForHTML( attributes.Username )#" />
	<br/>

	<!--- <span id="PasswordLegend">PASSWORD:</span>
	<input id="SecretKey" class="form-control" type="text" value="********" /> NEED SOME OTHER MECHANISM FOR CHANGING PASSWORD, A DIALOG OR A SEPARATE PAGE
	<br/> --->

	<span id="AccountCreationDateLegend">ACCOUNT CREATED:</span> 
	<input id="AccountCreationDate" class="form-control" type="text" value="#encodeForHTML( DateFormat(attributes.AccountCreationDate, "dd/mm/yyyy") )#" disabled="disabled" />
	<br/>

	<span id="TimesLoggedInLegend">TIMES LOGGED IN:</span> 
	<input id="TimesLoggedIn" class="form-control" type="text" value="#encodeForHTML( attributes.TimesLoggedIn )#" disabled="disabled" />
	<br/>

	<span id="BrowserLastUsedLegend">LOGGED IN WITH BROWSER:</span> 
	<input id="BrowserLastUsed" class="form-control" type="text" value="#encodeForHTML( attributes.BrowserLastUsed )#" disabled="disabled" />
	<br/>

	<input id="Save-UserSettings-Button" type="button" value="SAVE CHANGES" class="standard-button btn-block" />

</form>

<div id="UserSettings-MessageBox" class="center-block" ></div>

<script type="text/javascript">
	$(document).ready(function() {
		RecipeDB.UserSettings.init();
	});
</script>

</cfoutput>