CREATE TABLE Users(
	UserID bigserial,
	SessionID uuid NOT NULL,
	DateCreated date NOT NULL,
	DateTimeLastLogin timestamp NOT NULL,
	Password varchar(100) NOT NULL,
	TempPassword varchar(100) NOT NULL,
	UserName varchar(10) NOT NULL,
	DisplayName varchar(30) NOT NULL,
	TimesLoggedIn int NOT NULL,
	BrowserLastUsed varchar(200) NOT NULL,
	Blocked boolean NOT NULL,
	PRIMARY KEY(UserID)
);

CREATE TABLE Recipes(
	RecipeID bigserial,
	Name varchar(100) NOT NULL,
	DateCreated date NOT NULL,
	DateLastModified timestamp NOT NULL,
	CreatedByUser bigint REFERENCES Users(UserID) NOT NULL,
	LastModifiedByUser bigint REFERENCES Users(UserID) NOT NULL,
	Ingredients text NOT NULL,
	Description text NOT NULL,
	Picture bigint NOT NULL,
	Instructions text NOT NULL,
	PRIMARY KEY(RecipeID)
);

CREATE TABLE Comments(
	CommentID bigserial,
	RecipeID bigint references Recipes(RecipeID) ON DELETE CASCADE NOT NULL,
	CommentText text NOT NULL,
	UserID bigint REFERENCES Users(UserID) NOT NULL,
	DateTimeCreated timestamp NOT NULL,
	PRIMARY KEY(CommentID)
);

--- CREATING THE USER FOR LUCEE
CREATE USER lucee WITH
LOGIN
NOSUPERUSER
INHERIT
NOCREATEDB
NOCREATEROLE
NOREPLICATION
VALID UNTIL '2050-12-31 23:59:00+01';

GRANT SELECT, INSERT, UPDATE, DELETE 
ON ALL tables 
IN SCHEMA public 
TO lucee;

GRANT USAGE
ON SCHEMA public
TO lucee;

GRANT USAGE
ON ALL SEQUENCES IN SCHEMA public
TO Lucee