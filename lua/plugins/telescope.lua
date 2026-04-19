return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = { height = 0.9 },
				file_ignore_patterns = {},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob",
					"!.git/*",
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					no_ignore = true,
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ hidden = true, no_ignore = true })
		end, { desc = "telescope find files (incl dotfiles)" })

		vim.keymap.set("n", "<leader>fg", function()
			builtin.live_grep({ additional_args = { "--hidden", "--glob", "!.git/*" } })
		end, { desc = "telescope live grep (incl dotfiles)" })

		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "telescope help tags" })
		vim.keymap.set("n", "<leader>bb", builtin.buffers, { desc = "telescope buffers" })
	end,
}
