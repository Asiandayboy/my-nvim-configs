


vim.lsp.config["clangd"] = {
	cmd = { 
		"clangd" ,
		"--query-driver=**",
	},

	filetypes = { "c", "cpp", "hpp" },

	root_markers = { "Makefile", ".git", "CMakeLists.txt" },

	init_options = {
		semanticHighlighting = true,
		clangdFileStatus = true,
	},

	settings = {
	},
}


vim.lsp.enable("clangd")




return nil
