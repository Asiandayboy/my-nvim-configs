return {
	{ -- git plugin
		"tpope/vim-fugitive",
	},
	{ -- show CSS colors
		"brenoprata10/nvim-highlight-colors",
		config = function()
			require("nvim-highlight-colors").setup({})
		end
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			local ibl = require("ibl")
			ibl.setup({
				indent = { char = "▏" },
				exclude = {
					buftypes = {},
					filetypes = {},
				},
			})
		end
	}
}
