<cfinclude template="CheckAuth.cfm" />

<!DOCTYPE html>
<html lang="en" >
<cfoutput>

<head>
	<title>Toolbox: Roadmap</title>

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
			document.getElementById("SaveRoadmap").addEventListener("click", saveChanges);
		};

		function saveChanges() {
			var PatchNoteContentsToSave = tinyMCE.get("Roadmap").getContent();
			document.getElementsByName("Saved_Roadmap_FileContents")[0].value = PatchNoteContentsToSave;
			document.getElementsByName("Save_Roadmap_Changes_Form")[0].submit();
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
	<h1>Roadmap</h1>

	<cfset RoadmapDirectory = application.settings.files.roadmap />

	<cfif directoryExists(RoadmapDirectory) >
		<cfset RoadmapDirNotExists = false />

		<cfif structIsEmpty(FORM) IS false >
			<!--- SAVING FILE --->
			<cfif structKeyExists(FORM, "Saved_Roadmap_FileContents") >

				<cffile 
					action="write" 
					file="#RoadmapDirectory#/Roadmap.html" 
					output="#FORM.Saved_Roadmap_FileContents#" 
					charset="utf-8" 
					nameconflict="overwrite"
				/>
				<cfset ChangesSaved = true />
			</cfif>

		</cfif>

		<cffile 
			action="read" 
			file="#RoadmapDirectory#/Roadmap.html" 
			variable="RoadmapFileContents" 
			charset="utf-8"
		/>
	<cfelse>
		<cfset RoadmapDirNotExists = true />
	</cfif>

	<fieldset>
		<legend>EDIT ROADMAP</legend>

		<section name="Roadmap-Container" >
			<textarea id="Roadmap" >
				#RoadmapFileContents#
			</textarea>
		</section>

		<br/>

		<form name="Save_Roadmap_Changes_Form" action="Roadmap.cfm" method="post" >

			<input type="hidden" name="Saved_Roadmap_FileContents" value="" />
			<input id="SaveRoadmap" type="button" value="SAVE" />

		</form>
	</fieldset>

	<cfparam name="ChangesSaved" type="boolean" default="false" />

	<cfif ChangesSaved >
		<p class="good">CHANGES SAVED!</p>
	</cfif>

	<cfif RoadmapDirNotExists >
		<p class="bad">Roadmap notes-folder does not exist: #RoadmapDirectory#</p>
	</cfif>	

</body>

</cfoutput>
</html>