<!--- DIALOG/POP-FILE FILE --->
<cfparam name="NonceValue" type="string" default="" />
<cfoutput><script nonce=#NonceValue# type="module" src="Assets/JS/changepicture.js" ></script></cfoutput>

<section id="Change-Picture-Form-Wrapper" >
	<form id="Change-Picture-Form" class="olive-wrapper-grey-background" >

		<p>
			<input name="New-Picture" id="New-Picture" class="form-control" type="file" accept="" />
		</p>

		<ul>
			<li>You may upload files of type <b id="AllowedFileTypesInfo" ></b></li>
			<li>The max filesize you may upload is <b id="AllowedFileSizeInfo"></b></li>
			<li>If you upload large pictures, they will automatically be resized down to <b>450 by 300 pixels</b></li>
		</ul>

		<input id="Upload-Picture-Button" type="button" value="UPLOAD" disabled class="disabled-input btn-block" />

	</form>
</section>

<hr/>

<div id="Dialog-Notification-Box" class="notification-box" ></div>

<section id="Feedback-Area" class="olive-wrapper-grey-background display-none" >

	<div id="Picture-Preview-Area" class="display-none" >
		<p>YOUR UPLOADED PICTURE:</p>
		<p class="text-center" >
			<img id="Preview-Image" src="" class="img-responsive img-thumbnail" />
		</p>

		<br/><br/>

		<input id="Select-Picture-Button" type="button" value="USE THIS PICTURE" class="standard-button btn-block" />
	</div>

</section>