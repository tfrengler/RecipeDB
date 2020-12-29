CREATE TABLE Users (
	UserID				INTEGER			PRIMARY KEY AUTOINCREMENT,
	TempPassword		VARCHAR (100),
	PasswordSalt		VARCHAR (128), -- SHA-512 hash
	BrowserLastUsed		VARCHAR (300),
	DisplayName			VARCHAR (30),
	Blocked				BOOLEAN			NOT NULL
										DEFAULT (0),
	DateTimeLastLogin	DATETIME		DEFAULT ('1666-12-31T00:00:00'),
	DateCreated			DATE			DEFAULT (date('now') ),
	TimesLoggedIn		INT				DEFAULT (0),
	Password			VARCHAR (128), -- SHA-512 hash
	UserName			VARCHAR (20)
);

CREATE TABLE Recipes (
	RecipeID				INTEGER			PRIMARY KEY AUTOINCREMENT,
	Name					VARCHAR (100),
	DateCreated				DATE			DEFAULT (date('now') ),
	DateTimeLastModified	DATETIME		DEFAULT (date('now') ),
	CreatedByUser			INTEGER			REFERENCES Users (UserID),
	LastModifiedByUser		INTEGER			REFERENCES Users (UserID),
	Ingredients				TEXT,
	Description				TEXT,
	Picture					VARCHAR (128),
	Instructions			TEXT,
	Published				BOOLEAN			DEFAULT (0)
											NOT NULL
);

CREATE TABLE UserSettings (
	BelongsToUser						INTEGER			REFERENCES Users (UserID) ON DELETE CASCADE,
	FindRecipes_ListType				VARCHAR (6),
	FindRecipes_SortOnColumn			VARCHAR (20),
	FindRecipesFilterOn_MineOnly		BOOLEAN			NOT NULL
														DEFAULT (0),
	FindRecipesFilterOn_MinePublic		BOOLEAN			NOT NULL
														DEFAULT (0),
	FindRecipesFilterOn_MinePrivate		BOOLEAN			NOT NULL
														DEFAULT (0),
	FindRecipesFilterOn_MineEmpty		BOOLEAN			NOT NULL
														DEFAULT (0),
	FindRecipesFilterOn_MineNoPicture	BOOLEAN			NOT NULL
														DEFAULT (0),
	FindRecipesFilterOn_OtherUsersOnly	BOOLEAN			NOT NULL
														DEFAULT (0)
);

CREATE TABLE RecipeImages (
	ImageID 				INTEGER 		PRIMARY KEY AUTOINCREMENT,
	BelongsToRecipe 		INTEGER			REFERENCES Recipes (RecipeID) ON DELETE CASCADE,
	MimeType				VARCHAR (100),
	OriginalName			VARCHAR (256),
	BinaryContent			BLOB,
	DateTimeCreated			DATETIME		DEFAULT (date('now') ),
	DateTimeLastModified	DATETIME		DEFAULT (date('now') ),
);

CREATE TABLE ImageThumbnails (
	ID						INTEGER			REFERENCES RecipeImages (ImageID) ON DELETE CASCADE
	BinaryContent			BLOB,
	DateTimeCreated			DATETIME		DEFAULT (date('now') ),
	DateTimeLastModified	DATETIME		DEFAULT (date('now') )
);

-- Comments haven't been implemented so we aren't going to add this
/*CREATE TABLE Comments(
	CommentID 			INTEGER		PRIMARY KEY AUTOINCREMENT,
	RecipeID 			INTEGER		REFERENCES Recipes(RecipeID) ON DELETE CASCADE,
	CommentText 		TEXT,
	UserID 				INTEGER		REFERENCES Users(UserID),
	DateTimeCreated 	DATETIME	DEFAULT (date('now') )
);*/