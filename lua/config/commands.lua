local namespace = "Eggs"

vim.api.nvim_create_user_command(namespace.."del", function(opts)
	local args = vim.split(opts.args, "%s+")
	if args[1] == "hidden" then
		local deleted = 0;

		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_loaded(buf) and vim.fn.bufwinnr(buf) == -1 then
				vim.api.nvim_buf_delete(buf, { force = true })
				deleted = deleted + 1
			end
		end
		
		print("Deleted "..deleted.." hidden buffer(s)")
	elseif args[1] == "noname" then
		local deleted = 0;

		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_name(buf) == "" then
				vim.api.nvim_buf_delete(buf, { force = true })
				deleted = deleted + 1
			end
		end
		
		print("Deleted "..deleted.." [No Name] buffer(s)")
	end
end, { nargs = "*" })


vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

do
	-- ide like highlight when stopping cursor
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
		desc = "Highlight references under cursor",
		callback = function()
			-- Only run if the cursor is not in insert mode
			if vim.fn.mode() ~= "i" then
				local clients = vim.lsp.get_clients({ bufnr = 0 })
				local supports_highlight = false
				for _, client in ipairs(clients) do
					if client.server_capabilities.documentHighlightProvider then
						supports_highlight = true
						break -- Found a supporting client, no need to check others
					end
				end

				-- 3. Proceed only if an LSP is active AND supports the feature
				if supports_highlight then
					vim.lsp.buf.clear_references()
					vim.lsp.buf.document_highlight()
				end
			end
		end,
	})

	-- ide like highlight when stopping cursor
	vim.api.nvim_create_autocmd("CursorMovedI", {
		group = "LspReferenceHighlight",
		desc = "Clear highlights when entering insert mode",
		callback = function()
			vim.lsp.buf.clear_references()
		end,
	})
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {
        "C:/Program Files/Microsoft Visual Studio/*/Community/VC/Tools/MSVC/*/include/*", 
    },
    callback = function()
        vim.bo.filetype = "cpp"
    end,
})
