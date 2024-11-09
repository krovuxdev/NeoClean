local kind_icons = require("config").icons.kind_icons
return {
	"saghen/blink.cmp",
	version = "v0.*",
	event = { "LspAttach", "InsertCharPre" },
	dependencies = {
		"rafamadriz/friendly-snippets",
		"windwp/nvim-autopairs",
	},
	init = function()
		local pairs = require("nvim-autopairs")
		pairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		})
	end,
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<Tab>"] = { "select_next", "fallback" },
			["<s-tab>"] = { "select_prev", "fallback" },
			["<c-n>"] = { "select_next" },
			["<c-p>"] = { "select_prev" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<c-space>"] = {
				"show",
				"show_documentation",
				"hide_documentation",
			},
			["<c-c>"] = { "hide", "fallback" },
			["<cr>"] = { "select_and_accept", "fallback" },
		},
		nerd_font_variant = "normal",
		highlight = {
			use_nvim_cmp_as_default = true,
		},

		accept = {
			create_undo_point = true,
			auto_brackets = {
				enabled = true,
				semantic_token_resolution = {
					enabled = true,
					default_brackets = {},
					blocked_filetypes = {},
					timeout_ms = 400,
				},
			},
		},
		windows = {
			autocomplete = {
				min_width = 35,
				max_height = 10,
				border = "rounded",
				winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenu,CursorLine:BlinkCmpMenuSelection,Search:None",
				winblend = 0,
				auto_show = true,
				draw = function(ctx)
					local source, client =
						ctx.item.source_id, ctx.item.client_id
					if
						client
						and vim.lsp.get_client_by_id(client).name
							== "emmet_language_server"
					then
						source = "emmet"
					end
					local sourceIcons = { emmet = "" }
					return {
						" ",
						{
							sourceIcons[source] or ctx.kind_icon,
							-- ctx.icon_gap,
							hl_group = ("BlinkCmpKind" .. ctx.kind),
						},
						{
							" " .. ctx.label:match("[^(]+"),
							ctx.kind == "Snippet" and "~" or "",
							ctx.detail,
							fill = true,
							hl_group = ctx.deprecated
									and "BlinkCmpLabelDeprecated"
								or "BlinkCmpLabel",
							max_width = 80,
						},
						{
							"󱚝 " .. ctx.item.source_name,
							fill = true,
							max_width = 80,
						},
						" ",
					}
				end,
			},
			documentation = {
				border = "rounded",
				auto_show = true,
			},
			signature_help = {
				border = "rounded",
			},
			ghost_text = {
				enabled = true,
			},
		},
		kind_icons = kind_icons,
		fuzzy = {
			use_typo_resistance = true,
			use_frecency = true,
			use_proximity = true,
			max_items = 15,
			-- sorts = { "label", "kind", "score" },

			prebuilt_binaries = {
				download = true,
				force_version = nil,
				force_system_triple = nil,
			},
		},
		-- experimental signature help support
		trigger = {
			signature_help = { enabled = true },
			completion = {
				show_in_snippet = false,
				-- keyword_range = "full",
			},
		},
		sources = {
			completion = {
				enabled_providers = {
					"codeaction",
					"path",
					"lsp",
					"snippets",
					"buffer",
				},
			},
			providers = {
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					enabled = true, -- whether or not to enable the provider
					transform_items = nil, -- function to transform the items before they're returned
					should_show_items = true,
					max_items = nil, -- maximum number of items to return
					min_keyword_length = 0, -- minimum number of characters to trigger the provider
					fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
					score_offset = 0, -- boost/penalize the score of the items
					override = {}, -- override the source's functions
				},
				path = {
					name = "Path",
					module = "blink.cmp.sources.path",
					score_offset = 3,
					opts = {
						trailing_slash = false,
						label_trailing_slash = true,
						get_cwd = function(context)
							return vim.fn.expand(
								("#%d:p:h"):format(context.bufnr)
							)
						end,
						show_hidden_files_by_default = false,
					},
				},
				snippets = {
					name = "Snippets",
					module = "blink.cmp.sources.snippets",
					score_offset = -1,
					min_keyword_length = 1,
					opts = {
						friendly_snippets = true,
						search_paths = {
							vim.fn.stdpath("config") .. "/snippets",
						},
						global_snippets = { "all" },
						extended_filetypes = {},
						ignored_filetypes = {},
					},
				},
				buffer = {
					name = "Buffer",
					module = "blink.cmp.sources.buffer",
					max_items = 4,
					min_keyword_length = 4,
					score_offset = -3,
					fallback_for = {},
				},
			},
		},
	},
}
