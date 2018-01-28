<cfprocessingdirective pageencoding="utf-8" />
<cfinclude template="checkauth.cfm" />

<cfset DBExpectedSetup = {

	Users: {
		UserID: {
			type: "bigserial",
			size: 0,
			primary_key: true,
			foreign_key: false,
			references: structNew()
		},
		DateCreated: {
			type: "date",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		DateTimeLastLogin: {
			type: "timestamp",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		Password: {
			type: "varchar",
			size: 128,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		PasswordSalt: {
			type: "varchar",
			size: 128,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		TempPassword: {
			type: "varchar",
			size: 100,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		UserName: {
			type: "varchar",
			size: 20,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		DisplayName: {
			type: "varchar",
			size: 30,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		TimesLoggedIn: {
			type: "int4",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		BrowserLastUsed: {
			type: "varchar",
			size: 200,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		Blocked: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		}
	},

	Recipes: {
		RecipeID: {
			type: "bigserial",
			size: 0,
			primary_key: true,
			foreign_key: false,
			references: structNew()
		},
		Name: {
			type: "varchar",
			size: 100,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		DateCreated: {
			type: "date",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		DateTimeLastModified: {
			type: "timestamp",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		CreatedByUser: {
			type: "int8",
			size: 0,
			primary_key: false,
			foreign_key: true,
			references: {
				table: "Users",
				key: "UserID"
			}
		},
		LastModifiedByUser: {
			type: "int8",
			size: 0,
			primary_key: false,
			foreign_key: true,
			references: {
				table: "Users",
				key: "UserID"
			}
		},
		Ingredients: {
			type: "text",
			size: 2147483647,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		Description: {
			type: "text",
			size: 2147483647,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		Picture: {
			type: "varchar",
			size: 128,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		Instructions: {
			type: "text",
			size: 2147483647,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		Published: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		}
	},

	Comments: {
		CommentID: {
			type: "bigserial",
			size: 0,
			primary_key: true,
			foreign_key: false,
			references: structNew()
		},
		RecipeID: {
			type: "int8",
			size: 0,
			primary_key: false,
			foreign_key: true,
			references: {
				table: "Recipes",
				key: "RecipeID"
			}
		},
		CommentText: {
			type: "text",
			size: 2147483647,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		},
		UserID: {
			type: "int8",
			size: 0,
			primary_key: false,
			foreign_key: true,
			references: {
				table: "Users",
				key: "UserID"
			}
		},
		DateTimeCreated: {
			type: "timestamp",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: structNew()
		}
	}

} />