<cfcomponent output="false" >
<cfprocessingdirective pageEncoding="utf-8"  />

	<cfset recipePicturePath = "#expandPath("/")#/Pictures/Recipes" />
	<cfset tempDirectory = "C:\Server\tempFiles" />
	<cfset maxUploadSizeInBytes = "5242880" />
	<cfset validImageMimeTypes = "image/gif,image/png,image/jpeg" />

	<cfset recipeImageDimensions = {
		width: 450,
		height: 300
	} />

	<cfset recipeThumbnailDimensions = {
		width: 50,
		height: 50
	} />

	<cfset alphaNumericOnlyRegex = "[^A-Za-z0-9_]" />

	<cffunction name="getRecipePath" access="public" output="false" hint="" >
		<cfreturn true />
	</cffunction>

	<cffunction name="getStandardPath" access="public" output="false" hint="" >
		<cfreturn true />
	</cffunction>

	<cffunction name="uploadImage" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="pathToTempFile" type="string" required="true" />

		<cfset var ReturnData = {
			status: "",
			message: "",
			data: ""
		} />

		<cfif fileExists(pathToTempFile) IS false >

			<cfset ReturnData.status = "NOK" />
			<cfset ReturnData.message = "Argument 'pathToTempFile' does not point to a valid file" />
			<cfreturn ReturnData />

		</cfif>

		<cfset var NewFileName = "#createUUID()#.png" />
		<cfset var UploadedFile = "" />
		<cfset var NewImage = "" />
		<cfset var NewFileAttempts = 0 />
		<cfset var MaxNewFileAttempts = 50 />

		<cfif listFind(variables.validImageMimeTypes, fileGetMimeType(pathToTempFile)) IS 0 AND isImageFile(pathToTempFile) IS false >

			<cfset ReturnData.status = "NOK" />
			<cfset ReturnData.message = "File type is not allowed or the file is not actually an image. Allowed types are: #validImageMimeTypes#. The mime type of the uploaded file is: #fileGetMimeType(pathToTempFile)#" />
			<cfreturn ReturnData />

		</cfif>
	
		<cffile 
			action="upload"
			filefield="file1"
			accept="image/gif,image/jpeg,image/png"
			destination=#TempDirectory#
			attributes="readonly"
			nameconflict="makeunique"
			result="UploadedFile"
		/>

		<cfset FullTempFilePathAndName = "#UploadedFile.serverDirectory#/#UploadedFile.serverFileName#.#UploadedFile.serverFileExt#" />

		<cfimage action="read" source=#FullTempFilePathAndName# name="NewImage" />
		<cfset imageScaleTofit(NewImage, variables.recipeImageDimensions.width, variables.recipeImageDimensions.height) />

		<cfloop from="1" to=#MaxNewFileAttempts# index="NewFileAttempts" >

			<cfif fileExists("#recipePicturePath#/#NewFileName#") IS true >
				<cfset NewFileName = "#createUUID()#.png" />
			<cfelse>
				<cfbreak />
			</cfif>

		</cfloop>

		<cfif NewFileAttempts EQ MaxNewFileAttempts >

			<cfset ReturnData.status = "NOK" />
			<cfset ReturnData.message = "Unable to create a unique name for the new image file" />
			<cfreturn ReturnData />

		</cfif>

		<cfimage action="write" source=#NewImage# destination="#variables.recipePicturePath#/#NewFileName#" />
		<cffile action="delete" file=#FullTempFilePathAndName# />

		<cfset ReturnData.status = "OK" />
		<cfset ReturnData.data = NewFileName />

		<cfreturn ReturnData />
	</cffunction>

	<!--- function fncFileSize(size) {
		if (size lt 1024) return "#size# b";
		if (size lt 1024^2) return "#round(size / 1024)# Kb";
		if (size lt 1024^3) return "#decimalFormat(size/1024^2)# Mb";
		return "#decimalFormat(size/1024^3)# Gb";
	} --->

<!--- 	function TotalSize() {
		var oFileElements = document.querySelectorAll("input[type='file']");
		var nCombinedFileSizeInBytes = 0;
		var nCombinedFileSizeInMegabytes = 0;
		var oCurrentFile = {};
		var nIterator = 0;

		if (typeof oFileElements == "undefined") {
			return false;
		};

		for (; nIterator < oFileElements.length; nIterator++) {

			if (oFileElements[nIterator].files.length > 0) {
				oCurrentFile = oFileElements[nIterator].files[0];
				nCombinedFileSizeInBytes += oCurrentFile.size;
			};
		};

		if (nCombinedFileSizeInBytes > 0) {

			// Converting from bytes to megabytes
			nCombinedFileSizeInMegabytes = nCombinedFileSizeInBytes / 1048576;
			/* Rounding the number down to the nearest two decimal points. This will give weird results with float numbers
			but for what we are using this for (file sizes) we know we are always going to get integers */
			nCombinedFileSizeInMegabytes = Math.round(nCombinedFileSizeInMegabytes * 100) / 100; 
		
			alert("Total attachment size: " + nCombinedFileSizeInMegabytes + " MB");
		};

	}; --->

</cfcomponent>