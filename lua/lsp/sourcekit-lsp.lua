

vim.lsp.config["sourcekit-lsp"] = {
	cmd = { "sourcekit-lsp" },

	filetypes = { "swift" },

	root_markers = { "Package.swift", "Sources", "sourcekit-lsp-root", ".git" },

	settings = {
	},
}


vim.lsp.enable("sourcekit-lsp")



return nil
