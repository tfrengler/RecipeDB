<cfscript>

Image = fileReadBinary("C:\Temp\Siggy.png");

// INSERT NEW IMAGE
// writeDump( Components.ImageManager::Add(
//     base64Content=toBase64(image),
//     fileName="Siggy.png",
//     mimeType=fileGetMimeType(image, true),
//     userID=2,
//     recipeID=4
// ) );

// ImageData = queryExecute(
//     "SELECT
//         RecipeImages.Base64Content AS 'Full',
//         ImageThumbnails.Base64Content AS 'Thumbnail'
//     FROM RecipeImages
//     JOIN ImageThumbnails ON RecipeImages.ImageID = ImageThumbnails.ID"
// );

// ImageData = Components.ImageManager::GetThumbnail(4);
// cfimage(action="writeToBrowser", source=ImageData);

// Components.ImageManager::Delete(6);

    Test = new Models.ControllerData(1, "test");
    writeDump( serializeJSON(Test) );

</cfscript>

<!--- <cfquery>PRAGMA foreign_keys = ON;</cfquery> --->