vim.cmd([[
  augroup OpenNeoTreeOnStartup
    autocmd!
    autocmd VimEnter * if isdirectory(expand("%:p")) | execute 'Neotree show right' | endif
  augroup END
]])

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Text Yank with highlight(copying)",
	group = vim.api.nvim_create_augroup("NeoClean-YANK", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		require("conform").format()
	end,
})
vim.api.nvim_command("autocmd VimResized * wincmd =")
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		local new_lines, lines = {}, vim.api.nvim_buf_get_lines(0, 0, -1, false)
		local brackets = 0

		for i = 1, #lines do
			local line = lines[i]
			if
				string.match(line, "^[%s]*fn%s")
				or string.match(line, "^[%s]*struct%s")
				or string.match(line, "^[%s]*enum%s")
				or string.match(line, "^[%s]*impl%s")
				or string.match(line, "^[%s]*pub%s+fn%s")
				or string.match(line, "^[%s]*pub%s+struct%s")
				or string.match(line, "^[%s]*pub%s+enum%s")
				or string.match(line, "^[%s]*pub%s+impl%s")
			then
				brackets = brackets + 1
			end
			table.insert(new_lines, line)

			if string.match(line, "^%s*}%s*$") then
				local next_line = lines[i + 1] or ""
				if not string.match(next_line, "^%s*$") then
					table.insert(new_lines, "")
				end
				-- if brackets == 0 then
				-- table.insert(new_lines, "")
				brackets = math.max(brackets - 1, 0)
				-- end
			end
			-- if string.match(line, "^%s*}$") then
			--   brackets = brackets - 1
			-- end
		end
		if new_lines[#new_lines] == "" and new_lines[#new_lines - 1] == "" then
			table.remove(new_lines, #new_lines)
		end
		vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
	end,
})

-- despues actualizare mis configuracion usare este, porque no funciona
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
-- 		vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
-- 		------------------------------------------------------------------------------
-- 		vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { link = "Comment" })
-- 		vim.cmd("highlight Winbar guibg=none")
-- 	end,
-- })

-- vim.api.nvim_create_autocmd("BufDelete", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.fn.bufexists(1) == 0 and vim.fn.tabpagenr("$") == 1 then
-- 			-- Mostrar mini.starter
-- 			-- require("mini.starter").open()
-- 			vim.schedule(function()
-- 				require("mini.starter").open()
-- 				require("tabby").setup()
-- 			end)
-- 		end
-- 	end,
-- })

vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		local current_config = vim.diagnostic.config()
		vim.diagnostic.config(vim.tbl_extend("force", current_config, {
			virtual_lines = false,
		}))
	end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		local current_config = vim.diagnostic.config()
		vim.diagnostic.config(vim.tbl_extend("force", current_config, {
			virtual_lines = true,
		}))
	end,
})
