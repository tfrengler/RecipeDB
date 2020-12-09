<cfinclude template="CheckAuth.cfm" />

<cfset DBExpectedSetup = {

	Users: {
		UserID: {
			type: "bigserial",
			size: 0,
			primary_key: true,
			foreign_key: false,
			references: {}
		},
		DateCreated: {
			type: "date",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		DateTimeLastLogin: {
			type: "timestamp",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		Password: {
			type: "varchar",
			size: 128,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		PasswordSalt: {
			type: "varchar",
			size: 128,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		TempPassword: {
			type: "varchar",
			size: 100,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		UserName: {
			type: "varchar",
			size: 20,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		DisplayName: {
			type: "varchar",
			size: 30,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		TimesLoggedIn: {
			type: "int4",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		BrowserLastUsed: {
			type: "varchar",
			size: 300,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		Blocked: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		}
	},

	Recipes: {
		RecipeID: {
			type: "bigserial",
			size: 0,
			primary_key: true,
			foreign_key: false,
			references: {}
		},
		Name: {
			type: "varchar",
			size: 100,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		DateCreated: {
			type: "date",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		DateTimeLastModified: {
			type: "timestamp",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
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
			references: {}
		},
		Description: {
			type: "text",
			size: 2147483647,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		Picture: {
			type: "varchar",
			size: 128,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		Instructions: {
			type: "text",
			size: 2147483647,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		Published: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		}
	},

	Comments: {
		CommentID: {
			type: "bigserial",
			size: 0,
			primary_key: true,
			foreign_key: false,
			references: {}
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
			references: {}
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
			references: {}
		}
	},

	UserSettings: {

		BelongsToUser: {
			type: "bigserial",
			size: 0,
			primary_key: false,
			foreign_key: true,
			references: {
				table: "Users",
				key: "UserID"
			}
		},
		FindRecipes_ListType: {
			type: "varchar",
			size: 6,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipes_SortOnColumn: {
			type: "varchar",
			size: 20,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipesFilterOn_MineOnly: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipesFilterOn_MinePublic: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipesFilterOn_MinePrivate: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipesFilterOn_MineEmpty: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipesFilterOn_MineNoPicture: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		},
		FindRecipesFilterOn_OtherUsersOnly: {
			type: "bool",
			size: 0,
			primary_key: false,
			foreign_key: false,
			references: {}
		}
	}

} />