return {
	"thesimonho/kanagawa-paper.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
	config = function()
		local kanagawa_colors = require("kanagawa-paper.colors")
		local palette_colors = kanagawa_colors.palette
		require("kanagawa-paper").setup({
			transparent = true,
			terminal_colors = true,
			dim_inactive = false,
			cache = false,

			styles = {
				comment = { italic = false },
				keyword = { bold = false },
				type = { bold = false },
				statement = { bold = false },
			},

			colors = {
				theme = {
					ink = {
						modes = {
							normal = "#58A2CD",
							insert = "#DD4F4F",
							visual = "#A973CB",
							replace = palette_colors.dragonRed,
							command = "#D4BD71",
						},
						vcs = {
							changed = "#D2BA73",
							added = "#579657",
							removed = "#C55D56",
						},
						ui = {
							tabline = {
								bg_inactive = palette_colors.sumiInk3,
								fg_inactive = "#75736B",
								bg_selected = "NONE",
								bg = "NONE",
							},
						},
					},
				},
			},

			color_offset = {
				ink = { brightness = 0, saturation = 0 },
			},

			overrides = function(colors)
				local palette = colors.palette
				if not palette then return {} end
				local theme = colors.theme
				return {
					LineNr = { fg = palette.dragonBlack6, bold = false },
					CursorLineNr = { bold = false },
					Normal = { fg = palette.dragonGray },
					--StatusLineNC = { bg = theme.ui.bg_statusline },
					CursorLine = { bg = "#303040" },
					--FloatBorder = { fg = palette.dragonBlack5, },

					Comment = { fg = "#75736B" },
					Boolean = { fg = palette.dragonRed, bold = false },
					Operator = { fg = palette.lotusOrange2, bold = false },
					Delimiter = { fg = palette.lotusBlue5, bold = false },
					Function = { fg = "#dec46e", bold = false },
					Type = { fg = palette.lotusTeal2, bold = false },
					Constant = { fg = palette.oniViolet, bold = false },
					String = { fg = "#77aade", bold = false },
					Keyword = { fg = "#be753a", bold = false },
					Number = { fg = palette.springBlue, bold = false },
					["@lsp.type.method"] = { fg = palette.springBlue, bold = false },
					["@lsp.type.variable"] = { fg = "#9aacc1", bold = false },
					["@lsp.type.punctuation"] = { fg = palette.oniViolet },
					["@lsp.type.parameter"] = { fg = "#77aade" },
					["@constructor"] = { fg = "#64727f" },
					["@punctuation.delimiter"] = { fg = "#46a0f5" },
					["@punctuation.bracket"] = { fg = "#569CD6" },
					["@keyword.operator"] = { fg = "#be753a", bold = false },
					["@keyword.return"] = { fg = "#be753a", bold = false },
					["@variable.builtin"] = { fg = palette.crystalBlue, bold = false },
					Folded = { bg = "NONE", bold = true },

				}
			end,

		})
		vim.cmd.colorscheme("kanagawa-paper-ink")
	end,

	--{
	--	'AlexvZyl/nordic.nvim',
	--	lazy = false,
	--	priority = 1000,
	--	config = function()
	--		require('nordic').load()
	--	end
	--}
}
