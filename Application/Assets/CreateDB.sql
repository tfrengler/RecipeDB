CREATE TABLE Users (
    UserID            INTEGER    PRIMARY KEY AUTOINCREMENT
                                 UNIQUE ON CONFLICT ROLLBACK,
    TempPassword      TEXT (100) CHECK (length(TempPassword) <= 100),
    PasswordSalt      TEXT (128) NOT NULL
                                 CHECK (length(PasswordSalt) == 128),
    BrowserLastUsed   TEXT (300) CHECK (length(BrowserLastUsed) <= 300),
    DisplayName       TEXT (30)  NOT NULL
                                 CHECK (length(DisplayName) <= 30),
    Blocked           BOOLEAN    NOT NULL
                                 DEFAULT (0),
    DateTimeLastLogin TEXT (26)  NOT NULL
                                 CHECK (length(DateTimeLastLogin) == 26),
    DateTimeCreated   TEXT (26)  CHECK (length(DateTimeCreated) == 26)
                                 NOT NULL,
    TimesLoggedIn     INTEGER    DEFAULT (0)
                                 NOT NULL,
    Password          TEXT (128) NOT NULL
                                 CHECK (length(Password) == 128),
    UserName          TEXT (20)  NOT NULL
                                 CHECK (length(UserName) <= 20)
);

CREATE TABLE Recipes (
    RecipeID             INTEGER    PRIMARY KEY AUTOINCREMENT
                                    UNIQUE ON CONFLICT ROLLBACK,
    Name                 TEXT (100) CHECK (length(Name) <= 100),
    DateTimeCreated      TEXT (26)  CHECK (length(DateTimeCreated) == 26)
                                    NOT NULL,
    DateTimeLastModified TEXT (26)  CHECK (length(DateTimeLastModified) == 26)
                                    NOT NULL,
    CreatedByUser        INTEGER    REFERENCES Users (UserID) ON DELETE SET NULL
                                    NOT NULL,
    LastModifiedByUser   INTEGER    REFERENCES Users (UserID) ON DELETE SET NULL
                                    NOT NULL,
    Ingredients          TEXT       DEFAULT (''),
    Description          TEXT       DEFAULT (''),
    Picture              INTEGER    REFERENCES RecipeImages (ImageID) ON DELETE SET NULL
                                    UNIQUE ON CONFLICT ROLLBACK,
    Instructions         TEXT       DEFAULT (''),
    Published            BOOLEAN    DEFAULT (0)
                                    NOT NULL
);

CREATE TABLE UserSettings (
    BelongsToUser                      INTEGER REFERENCES Users (UserID) ON DELETE CASCADE
                                               UNIQUE
                                               NOT NULL,
    FindRecipes_ListType               TEXT    NOT NULL
                                               CHECK (length(FindRecipes_ListType) > 0),
    FindRecipes_SortOnColumn           TEXT    NOT NULL
                                               CHECK (length(FindRecipes_SortOnColumn) > 0),
    FindRecipesFilterOn_MineOnly       BOOLEAN NOT NULL
                                               DEFAULT (0),
    FindRecipesFilterOn_MinePublic     BOOLEAN NOT NULL
                                               DEFAULT (0),
    FindRecipesFilterOn_MinePrivate    BOOLEAN NOT NULL
                                               DEFAULT (0),
    FindRecipesFilterOn_MineEmpty      BOOLEAN NOT NULL
                                               DEFAULT (0),
    FindRecipesFilterOn_MineNoPicture  BOOLEAN NOT NULL
                                               DEFAULT (0),
    FindRecipesFilterOn_OtherUsersOnly BOOLEAN NOT NULL
                                               DEFAULT (0)
);

CREATE TABLE RecipeImages (
    ImageID              INTEGER    PRIMARY KEY AUTOINCREMENT
                                    UNIQUE ON CONFLICT ROLLBACK,
    BelongsToRecipe      INTEGER    REFERENCES Recipes (RecipeID) ON DELETE CASCADE
                                    NOT NULL
                                    UNIQUE ON CONFLICT ROLLBACK,
    MimeType             TEXT (100) CHECK (length(MimeType) <= 100),
    OriginalName         TEXT (256) CHECK (length(OriginalName) <= 256),
    Base64Content        BLOB,
    DateTimeCreated      TEXT (16)  CHECK (length(DateTimeCreated) == 26)
                                    NOT NULL,
    DateTimeLastModified TEXT (26)  NOT NULL
                                    CHECK (length(DateTimeLastModified) == 26),
    ModifiedByUser       INTEGER    REFERENCES Users (UserID) ON DELETE SET NULL
);

CREATE TABLE ImageThumbnails (
    ID                 REFERENCES RecipeImages (ImageID) ON DELETE CASCADE
                       UNIQUE ON CONFLICT ROLLBACK
                       NOT NULL,
    Base64Content BLOB
);