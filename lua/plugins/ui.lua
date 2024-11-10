return {
	"Bekaboo/dropbar.nvim",
	"nvim-tree/nvim-web-devicons",
	-- "echasnovski/mini.icons",
	{
		"folke/which-key.nvim",
		dependencies = {},
		config = function()
			local wk = require("which-key")
			wk.setup({
				preset = "helix",
				plugins = {
					marks = false,
					registers = false,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
					presets = {
						operators = false, -- adds help for operators like d, y, ...
						motions = false, -- adds help for motions
						text_objects = false, -- help for text objects triggered after entering an operator
						windows = false, -- default bindings on <c-w>
						nav = false, -- misc bindings to work with windows
						z = false, -- bindings for folds, spelling and others prefixed with z
						g = false, -- bindings for prefixed with g
					},
				},
				win = {
					title_pos = "center",
					no_overlap = true,
					title = true,
					border = "single", -- none, single, double, shadow
					padding = { 2, 2 },
					zindex = 1000,
					wo = {
						winblend = 10,
					},
				},
				layout = {
					height = { min = 4, max = 25 },
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
				sort = { "local", "order", "group", "alphanum", "mod" },
				show_help = true,
				show_keys = true,
				disable = {
					ft = {},
					bt = { "TelescopePrompt" },
				},
			})
			require("config.which-key")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {},
		view = "cmdline_popup",
		config = function()
			require("noice").setup({
				views = {
					cmdline_popup = {
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						position = {
							row = 5,
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = 8,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						win_options = {
							winhighlight = {
								Normal = "Normal",
								FloatBorder = "DiagnosticInfo",
							},
						},
					},
				},
			})
		end,
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local colors = require("config").colors
			dashboard.section.header.val =
				vim.split(require("config").logos[1], "\n")
			local function pad(n)
				return { type = "padding", val = n }
			end
			local function title(name)
				return {
					type = "text",
					val = name .. "                                          ",
					opts = { position = "center", hl = colors.purple },
				}
			end
			local function sectionT(name, padding)
				return {
					type = "group",
					val = { pad(padding), title(name) },
					opts = { position = "center" },
				}
			end
			local Sections = {
				pad(10),
				dashboard.section.header,
				sectionT("Telescope", 1),
				{
					type = "group",
					val = {
						dashboard.button(
							"f",
							"󰈞 " .. " Find file",
							":Telescope find_files no_ignore=true <CR>"
						),
						dashboard.button(
							"r",
							" " .. " Recent files",
							":Telescope oldfiles <CR>"
						),
						dashboard.button(
							"g",
							" " .. " Grep Text",
							":Telescope live_grep <CR>"
						),
					},
					opts = { position = "center" },
				},

				sectionT("Config   ", 1),
				{
					type = "group",
					val = {
						dashboard.button(
							"c",
							" " .. " Config",
							":lua require('telescope.builtin').find_files({cwd = vim.fn.stdpath('config')}) <CR>"
						),
						dashboard.button("l", "󱓓 " .. " Lazy", ":Lazy<CR>"),
					},
					opts = { position = "center" },
				},
				sectionT("Built-in", 1),
				{
					type = "group",
					val = {
						dashboard.button(
							"n",
							" " .. " New file",
							":ene | startinsert<CR>"
						),
						dashboard.button("q", " " .. " Quit", ":qa<CR>"),
					},
					opts = { position = "center" },
				},
				pad(2),
				dashboard.section.footer,
			}

			alpha.setup({
				layout = Sections,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = { "AlphaReady", "LazyVimStarted" },
				callback = function(event)
					if vim.o.filetype == "lazy" then
						require("lazy").show()
					end

					if vim.o.filetype == "alpha" then
						vim.opt.guicursor:append("a:Cursor/lCursor")
						require("utils.select").setup(event.buf, "rounded")
					end
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded "
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.alphaRedraw)
				end,
			})
			vim.api.nvim_create_autocmd("CmdlineEnter", {
				callback = function()
					vim.opt.guicursor =
						"n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
				end,
			})
			vim.api.nvim_create_autocmd("CmdlineLeave", {
				callback = function()
					if vim.o.filetype == "alpha" then
						vim.opt.guicursor:append("a:Cursor/lCursor")
					end
				end,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = {
					theme = vim.g.colors_name,
				},
			})
		end,
	},
}
