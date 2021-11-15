<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8" />

	<!--- AJAX METHOD --->
	<cffunction name="main" access="public" returntype="struct" returnformat="JSON" output="false" hint="" >
		<cfargument name="RecipeID" type="numeric" required="true" />
		<cfargument name="Files" type="array" required="true" />

		<cfset var returnData = {
			statuscode: 0,
			data: ""
		} />

		<cfset var fullPathToTempFile = "" />

		<cfif arguments.RecipeID LTE 0 >

			<cfheader statuscode="500" />

			<cfset returnData.statuscode = 1 />
			<cfreturn returnData />

		</cfif>

		<cfif arrayIsEmpty(arguments.Files) >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 2 />
			<cfreturn returnData />

		</cfif>

		<cfif arrayLen(arguments.Files) GT 1 >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 3 />
			<cfreturn returnData />

		</cfif>

		<cfset fullPathToTempFile = application.settings.files.temp & "\" & arguments.Files[1].serverFile />

		<cfif fileExists( fullPathToTempFile ) IS false >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 4 />
			<cfreturn returnData />

		</cfif>

		<cfset var Recipe = createObject("component", "Models.Recipe").init(arguments.RecipeID) />

		<cfif Recipe.getCreatedByUser().getId() IS NOT session.CurrentUser.getId() >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 5 />

			<cfset application.fileManager.deleteTempFile(file=fullPathToTempFile) />
			<cfreturn returnData />

		</cfif>

		<cfif listFind(application.fileManager.getAcceptedMimeTypes(), fileGetMimeType(fullPathToTempFile)) IS 0 AND isImageFile(fullPathToTempFile) IS false >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 6 />

			<cfset application.fileManager.deleteTempFile(file=fullPathToTempFile) />
			<cfreturn returnData />

		</cfif>

		<cfif arguments.Files[1].fileSize GT application.fileManager.getMaxFileSize() >

			<cfheader statuscode="500" />
			<cfset returnData.statuscode = 7 />

			<cfset application.fileManager.deleteTempFile(file=fullPathToTempFile) />
			<cfreturn returnData />

		</cfif>

		<cfset uploadImageResponse = application.fileManager.uploadImage(
			fileName=arguments.Files[1].serverFile
		) />

		<cfif len(Recipe.getPicture()) GT 0 >
			<cfset application.fileManager.deleteImage(file=Recipe.getPicture() & ".png") />
		</cfif>

		<cfset Recipe.setPicture(ID=listFirst(uploadImageResponse, ".")) />
		<cfset Recipe.save() />

		<cfset returnData.data = uploadImageResponse />
		<cfreturn returnData />

	</cffunction>
</cfcomponent>