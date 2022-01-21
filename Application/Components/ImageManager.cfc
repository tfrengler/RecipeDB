<cfcomponent output="false" accessors="false" persistent="true" modifier="final" >

	<cfscript>
		static {
			FullImageTableName  		= "RecipeImages";
			ThumbnailsTableName 		= "ImageThumbnails";
			FullImageTableKey			= "ImageID";
			ThumbnailsTableKey			= "ID";
			MaxFileSize 				= 5242880;
			RecipeImageDimensions		= {
				width: 450,
				height: 300
			};
			RecipeThumbnailDimensions 	= {
				width: 50,
				height: 50
			};
		}
	</cfscript>

	<cffunction modifier="static" name="Delete" access="public" returntype="void" output="false" hint="" >
		<cfargument name="id" type="numeric" required="true" />

		<cftransaction action="begin" >
			<cftry>
				<cfset queryExecute(
					"DELETE FROM #static.FullImageTableName#
					WHERE #static.FullImageTableKey# = ?",
					[
						{value=arguments.id, cfsqltype="integer"}
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>
	</cffunction>

	<cffunction modifier="static" name="Add" access="public" returntype="numeric" output="false" hint="" >
		<cfargument name="base64Content" type="string" required="true" />
		<cfargument name="fileName" type="string" required="true" />
		<cfargument name="mimeType" type="string" required="true" />
		<cfargument name="userID" type="numeric" required="true" />
		<cfargument name="recipeID" type="string" required="true" />

		<cfset var NewRecipeImage = null />
		<cfset var NewThumbnail = null />
		<cfset var InsertFullImageResult = null />

		<cfimage name="NewRecipeImage" action="read" source=#arguments.base64Content# />
		<cfimage name="NewThumbnail" action="read" source=#arguments.base64Content# />

		<cfset imageSetAntialiasing(NewRecipeImage, "on") />
		<cfset imageScaleTofit(NewRecipeImage, variables.RecipeImageDimensions.width, variables.RecipeImageDimensions.height, "bicubic") />

		<cfset imageSetAntialiasing(NewThumbnail, "on") />
		<cfset imageScaleTofit(NewThumbnail, variables.RecipeThumbnailDimensions.width, variables.RecipeThumbnailDimensions.height, "bicubic") />

		<cftransaction action="begin" >
			<cftry>
				<cfset queryExecute(
					"INSERT INTO #static.FullImageTableName# (
						BelongsToRecipe,
						MimeType,
						OriginalName,
						Base64Content,
						DateTimeCreated,
						DateTimeLastModified,
						ModifiedByUser
					)
					VALUES (?,?,?,?,?,?,?)",
					[
						{value=arguments.recipeID, cfsqltype="integer"},
						arguments.mimeType,
						trim(arguments.fileName),
						toBase64(imageGetBlob(NewRecipeImage)),
						Localizer::GetBackendDateTimeFromDate(now()),
						Localizer::GetBackendDateTimeFromDate(now()),
						{value=arguments.userID, cfsqltype="integer"}
					],
					{result="InsertFullImageResult"}
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfrethrow/>

			</cfcatch>
			</cftry>
		</cftransaction>

		<cftransaction action="begin" >
			<cftry>
				<cfset queryExecute(
					"INSERT INTO #static.ThumbnailsTableName# (ID, Base64Content) VALUES (?,?)",
					[
						{value=InsertFullImageResult.generatedKey, cfsqltype="integer"},
						toBase64(imageGetBlob(NewThumbnail))
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfrethrow/>

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn InsertFullImageResult.generatedKey />
	</cffunction>

	<cffunction modifier="static" name="GetFull" access="public" returntype="string" output="false" hint="" >
		<cfargument name="id" type="numeric" required="true" />

		<cftransaction action="begin" >
			<cftry>
				<cfset var ImageQuery = queryExecute(
					"SELECT Base64Content FROM #static.FullImageTableName#
					WHERE #static.FullImageTableKey# = ?",
					[
						{value=arguments.id, cfsqltype="integer"}
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn ImageQuery.Base64Content />
	</cffunction>

	<cffunction modifier="static" name="GetThumbnail" access="public" returntype="binary" output="false" hint="" >
		<cfargument name="ID" type="numeric" required="true" />

		<cftransaction action="begin" >
			<cftry>
				<cfset var ImageQuery = queryExecute(
					"SELECT Base64Content FROM #static.ThumbnailsTableName#
					WHERE #static.ThumbnailsTableKey# = ?",
					[
						{value=arguments.id, cfsqltype="integer"}
					]
				) />

				<cftransaction action="commit" />
			<cfcatch>

				<cftransaction action="rollback" />
				<cfthrow object="#cfcatch#" />

			</cfcatch>
			</cftry>
		</cftransaction>

		<cfreturn ImageQuery.Base64Content />
	</cffunction>
</cfcomponent>