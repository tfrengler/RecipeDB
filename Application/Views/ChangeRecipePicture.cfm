<!--- DIALOG/POP-FILE FILE --->
<cfprocessingdirective pageEncoding="utf-8" />

<script type="text/javascript" src="Assets/JS/changepicture.js" ></script>

<section id="Change-Picture-Form-Wrapper" >
	<form id="Change-Picture-Form" class="olive-wrapper-grey-background" >

		<p>
			<input name="New-Picture" id="New-Picture" class="form-control" type="file" accept="" />
		</p>
		
		<ul>
			<li>You may upload files of type <b>PNG, JPEG or GIF</b></li>
			<li>The max filesize you may upload is <b>5 mb</b></li>
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

<script type="text/javascript">
	<cfoutput>#toScript(application.fileManager.getMaxFileSize(), "RecipeDB.changepicture.constants.MAX_FILE_SIZE", false)#</cfoutput>
	<cfoutput>#toScript(application.fileManager.getAcceptedMimeTypes(), "RecipeDB.changepicture.constants.ACCEPTED_MIME_TYPES", false)#</cfoutput>
	$(document).ready(RecipeDB.changepicture.init);
</script>