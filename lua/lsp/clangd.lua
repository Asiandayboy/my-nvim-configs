


vim.lsp.config["clangd"] = {
	cmd = { "clangd" },

	filetypes = { "c", "cpp" },

	root_markers = { "Makefile", ".git", "CMakeLists.txt" },

	settings = {
	},
}



vim.lsp.enable("clangd")




return nil
