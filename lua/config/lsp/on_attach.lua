local M = {}
M.on_attach = function(client, bufnr)
	local dg = vim.diagnostic
	local bf = vim.lsp.buf
	local opts = {
		noremap = true,
		silent = true,
		buffer = bufnr,
		desc = "?",
	}
	local function map(mode, l, r, _opts)
		local _ = vim.tbl_extend("force", opts, _opts or {})
		vim.keymap.set(mode, l, r, _)
	end

	map("n", "<Leader>h", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { desc = "Toggle Inlay_hints (HINTS)" })
	map("n", "<Leader>ck", function()
		local found_float = false
		vim.lsp.buf.hover()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_config(win).relative ~= "" then
				vim.api.nvim_win_close(win, true)
				found_float = true
			end
		end

		if found_float then
			return
		end
	end, { desc = "Hover actions (CodeLens)" })
	map(
		"n",
		"<Leader>{",
		":vsplit | lua vim.lsp.buf.definition()",
		{ desc = "Go To definition" }
	)

	map("n", "<Leader>[", bf.code_action, {
		desc = "Code actions (CodeLens)",
	})
	map("n", "]d", dg.goto_next, { desc = "Code actions (CodeLens)" })
	map("n", "[d", dg.goto_prev, { desc = "Code actions (CodeLens)" })

	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
				if vim.api.nvim_win_get_config(winid).zindex then
					return
				end
			end
			vim.diagnostic.open_float(nil, {
				focusable = false,
				close_events = {
					"BufLeave",
					"CursorMoved",
					"InsertEnter",
					"FocusLost",
				},
				border = "rounded",
				source = "always",
			})
		end,
	})

	dg.config({
		virtual_text = false,
		underline = true,
		update_in_insert = false,
	})

	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

	local original_vim_ui_select = vim.ui.select
	---@diagnostic disable-next-line: duplicate-set-field
	vim.ui.select = function(items, select_opts, on_choice)
		if select_opts.kind ~= "codeaction" then
			return original_vim_ui_select(items, select_opts, on_choice)
		end

		---@param item {action: lsp.Command|lsp.CodeAction, ctx: lsp.CodeActionContext}
		select_opts.format_item = function(item)
			local formatted =
				item.action.title:gsub("\r\n", "\\r\\n"):gsub("\n", "\\n")
			local client_id = item.ctx and item.ctx.client_id
			if client_id then
				local action_client = vim.lsp.get_client_by_id(client_id)
				local source_name = action_client and action_client.name
					or "unknown"
				formatted = formatted .. " [" .. source_name .. "]"
			end
			return formatted
		end

		original_vim_ui_select(items, select_opts, on_choice)
	end

	vim.o.updatetime = 1000
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end
	-- client.server_capabilities.semanticTokensProvider = nil
end

return M
