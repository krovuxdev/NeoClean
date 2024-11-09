local M = {}
M.on_attach = function(client, bufnr)
	local function map(mode, l, r, noremap, silent, desc)
		vim.keymap.set(mode, l, r, {
			noremap = noremap or true,
			silent = silent or true,
			buffer = bufnr,
			desc = desc,
		})
	end
	map("n", "<Leader>h", function()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end, { noremap = true, silent = true, desc = "Toggle Inlay_hints (HINTS)" })
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
	end
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
	end, { buffer = bufnr, desc = "Hover actions (CodeLens)" })
	map("n", "<Leader>[", function()
		local params = { context = { only = { "quickfix", "refactor" } } }
		vim.lsp.buf.code_action(params)
	end, { buffer = bufnr, desc = "Code actions (CodeLens)" })
	map("n", "]d", function()
		vim.diagnostic.goto_next()
	end, { buffer = bufnr, desc = "Code actions (CodeLens)" })
	map("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, { buffer = bufnr, desc = "Code actions (CodeLens)" })

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

	vim.diagnostic.config({
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

	-- client.server_capabilities.semanticTokensProvider = nil
end

return M
