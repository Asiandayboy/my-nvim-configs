local others = {
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
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				check_ts = true,
			})
			local Rule = require('nvim-autopairs.rule')
			local npairs = require('nvim-autopairs')

			npairs.add_rules({
				Rule('then', 'end'):end_wise(function(opts)
					-- Add any context checks here, e.g. line starts with "if"
					return string.match(opts.line, '^%s*if') ~= nil
				end),
				-- Rule("%)$", "end", { "lua", "luau" })
				-- 	:only_cr(function() return true end), -- CR = Enter key
			})
		end,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	}
}



return others
