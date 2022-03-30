<!--- INCLUDE FILE --->
<cfparam name="NonceValue" type="string" default="" />

<section>
	<h1 id="Change-Password-Welcome" class="olive-text-color-center" >Change password</h1>
</section>

<section id="Change-Password-Form-Wrapper" >
	<form id="Change-Password-Form" class="olive-wrapper-grey-background standard-rounded-corners col-lg-2 col-lg-offset-5 col-sm-4 col-sm-offset-4 standard-box-shadow" >

		<span id="">YOUR NEW PASSWORD:</span>
		<input name="Change-Password" id="Change-Password-1" class="form-control" type="password" minlength="4" maxlength="24" value="" placeholder="password" />
		<br/>

		<span id="">REPEAT YOUR NEW PASSWORD:</span>
		<input name="Change-Password" id="Change-Password-2" class="form-control" type="password" minlength="4" maxlength="24" value="" placeholder="password" />
		<br/>

		<span>The max allowed length of your password is 24 characters. The minimum is 4. Other than that it's entirely up to you.</span>

		<br/><br/>

		<input id="Show-Password-Button" type="button" value="SHOW CHARACTERS" class="standard-button btn-block" />
		<input id="Change-Password-Button" type="button" value="CHANGE" class="standard-button btn-block" />

	</form>
</section>