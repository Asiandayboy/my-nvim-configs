
vim.lsp.config["html"] = {
	cmd = { "vscode-html-language-server", "--stdio" },

	filetypes = { 
		"html", 
		"htm", 
		"xhtml", 
		"handlebars",
		"razor",
		"vue",
		"svelte",
		"twig",
		"eruby",
		"php",
	},

	root_markers = { "index.html", "package.json", ".git" },

	settings = {
	},
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ejs",
	command = "set filetype=html",
})

vim.lsp.config["css"] = {
	cmd = { "vscode-css-language-server", "--stdio" },

	filetypes = { 
		"css", 
		"scss", 
		"sass", 
		"less",
		"postcss",
		"stylus",
	},

	root_markers = { "index.html", "package.json", ".git", "tsconfig.json" },

	settings = {
	},
}

vim.lsp.enable("html")
vim.lsp.enable("css")



return nil
