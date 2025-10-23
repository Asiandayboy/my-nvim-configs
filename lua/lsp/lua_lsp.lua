-- path to lua_lsp executable1
local lua_ls_path = "lua-language-server"

vim.lsp.config["lua_lsp"] = {
	cmd = { lua_ls_path },

	filetypes = { "lua" },

	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },

	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				-- get the language server to recognize the 'vim' global
				globals = { "vim" },
				disable = { "trailing-space" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		}
	}

}


vim.lsp.enable("lua_lsp")

return nil
