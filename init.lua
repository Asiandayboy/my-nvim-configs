require("config.options")
require("config.keybinds")
require("config.commands")
require("config.lazy")
require("lsp.lua_lsp")
require("lsp.clangd")
require("lsp.tsserver")

--[[ lsp configs ]]--
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		--if client:supports_method("textDocument/completion") then
		--	vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		--end

	end
})


local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config["lua_lsp"].capabilities = capabilities
vim.lsp.config["clangd"].capabilities = capabilities
vim.lsp.config["tsserver"].capabilities = capabilities

----------------------------------

print("init.lua initialized!")

