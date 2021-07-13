<!--- CREATE TABLE RecipeImages (
    ImageID              INTEGER    PRIMARY KEY AUTOINCREMENT
                                    UNIQUE ON CONFLICT ROLLBACK,
    BelongsToRecipe      INTEGER    REFERENCES Recipes (RecipeID) ON DELETE CASCADE,
    MimeType             TEXT (100),
    OriginalName         TEXT (256),
    Base64Content        BLOB,
    DateTimeCreated      TEXT (16),
    DateTimeLastModified TEXT (26),
    ModifiedByUser       INTEGER    REFERENCES Users (UserID) ON DELETE SET NULL
); --->

<cfset queryExecute(
    "INSERT INTO RecipeImages (
        BelongsToRecipe,
        MimeType,
        OriginalName,
        Base64Content,
        DateTimeCreated,
        DateTimeLastModified
        --ModifiedByUser
    )
    VALUES(?,?,?,?,?,?)",
    [
        {value=56, cfsqltype="integer"},
        "application/json",
        "Gnargle",
        "XXX",
        "1234567890123456789012345678901234567890",
        "1234567890123456789012345678901234567890"
    ],
    {result="TestResult"}
) >

<cfdump var=#TestResult# />