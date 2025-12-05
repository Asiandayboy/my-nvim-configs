vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>cd", function()
  require("oil").open()
end, { desc = "Go up one directory in Oil" })


-- F2 to rename a symbol, like VSCode :]
vim.keymap.set('n', "<F2>", function()
	vim.lsp.buf.rename(nil)
end, { desc = "Rename symbol" })


-- Normal mode: Tab goes to next tab
vim.keymap.set('n', '<Tab>', 'gt', { noremap = true, silent = true })

-- Normal mode: Shift-Tab goes to previous tab
vim.keymap.set('n', '<S-Tab>', 'gT', { noremap = true, silent = true })

vim.keymap.set('n', "<C-Up>", "<C-u>", { noremap = true, silent = true })
vim.keymap.set('n', "<C-Down>", "<C-d>", { noremap = true, silent = true })

vim.keymap.set('n', "tt", function()
	vim.cmd("tabnew | term")
end, { desc = "Open a new terminal tab page" })



-- Go to definition (robust)
vim.keymap.set('n', 'gd', function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		vim.notify('No active LSP client', vim.log.levels.WARN)
		return
	end

	local client = clients[1]
	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

	local function realpath(path)
		-- try luv realpath (resolves symlinks); fallback to :p normalize
		local ok, rp = pcall(vim.loop.fs_realpath, path)
		if ok and rp and rp ~= '' then
			return rp
		end
		-- fallback - normalized absolute path
		return vim.fn.fnamemodify(path, ':p')
	end

	local function choose_entry(results)
		-- results can be:
		--  - a single Location or LocationLink
		--  - an array of Locations/LocationLinks
		--  - nested arrays (some servers)
		-- Normalize to a flat list
		local flat = {}
		local function push(x)
			if type(x) ~= 'table' then return end
			-- detect Location vs LocationLink: both are tables
			if x.uri or x.targetUri or x.filename or x.range then
				table.insert(flat, x)
				return
			end
			-- if it's a list, iterate
			for _, v in ipairs(x) do push(v) end
		end
		push(results)

		if #flat == 0 then return nil end

		-- prefer an entry that points into the current buffer
		local curbufname = vim.api.nvim_buf_get_name(0)
		local curreal = realpath(curbufname)

		for _, e in ipairs(flat) do
			local uri = e.uri or e.targetUri
			if uri then
				local fname = vim.uri_to_fname(uri)
				if fname and fname ~= '' then
					if realpath(fname) == curreal then
						return e
					end
				end
			end
		end

		-- otherwise return the first entry
		return flat[1]
	end

	local function go_to_file_in_tab(filename, range)
		local bufnr = vim.fn.bufnr(filename, true) -- get buffer, create if doesn't exist
		local found = false

		-- Iterate over all tabpages
		for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
				local win_buf = vim.api.nvim_win_get_buf(win)
				if win_buf == bufnr then
					-- Found buffer in an existing window -> switch to tab and window
					vim.api.nvim_set_current_tabpage(tab)
					vim.api.nvim_set_current_win(win)
					found = true
					break
				end
			end
			if found then break end
		end

		if not found then
			-- Buffer not found in any tab -> open new tab
			vim.cmd('tabnew ' .. vim.fn.fnameescape(filename))
		end

		-- Move cursor (safe to schedule)
		vim.schedule(function()
			vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
		end)
	end

	vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx, _)
		if err then
			vim.notify('Error getting definition: ' .. (err.message or tostring(err)), vim.log.levels.ERROR)
			return
		end
		if not result or vim.tbl_count(result) == 0 then
			vim.notify('No definition found', vim.log.levels.WARN)
			return
		end

		local entry = choose_entry(result)
		if not entry then
			vim.notify('No usable definition entry found', vim.log.levels.WARN)
			return
		end

		local uri = entry.uri or entry.targetUri
		local range = entry.range or entry.targetSelectionRange
		if not uri or not range then
			vim.notify('Definition entry missing uri or range', vim.log.levels.ERROR)
			return
		end

		local filename = vim.uri_to_fname(uri)
		local file_real = realpath(filename)
		local cur_real = realpath(vim.api.nvim_buf_get_name(0))

		if file_real == cur_real then
			-- same file: just move cursor in the current window
			vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
		else
			-- -- different file: open a new tab and jump there
			-- vim.cmd('tabnew ' .. vim.fn.fnameescape(filename))
			-- -- ensure we run cursor move in scheduled context (safe)
			-- vim.schedule(function()
			-- 	vim.api.nvim_win_set_cursor(0, { range.start.line + 1, range.start.character })
			-- end)
			go_to_file_in_tab(filename, range)
		end
	end)
end, { desc = 'Go to Definition (new tab if different file)' })

