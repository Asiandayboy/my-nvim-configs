vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true


vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})


vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 12
vim.diagnostic.config({
	--virtual_lines = true,
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})
vim.o.updatetime = 250  -- delay before hover
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false, source = true, border = "rounded" })]]

vim.opt.shell = "powershell"
vim.opt.clipboard = "unnamedplus"

vim.opt.showtabline = 2
function _G.MyTabLabel()
	local s = ""
	for tab_num, tab in ipairs(vim.api.nvim_list_tabpages()) do
		local win = vim.api.nvim_tabpage_get_win(tab)
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t")
		if name == "" then name = "[No Name]" end
		local clickable = "%"..tab_num.."T"
		local highlighted_name = ""

		if tab == vim.api.nvim_get_current_tabpage() then
			highlighted_name = "%#TabLineSel# "..name
		else
			highlighted_name = "%#TabLine# "..name
		end
		s = s..clickable..highlighted_name.." "
	end

	-- fill remaining space and add the TabLineFill highlight group to it
	s = s.."%#TabLineFill# %="

	-- -- add a clickable X button; we use 9999 as an arbitrary num so that it doesnt
	-- -- conflict with the tab numbers
	-- s = s.."%9999X X"

	return s
end
vim.opt.tabline = "%!v:lua.MyTabLabel()"




vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99 -- a random high number to ensure all folds are opened by default
vim.opt.foldenable = true
vim.opt.cinoptions="sNl1" -- works with disabling Treesiter indent for cpp

vim.filetype.add({
	pattern = {
		[".*%.env%..*"] = "sh",
	}
})


