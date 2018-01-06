CREATE TABLE Users(
	UserID bigserial,
	DateCreated date NOT NULL DEFAULT current_date,
	DateTimeLastLogin timestamp NOT NULL DEFAULT '1666-12-31 00:00:00',
	Password varchar(128) NOT NULL, -- SHA-512 hash
	PasswordSalt varchar(128) NOT NULL, -- SHA-512 hash
	TempPassword varchar(100) NOT NULL,
	UserName varchar(20) NOT NULL,
	DisplayName varchar(30) NOT NULL,
	TimesLoggedIn int NOT NULL DEFAULT 0,
	BrowserLastUsed varchar(200) NOT NULL,
	Blocked boolean NOT NULL DEFAULT false,
	PRIMARY KEY(UserID)
);

CREATE TABLE Recipes(
	RecipeID bigserial,
	Name varchar(100) NOT NULL,
	DateCreated date NOT NULL DEFAULT current_date,
	DateTimeLastModified timestamp NOT NULL DEFAULT localtimestamp,
	CreatedByUser bigint REFERENCES Users(UserID) NOT NULL,
	LastModifiedByUser bigint REFERENCES Users(UserID) NOT NULL,
	Ingredients text NOT NULL,
	Description text NOT NULL,
	Picture varchar(128) NOT NULL,
	Instructions text NOT NULL,
	Published boolean NOT NULL DEFAULT false,
	PRIMARY KEY(RecipeID)
);

CREATE TABLE Comments(
	CommentID bigserial,
	RecipeID bigint references Recipes(RecipeID) ON DELETE CASCADE NOT NULL,
	CommentText text NOT NULL,
	UserID bigint REFERENCES Users(UserID) NOT NULL,
	DateTimeCreated timestamp NOT NULL DEFAULT localtimestamp,
	PRIMARY KEY(CommentID)
);

--- CREATING THE USER FOR LUCEE
CREATE USER Lucee WITH
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