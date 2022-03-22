<cfcomponent output="false" accessors="false" persistent="false" >

    <cffunction modifier="static" access="public" name="ChangePicture" returntype="ControllerData" returnformat="JSON" output="false" hint="" >
        <cfargument name="recipeID" type="numeric" required="true" />
        <cfargument name="base64content" type="string" required="true" />
        <cfargument name="mimeType" type="string" required="true" />
        <cfargument name="fileName" type="string" required="true" />
        <cfscript>

        var Recipe = new Models.Recipe(arguments.recipeID);

        if (Recipe.CreatedByUser.UserID != session.CurrentUser.UserID)
        {
            return new Models.ControllerData(1);
        }

        var ImageID = Components.ImageManager::Add(
            arguments.base64content,
            arguments.fileName,
            arguments.mimeType,
            session.CurrentUser.UserID,
            arguments.recipeID
        );

        Recipe.Picture = ImageID;
        Recipe.Save();

        </cfscript>
    </cffunction>

</cfcomponent>