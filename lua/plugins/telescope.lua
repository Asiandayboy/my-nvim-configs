return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'telescope help tags' })
		vim.keymap.set('n', "<leader>bb", builtin.buffers, { desc = "Search for opened buffers with telescope" })

		-- vim.keymap.set('n', 'grr', function()
		-- 	local client = vim.lsp.get_clients({ bufnr = 0 })[1]
		-- 	local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
		--
		-- 	builtin.lsp_references({
		-- 		show_line = true,
		-- 		fname_width = 60,
		-- 		params = params, -- pass explicit params with encoding
		-- 	})
		-- end, { desc = "Telescope LSP References" })

		require("telescope").setup({
			defaults = {
				layout_strategy = "vertical",
				layout_config = {
					height = 0.9
				},
			},
		})
	end
}
