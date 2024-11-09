local M = {}
------------------------------------------------------------------------------
------------------------------------------------------------------------------
M.lsp = {

	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					checkThirdParty = false,
					library = {
						"${3rd}/luv/library",
						unpack(vim.api.nvim_get_runtime_file("", true)),
					},
				},
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = {
					globals = {
						"vim",
						"it",
						"describe",
						"before_each",
						"after_each",
					},
				},
			},
		},
	},
	------------------------------------------------------------------------------
	bashls = {
		filetypes = { "sh", "bash" },
	},
	------------------------------------------------------------------------------
	pyright = {},
	------------------------------------------------------------------------------
	html = {},
	------------------------------------------------------------------------------
	nixd = {
		settings = {
			cmd = { "nixd" },
			nixd = {
				nixpkgs = {
					expr = "import <nixpkgs> { }",
				},
				options = {
					nixos = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
					},
					home_manager = {
						expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
					},
				},
			},
		},
	},
	------------------------------------------------------------------------------
	emmet_language_server = {
		filetypes = {
			"html",
			"css",
			"less",
			"sass",
			"scss",
			"javascript",
			"javascriptreact",
			"typescriptreact",
		},
	},

	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = true,
					-- enableExperimental = true,
					disabled = { "non_camel_case_types" },
				},
				cargo = {
					workspaceMembers = true,
					allFeatures = true,
					loadOutDirsFromCheck = true,
				},
				checkOnSave = true,
				procMacro = {
					enable = true,
				},
				-- linkedProjects = { "./Cargo.toml" }, -- Aquí puedes agregar la ruta del archivo Cargo.toml como en VSCode
			},
		},
	},
}
------------------------------------------------------------------------------
return M
