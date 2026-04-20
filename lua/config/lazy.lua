local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
	change_detection = { notify = false },
})


local parsers = os.getenv("NVIM_TREESITTER_PARSERS")
if parsers then
    -- append the parent dir, not the parser dir itself
    vim.opt.runtimepath:append(vim.fn.fnamemodify(parsers, ":h"))
end

vim.treesitter.language.register("tsx", "typescriptreact")
vim.treesitter.language.register("javascript", "javascriptreact")
vim.api.nvim_create_autocmd("FileType", {
    pattern = { 
		"typescriptreact", "javascriptreact", "tsx", "jsx", "typescript", "javascript", 
		"html", "css", 
		"cpp", 
		"lua", 
		"bash", 
		"sql",
		"nix",
	},
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})
