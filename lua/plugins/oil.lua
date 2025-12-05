return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
	},
	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,

	config = function()
		require("oil").setup({
			skip_confirm_for_simple_edits = true,
			columns = {
				{
					"icon",
					highlight = "OilDirIcon",
				},
				-- "permissions",
				-- "size",
				-- "mtime"
			},
			float = {
				max_height = 30,
				padding = 5,
				border = "double",
			},
			confirmation = {
				border = "double"
			},
			win_options = {
				signcolumn = "yes:2"
			}
		})
	end
} 
