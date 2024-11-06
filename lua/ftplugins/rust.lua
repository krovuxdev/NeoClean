local extension_path = vim.env.HOME .. ".local/share/nvim/mason/packages/codelldb/"
local codelldb_path = extension_path .. "extension/adapter/codelldb"
local liblldb_path = extension_path .. "extension/lldb/lib/liblldb.so"
return {
  {
    "rust-lang/rust.vim",
    ft = "rust",

    init = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_fail_silently = 1
      --
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
    lazy = false,
    -- enabled = false,
    opts = {
      -- Plugin configuration
      tools = {
        reload_workspace_from_cargo_toml = true,
      },
      -- LSP configuration
      server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function(_, bufnr)
          local enabled = require("utils.toggle")
          vim.keymap.set("n", "<Leader>k", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { buffer = bufnr, desc = "Hover actions (Rust)" })
          vim.keymap.set("n", "<Leader>a", function()
            vim.cmd.RustLsp("codeAction")
          end, { buffer = bufnr, desc = "Code actions (Rust)" })
          vim.keymap.set("n", "<Leader>h", function()
            vim.lsp.inlay_hint.enable(enabled.ToggleEnabled())
          end, { noremap = true, silent = true, desc = "Toggle Inlay_hints (Rust)" })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
              disabled = { "non_camel_case_types" },
            },
            -- checkOnSave = true,
            -- cargo = {
            --   workspaceMembers = true,
            --   allFeatures = true,
            --   loadOutDirsFromCheck = true,
            --   runBuildScripts = true,
            -- },
            -- procMacro = {
            --   enable = true,
            -- },
          },
        },
      },
      -- DAP configuration
      dap = {
        --   adapter = require("rustaceanvim").get_codelldb_adapter(codelldb_path, liblldb_path),
        --   -- autoload_configurations = true,
        --   -- cwd = "${workspaceFolder}",
      },
      -- code
    },
    config = function(_, opts)
      vim.lsp.inlay_hint.enable(true)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
  },
}
