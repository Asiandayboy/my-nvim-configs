require("config.options")
require("config.keybinds")
require("config.commands")
require("config.lazy")

require("lsp.lua_lsp")
require("lsp.clangd")
require("lsp.tsserver")
require("lsp.sourcekit-lsp")
require("lsp.webstuff-lsp")



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


