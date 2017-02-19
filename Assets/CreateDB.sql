CREATE TABLE Users(
	UserID bigint,
	SessionID uuid,
	DateCreated date,
	DateLastLogin date,
	PRIMARY KEY(UserID)
);

CREATE TABLE Recipes(
	RecipeID bigint,
	DateCreated date,
	DateLastModified date,
	CreatedByUser bigint REFERENCES Users(UserID),
	LastModifiedByUser bigint REFERENCES Users(UserID),
	Ingredients text,
	Description text,
	Picture bigint,
	Instructions text,
	PRIMARY KEY(RecipeID)
);

CREATE TABLE Comments(
	CommentID bigint,
	RecipeID bigint references Recipes(RecipeID) ON DELETE CASCADE,
	CommentText text,
	UserID bigint REFERENCES Users(UserID),
	DateCreated date,
	PRIMARY KEY(CommentID)
);

CREATE USER lucee WITH
LOGIN
NOSUPERUSER
INHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION
VALID UNTIL '2050-12-31 23:59:00+01';

GRANT SELECT, INSERT, UPDATE, DELETE 
ON all tables 
IN schema public 
TO lucee;