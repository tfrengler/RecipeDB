<cfprocessingdirective pageEncoding="utf-8" />
<cfparam name="URL.fileName" type="string" >

<cfset fileNameAndFullPath = "#application.settings.files.recipe.standard#\#URL.fileName#" />

<cfif fileExists(fileNameAndFullPath) IS false >
	<cfcontent type="image/jpeg;charset=UTF-8" file="../Assets/Pictures/Standard/ImageNotFound.jpeg" />
</cfif>

<cfif fileGetMimeType(fileNameAndFullPath) IS NOT "image/png" >
	<cfcontent type="image/jpeg;charset=UTF-8" file="../Assets/Pictures/Standard/ImageNotFound.jpeg" />
</cfif>

<cfif isImageFile(fileNameAndFullPath) IS false >
	<cfcontent type="image/jpeg;charset=UTF-8" file="../Assets/Pictures/Standard/ImageNotFound.jpeg" />
</cfif>

<cfcontent type="image/png;charset=UTF-8" file=#fileNameAndFullPath# />