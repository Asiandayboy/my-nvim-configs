require("config.options")
require("config.keybinds")
require("config.commands")
require("config.lazy")

require("lsp.lua_lsp")
require("lsp.clangd")
require("lsp.tsserver")
-- require("lsp.sourcekit-lsp")
require("lsp.webstuff-lsp")


local parsers = os.getenv("NVIM_TREESITTER_PARSERS")
if parsers then
    -- append the parent dir, not the parser dir itself
    vim.opt.runtimepath:append(vim.fn.fnamemodify(parsers, ":h"))
end

vim.treesitter.language.register("tsx", "typescriptreact")
vim.treesitter.language.register("javascript", "javascriptreact")
vim.api.nvim_create_autocmd("FileType", {
    pattern = { 
		"typescriptreact", "javascriptreact", "tsx", "jsx", "typescript", "javascript", 
		"html", "css", 
		"cpp", 
		"lua", 
		"bash", 
		"sql",
		"nix",
	},
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config["lua_lsp"].capabilities = capabilities
vim.lsp.config["clangd"].capabilities = capabilities
vim.lsp.config["tsserver"].capabilities = capabilities
vim.lsp.config["html"].capabilities = capabilities
vim.lsp.config["css"].capabilities = capabilities

-- vim.lsp.config("*", {
-- 	capabilities = {
-- 		workspace = {
-- 			didChangeWatchedFiles = {
-- 				dynamicRegistration = true,
-- 			}
-- 		}
-- 	}
-- })

----------------------------------


