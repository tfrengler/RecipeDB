<cfcomponent output="false" accessors="false" persistent="true"  modifier="final" >

	<cfproperty name="RecipeImageDimensions"		type="struct"	getter="false"	setter="false" />
	<cfproperty name="RecipeThumbnailDimensions"	type="struct"	getter="false"	setter="false" />
	<cfproperty name="MaxFileSize"					type="numeric"	getter="false"	setter="false" />
	<cfproperty name="RecipeImagesDBTable"			type="string"	getter="false"	setter="false" />
	<cfproperty name="ThumbnailsDBTable"			type="string"	getter="false"	setter="false" />

	<cffunction name="delete" access="public" returntype="void" output="false" hint="" >
		<cfargument name="id" type="numeric" required="true" />

		<cfset var Dummy = null />
		<cfquery name="Dummy" >
			DELETE FROM #RecipeImagesDBTable#
			WHERE ImageID = <cfqueryparam sqltype="INTEGER" value=#arguments.id# />
		</cfquery>
	</cffunction>

	<cffunction name="add" access="public" returntype="numeric" output="false" hint="" >
		<cfargument name="base64Content" type="string" required="true" />
		<cfargument name="fileName" type="string" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		<cfargument name="recipeID" type="string" required="true" />

		<cfset var NewRecipeImage = null />
		<cfset var NewThumbnail = null />
		<cfset var InsertImage = null />
		<cfset var InsertThumbnail = null />

		<cfimage name="NewRecipeImage" action="read" source=#arguments.base64Content# />
		<cfimage name="NewThumbnail" action="read" source=#arguments.base64Content# />

		<cfset imageSetAntialiasing(NewRecipeImage, "on") />
		<cfset imageScaleTofit(NewRecipeImage, variables.RecipeImageDimensions.width, variables.RecipeImageDimensions.height, "bicubic") />

		<cfset imageSetAntialiasing(NewThumbnail, "on") />
		<cfset imageScaleTofit(NewThumbnail, variables.RecipeThumbnailDimensions.width, variables.RecipeThumbnailDimensions.height, "bicubic") />

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="InsertImage" >
					INSERT INTO #RecipeImagesDBTable# (
						ImageID
						BelongsToRecipe
						MimeType
						OriginalName
						BinaryContent
						DateTimeCreated
						DateTimeLastModified
					)
					VALUES (
						<cfqueryparam sqltype="INTEGER" value=#arguments.userID# />,	<!--- ImageID --->
						<cfqueryparam sqltype="INTEGER" value=#arguments.recipeID# />,	<!--- BelongsToRecipe --->
						<cfqueryparam sqltype="VARCHAR" value=#fileGetMimeType(arguments.base64Content, true)# />,	<!--- MimeType --->
						<cfqueryparam sqltype="VARCHAR" value=#arguments.fileName# />,	<!--- OriginalName --->
						<cfqueryparam sqltype="BLOB" value=#imageGetBlob(NewRecipeImage)# />,	<!--- BinaryContent --->
						<cfqueryparam sqltype="TIMESTAMP" value=#now()# />,	<!--- DateTimeCreated --->
						<cfqueryparam sqltype="TIMESTAMP" value=#now()# />	<!--- DateTimeLastModified --->
					)

					SELECT last_insert_rowid() AS "NewID";
				</cfquery>

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfrethrow/>

			</cfcatch>
			</cftry>
		</cftransaction>

		<cftransaction action="begin" >
			<cftry>
				<cfquery name="InsertThumbnail" >
					INSERT INTO #RecipeImagesDBTable# (
						ID
						BinaryContent
						DateTimeCreated
						DateTimeLastModified
					)
					VALUES (
						<cfqueryparam sqltype="INTEGER" value=#InsertImage.NewID# />,	<!--- ID --->
						<cfqueryparam sqltype="BLOB" value=#imageGetBlob(NewThumbnail)# />,	<!--- BinaryContent --->
						<cfqueryparam sqltype="TIMESTAMP" value=#now()# />,	<!--- DateTimeCreated --->
						<cfqueryparam sqltype="TIMESTAMP" value=#now()# />	<!--- DateTimeLastModified --->
					)
				</cfquery>

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfrethrow/>

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn InsertImage.NewID />
	</cffunction>

	<cffunction name="getRecipeImage" access="public" returntype="struct" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" />

		<cfset var RecipeImage = null />
		<cfquery name="RecipeImage" >
			SELECT
				ImageID,
				BelongsToRecipe,
				MimeType,
				OriginalName,
				BinaryContent,
				DateTimeCreated,
				DateTimeLastModified
			FROM #RecipeImagesDBTable#;
		</cfquery>

		<cfreturn {
			"ImageID": RecipeImage.ImageID,
			"BelongsToRecipe": RecipeImage.BelongsToRecipe,
			"MimeType": RecipeImage.MimeType,
			"OriginalName": RecipeImage.OriginalName,
			"BinaryContent": RecipeImage.BinaryContent,
			"DateTimeCreated": RecipeImage.DateTimeCreated,
			"DateTimeLastModified": RecipeImage.DateTimeLastModified
		} />
	</cffunction>

	<cffunction name="getThumbnail" access="public" returntype="binary" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" />

		<cfset var ThumbnailImage = null />
		<cfquery name="ThumbnailImage" >
			SELECT
				ID,
				BinaryContent,
				DateTimeCreated,
				DateTimeLastModified
			FROM #ThumbnailsDBTable#;
		</cfquery>

		<cfreturn {
			"ID": ThumbnailImage.ID,
			"BinaryContent": ThumbnailImage.BinaryContent,
			"DateTimeCreated": ThumbnailImage.DateTimeCreated,
			"DateTimeLastModified": ThumbnailImage.DateTimeLastModified
		} />
	</cffunction>

	<cffunction name="init" access="public" returntype="Components.FileManager" output="false" hint="" >

		<cfset variables.RecipeImageDimensions = {
			width: 450,
			height: 300
		} />

		<cfset variables.RecipeThumbnailDimensions = {
			width: 50,
			height: 50
		} />

		<cfset variables.MaxFileSize = 5242880 />

		<cfreturn this />
	</cffunction>

</cfcomponent>