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
				},
				autotage = {
					enable = true,
				},
				ensure_installed = {
					"lua", "luau", "c", "javascript", "typescript",
					"tsx", "vim", "cpp"
				},
				auto_install = false,
			})
		end
	}

}
