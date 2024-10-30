return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        config = true,
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
      },
      "williamboman/mason-lspconfig.nvim",
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
          require("lsp_lines").setup()
        end,
      },
      -- "github/copilot.vim",
      "j-hui/fidget.nvim",
      -- "mfussenegger/nvim-dap",
      { "folke/neodev.nvim", opts = {} },
    },

    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      mason.setup({
        ui = {
          border = "rounded",
          icons = require("config").icons.packages,
        },
      })
      -- require("mason-lspconfig").setup({
      --   ensure_installed = vim.tbl_keys(servers),
      -- })
      mason_lspconfig.setup_handlers({
        function(server_name)
          local server_config = require("config.lsp.servers")[server_name] or {}
          if server_name == "rust_analyzer" then
            return
          end

          lspconfig[server_name].setup({
            capabilities = capabilities,
            settings = server_config,
            filetypes = (server_config or {}).filetypes,
          })
        end,
      })
      lspconfig.nixd.setup({
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
      })

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
          "pyright",
          "taplo",
        },
      })
    end,
  },
}
