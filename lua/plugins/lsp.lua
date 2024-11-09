return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		dependencies = {
			{
				"williamboman/mason.nvim",
				keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
				opts = {
					ui = {
						border = "rounded",
						icons = require("config").icons.packages,
					},
				},
			},
			"williamboman/mason-lspconfig.nvim",
			{
				"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
				config = function()
					require("lsp_lines").setup()
				end,
			},
		},
		config = function()
			-- local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			for server_name, cfg in pairs(require("config.lsp.servers").lsp) do
				local server_config = cfg or {}
				server_config.capabilities =
					vim.lsp.protocol.make_client_capabilities()
				server_config.on_attach =
					require("config.lsp.on_attach").on_attach
				lspconfig[server_name].setup(server_config)
			end
			-- Lo pensaré eso :D
			-- require("mason-lspconfig").setup({
			--   ensure_installed = vim.tbl_keys(servers),
			-- })
			require("utils.installed").is_Mason_registry({
				"emmet-language-server",
				"bash-language-server",
				"lua-language-server",
				"shellcheck",
				"codelldb",
				"stylua",
				"shfmt",
			})

			mason_lspconfig.setup({
				ensure_installed = {
					"rust_analyzer",
					"html",
					"pyright",
					"taplo",
				},
			})
		end,
	},
}
