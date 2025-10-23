
vim.lsp.config["tsserver"] = {
	cmd = { "typescript-language-server", "--stdio" },

	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", },

	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },

	settings = {
	},
}


vim.lsp.enable("tsserver")



return nil
