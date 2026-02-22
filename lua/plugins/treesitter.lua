return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		branch = "master",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
					disable = { "cpp" },
				},
				autotage = {
					enable = true,
				},
				ensure_installed = {
					"lua", "luau", "c", "javascript", "typescript",
					"tsx", "vim", "cpp", "html", "css", "sql",
					"bash", "markdown", "markdown_inline", "ini"
			},
				auto_install = false,
			})
		end
	}

}
