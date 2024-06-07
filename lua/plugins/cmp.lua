function slice(tbl, start, finish, step)
  local sliced = {}
  for i = start, finish, step or 1 do
    table.insert(sliced, tbl[i])
  end
  return sliced
end

_G.filter_enabled = false
_G.name_cmp = {
  { name = "nvim_lsp" },
  { name = "buffer" },
  { name = "copilot" },
  { name = "path" },
  { name = "luasnip" },
}
function ToggleFilter()
  local cmp = require("cmp")
  vim.notify = require("notify")
  if _G.filter_enabled then
    cmp.setup({
      sources = cmp.config.sources({
        unpack(_G.name_cmp),
      }),
    })
    print("Filtro activado [WORD-CMP]")
  else
    cmp.setup({
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            return require("cmp").lsp.CompletionItemKind.Text ~= entry:get_kind()
          end,
        },
        unpack(slice(_G.name_cmp, 2, 5)),
      }),
    })
  end
  _G.filter_enabled = not _G.filter_enabled
end

return {
  {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- CMP
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      --
      "onsails/lspkind.nvim",
      "windwp/nvim-ts-autotag",
      "windwp/nvim-autopairs",
      "tpope/vim-surround",
      "Luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("nvim-autopairs").setup()
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<s-tab>"] = cmp.mapping.select_prev_item(),
          ["<c-space>"] = cmp.mapping.complete({}),
          ["<c-c>"] = cmp.mapping.abort(),
          ["<cr>"] = cmp.mapping.confirm({ select = true }),
        }),
        -- sources = cmp.config.sources({
        --   unpack(_G.name_cmp),
        -- }),
        sources = ToggleFilter(),
        formatting = {
          expandable_indicator = true,
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = {
              Copilot = "",
            },
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })
    end,
    keys = {
      {
        "<leader>t",
        function()
          print("Filtro desactivado [WORD-CMP]")
          ToggleFilter()
        end,
        desc = "Toggle Text Filter",
      },
    },
  },
}
