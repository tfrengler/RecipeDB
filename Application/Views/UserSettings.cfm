<cfprocessingdirective pageEncoding="utf-8" />
<cfoutput>

<cfparam name="attributes.Username" type="string" default="[unknown username]" />
<cfparam name="attributes.DisplayName" type="string" default="[unknown display name]" />
<cfparam name="attributes.AccountCreationDate" type="string" default="[unknown creation date]" />
<cfparam name="attributes.TimesLoggedIn" type="numeric" default="[unknown login count]" />
<cfparam name="attributes.BrowserLastUsed" type="string" default="[unknown browser]" />

<section>
	<h1 id="UserSettings-Welcome" class="olive-text-color-center" >My Settings</h1>
</section>

<section id="UserSettings-Form-Wrapper" >
	<form id="UserSettings-Form" class="olive-wrapper-grey-background standard-rounded-corners col-lg-4 col-lg-offset-4 col-sm-8 col-sm-offset-2 standard-box-shadow" >

		<span id="DisplayNameLegend">DISPLAY NAME:</span> 
		<input id="DisplayName" class="form-control" type="text" maxlength="30"  value="#encodeForHTML( attributes.DisplayName )#" />
		<br/>

		<span id="UsernameLegend">USERNAME:</span> 
		<input id="Username" class="form-control" type="text"  maxlength="20" value="#encodeForHTML( attributes.Username )#" />
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

		<input id="Save-UserSettings-Button" type="button" value="SAVE CHANGES" class="standard-button btn-block" />

	</form>
</section>

</cfoutput>