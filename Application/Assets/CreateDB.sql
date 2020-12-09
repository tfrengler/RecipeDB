CREATE TABLE Users (
    UserID            INTEGER        PRIMARY KEY AUTOINCREMENT,
    TempPassword      VARCHAR (100),
    PasswordSalt      VARCHAR (128), -- SHA-512 hash
    BrowserLastUsed   VARCHAR (300),
    DisplayName       VARCHAR (30),
    Blocked           BOOLEAN       NOT NULL
                                    DEFAULT (0),
    DateTimeLastLogin DATETIME      DEFAULT ('1666-12-31T00:00:00'),
    DateCreated       DATE          DEFAULT (date('now') ),
    TimesLoggedIn     INT           DEFAULT (0),
    Password          VARCHAR (128), -- SHA-512 hash
    UserName          VARCHAR (20) 
);

CREATE TABLE Recipes (
    RecipeID             INTEGER       PRIMARY KEY AUTOINCREMENT,
    Name                 VARCHAR (100),
    DateCreated          DATE          DEFAULT (date('now') ),
    DateTimeLastModified DATETIME      DEFAULT (date('now') ),
    CreatedByUser        BIGINT        REFERENCES Users (UserID),
    LastModifiedByUser   BIGINT        REFERENCES Users (UserID),
    Ingredients          TEXT,
    Description          TEXT,
    Picture              VARCHAR (128),
    Instructions         TEXT,
    Published            BOOLEAN       DEFAULT (0) 
                                       NOT NULL
);

CREATE TABLE UserSettings (
    BelongsToUser                      BIGINT       REFERENCES Users (UserID) ON DELETE CASCADE,
    FindRecipes_ListType               VARCHAR (6),
    FindRecipes_SortOnColumn           VARCHAR (20),
    FindRecipesFilterOn_MineOnly       BOOLEAN      NOT NULL
                                                    DEFAULT (0),
    FindRecipesFilterOn_MinePublic     BOOLEAN      NOT NULL
                                                    DEFAULT (0),
    FindRecipesFilterOn_MinePrivate    BOOLEAN      NOT NULL
                                                    DEFAULT (0),
    FindRecipesFilterOn_MineEmpty      BOOLEAN      NOT NULL
                                                    DEFAULT (0),
    FindRecipesFilterOn_MineNoPicture  BOOLEAN      NOT NULL
                                                    DEFAULT (0),
    FindRecipesFilterOn_OtherUsersOnly BOOLEAN      NOT NULL
                                                    DEFAULT (0) 
);

CREATE TABLE RecipeImages (
	ImageID 			BIGINT 			PRIMARY KEY AUTOINCREMENT,
	BelongsToRecipe 	INTEGER			REFERENCES Recipes (RecipeID) ON DELETE CASCADE,
	MimeType			VARCHAR (100),
	OriginalName		VARCHAR (256),
	BinaryContent		BLOB
);

/* Comments haven't been implemented so we aren't going to add this
CREATE TABLE Comments(
	CommentID bigserial,
	RecipeID bigint references Recipes(RecipeID) ON DELETE CASCADE NOT NULL,
	CommentText text NOT NULL,
	UserID bigint REFERENCES Users(UserID) NOT NULL,
	DateTimeCreated timestamp NOT NULL DEFAULT localtimestamp,
	PRIMARY KEY(CommentID)
);
*/