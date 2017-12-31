<cfprocessingdirective pageEncoding="utf-8" />
<cfcontent type="application/json;charset=UTF-8" />

<cfoutput>

<cfparam name="FORM.RecipeID" type="numeric" >
<cfparam name="FORM.AuthKey" type="string" />
<cfparam name="FORM['New-Picture']" type="string" />

<cfset returnData = {
	statuscode: 0,
	data: ""
} />

<cfif session.AuthKey IS NOT FORM.AuthKey >

	<cfset returnData.statuscode = 1 />
	#serializeJSON(returnData)#

</cfif>

<cfif fileExists(FORM['New-Picture']) IS false >

	<cfset returnData.statuscode = 2 />
	#serializeJSON(returnData)#

</cfif>

<cfif listFind(application.fileManager.getAcceptedMimeTypes(), fileGetMimeType(FORM['New-Picture'])) IS 0 AND isImageFile(FORM['New-Picture']) IS false >

	<cfset returnData.statuscode = 3 />
	#serializeJSON(returnData)#

</cfif>

<cffile 
	action="upload"
	filefield="New-Picture"
	destination=#application.settings.files.temp#
	attributes="readonly"
	nameconflict="makeunique"
	result="tempFileInfo"
/>

<cfif tempFileInfo.fileSize GT application.fileManager.getMaxFileSize() >

	<cfset returnData.statuscode = 4 />
	#serializeJSON(returnData)#

</cfif>

<cfset uploadImageResponse = application.fileManager.uploadImage(
	fileName="#tempFileInfo.serverFileName#.#tempFileInfo.serverFileExt#"
) />

<cfset Recipe = createObject("component", "Models.Recipe").init( 
	ID=FORM.RecipeID,
	Datasource=application.Settings.Datasource
) />

<cfset Recipe.setPicture(ID=listFirst(uploadImageResponse, ".")) />
<cfset Recipe.save() />

<cfset returnData.data = uploadImageResponse />
#serializeJSON(returnData)#

</cfoutput>