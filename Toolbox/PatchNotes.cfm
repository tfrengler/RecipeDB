<cfinclude template="CheckAuth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: Patch notes</title>

	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<script type="text/javascript" src="../Application/Assets/Libs/tinymce/tinymce.min.js" ></script>
	<script type="text/javascript">
		window.onload = function() {
			tinyMCE.init(
				{
					selector: "textarea",
					plugins: "paste,lists,code",
					paste_as_text: true
				} 
			);
			document.getElementById("SavePatchNotes").addEventListener("click", saveChanges);
		};

		function saveChanges() {
			var PatchNoteContentsToSave = tinyMCE.get("PatchNotes").getContent();
			document.getElementsByName("Saved_PatchNote_FileContents")[0].value = PatchNoteContentsToSave;
			document.getElementsByName("Save_PatcNote_Changes_Form")[0].submit();
		};
	</script>

	<style type="text/css">
		fieldset {
			width: 50%;
		}

		.bad {
			background-color: red;
			color: white;
			font-weight: bold;
			width: 30%;
		}

		.good {
			background-color: green;
			color: white;
			font-weight: bold;
			width: 30%;
		}
	</style>
</head>

<body>

	<p><a href="CommunicationTools.cfm" >Back to Communcation Tools</a></p>
	<h1>Patch notes</h1>

	<cfset PatchNoteDirectory = application.settings.files.patchnotes />

	<cfif directoryExists(PatchNoteDirectory) >

		<cfdirectory directory=#application.settings.files.patchnotes# filter="*.html" action="list" name="ExistingPatchNotes" type="file" >
		<cfset PatchDirDoesNotExist = false />

		<cfif structIsEmpty(FORM) IS false >
			<!--- SAVING FILE --->
			<cfif 	structKeyExists(FORM, "Saved_PatchNote_FileContents") AND
					structKeyExists(FORM, "Saved_PatchNote_FileName") AND 
					len(FORM.Saved_PatchNote_FileName) GT 0 >

				<cffile 
					action="write" 
					file="#PatchNoteDirectory#/#FORM.Saved_PatchNote_FileName#" 
					output="#FORM.Saved_PatchNote_FileContents#" 
					charset="utf-8" 
					nameconflict="overwrite"
				/>
				<cfset ChangesSaved = true />

			<cfelseif structKeyExists(FORM, "Saved_PatchNote_FileName") AND len(FORM.Saved_PatchNote_FileName) IS 0 >
				<cfset UnableToSave = true />
			</cfif>

			<!--- LOADING FILE --->
			<cfif structKeyExists(FORM, "PatchNote_FileName") AND len(FORM.PatchNote_FileName) GT 0 >
				<cffile 
					action="read" 
					file="#PatchNoteDirectory#/#FORM.PatchNote_FileName#" 
					variable="PatchNoteFileContents" 
					charset="utf-8"
				/>
			<cfelseif structKeyExists(FORM, "PatchNote_FileName") AND len(FORM.PatchNote_FileName) IS 0 >
				<cfset UnableToLoad = true />
			</cfif>
		</cfif>

	<cfelse>
		<cfset PatchDirDoesNotExist = true />
	</cfif>

	<cfparam name="PatchNoteFileContents" type="string" default="" />

	<fieldset>
		<legend>LOAD EXISTING PATCH NOTE</legend>

		<form name="Load_Existing_PatchNotes_Form" action="PatchNotes.cfm" method="post" >

			<cfloop query=#ExistingPatchNotes# >
				<input type="checkbox" name="PatchNote_FileName" value=#ExistingPatchNotes.name# />
				<span>#ExistingPatchNotes.name#</span>
				<br/>
			</cfloop>

			<br/>
			<input type="submit" value="LOAD" />

		</form>
	</fieldset>

	<br/>
	<hr/>
	<br/>

	<fieldset>
		<legend>EDIT PATCH NOTE</legend>

		<section name="PatchNote-Container" >
			<textarea id="PatchNotes" >
				#PatchNoteFileContents#
			</textarea>
		</section>

		<br/>

		<form name="Save_PatcNote_Changes_Form" action="PatchNotes.cfm" method="post" >

			<input type="hidden" name="Saved_PatchNote_FileContents" value="" />

			<input id="SavePatchNotes" type="button" value="SAVE" />
			<span>| SAVE AS: </span>
			<input type="text" name="Saved_PatchNote_FileName" value="<cfif structKeyExists(FORM, "PatchNote_FileName") AND len(FORM.PatchNote_FileName) GT 0>#FORM.PatchNote_FileName#</cfif>" />

		</form>
	</fieldset>

	<cfparam name="ChangesSaved" type="boolean" default="false" />
	<cfparam name="UnableToSave" type="boolean" default="false" />
	<cfparam name="UnableToLoad" type="boolean" default="false" />

	<cfif ChangesSaved >
		<p class="good">CHANGES SAVED!</p>
	</cfif>

	<cfif UnableToSave >
		<p class="bad">UNABLE TO SAVE! Filename is empty</p>
	</cfif>

	<cfif UnableToLoad >
		<p class="bad">UNABLE TO LOAD! Filename is empty</p>
	</cfif>

	<cfif PatchDirDoesNotExist >
		<p class="bad">Patch notes-folder does not exist: #PatchNoteDirectory#</p>
	</cfif>	

</body>

</cfoutput>
</html>