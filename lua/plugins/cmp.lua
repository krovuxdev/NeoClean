return {
  "hrsh7th/nvim-cmp",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    -- CMP
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
    --
    "onsails/lspkind.nvim",
    -- "windwp/nvim-ts-autotag",
    "windwp/nvim-autopairs",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "Luasnip",
  },
  config = function()
    local cmp = require("cmp")
    vim.api.nvim_set_hl(0, "Pmenu", { link = "CmpPmenu" })
    local pairs_ok, pairs = pcall(require, "nvim-autopairs")
    if pairs_ok then
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
    end
    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end
    -- vim.g.completion_disable_snippets = 1
    cmp.setup({

      matching = {
        disallow_fuzzy_matching = true,
        disallow_fullfuzzy_matching = true,
        disallow_prefix_unmatching = true,
        disallow_partial_matching = false,
        disallow_partial_fuzzy_matching = false,
        disallow_symbol_nonprefix_matching = false,
      },

      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },

      completion = {
        completeopt = "Pmenu,menuone,noinsert",
      },

      window = {
        completion = {
          side_padding = ("default" ~= "gruvbox-material" and "default" ~= "gruvbox-material") and 1 or 0,
          keyword_length = 1,
          winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenu,Search:None",

          border = border("CmpDocBorder"),
          scrollbar = false,
        },

        documentation = {
          border = border("CmpDocBorder"),
          winhighlight = "Normal:CmpDoc",
        },
      },

      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<s-tab>"] = cmp.mapping.select_prev_item(),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<c-c>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      }),

      sources = cmp.config.sources({

        { name = "vsnip" },
        { name = "path" },
        -- { name = "copilot" },
      }, {
        {
          name = "nvim_lsp",

          keyword_length = 3,
          entry_filter = function(entry, _)
            local kind = entry:get_kind()
            local allowed_filetypes = { "html", "css", "scss" }
            local filetype = vim.bo.filetype

            if vim.tbl_contains(allowed_filetypes, filetype) then
              return true
            end
            if kind == 15 or kind == 1 then
              return false
            end
            return true
          end,
        },
        {
          name = "buffer",
        },

        { name = "luasnip" },
      }),

      formatting = {
        expandable_indicator = true,
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = vim_item.kind
          local icons_kind = require("config")
          vim_item.kind = " " .. (icons_kind.icons.kinds[kind] or "?")
          vim_item.menu = "   " .. entry.source.name
          -- vim_item.abbr = vim_item.abbr:match("[^(]+")
          local source = entry.source.name
          if source == "nvim_lsp" then
            vim_item.dup = 1
          end
          return vim_item
        end,
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
