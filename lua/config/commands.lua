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



