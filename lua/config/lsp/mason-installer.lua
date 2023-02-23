-- local mason_servers = require "mason-lspconfig"
-- local utils = require "utils"
-- 
-- local M = {}
-- 
-- function M.setup(servers, options)
--   for server_name, _ in pairs(servers) do
--     local server_available, server = mason_servers.get_installed_servers(server_name)
-- 
--     if server_available then
--       server:on_ready(function()
--         local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})
-- 
--         -- if server.name == "sumneko_lua" then
--         --   opts = require("lua-dev").setup { lspconfig = opts }
--         -- end
-- 
--           -- Used for COQ
--           -- local coq = require "coq"
--           -- server:setup(coq.lsp_ensure_capabilities(opts))
--           server:setup(opts)
--       end)
-- 
--       if not server:is_installed() then
--         utils.info("Installing " .. server.name)
--         server:install()
--       end
--     else
--       utils.error(server)
--     end
--   end
-- end
-- 
-- return M
local notify = require "mason-core.notify"
local server_mapping = require "mason-lspconfig.mappings.server"

local M = {}

function M.setup(pkg, version)
    local lspconfig_name = server_mapping.package_to_lspconfig[pkg.name]
    notify(("[mason-lspconfig.nvim] installing %s"):format(lspconfig_name))
    return pkg:install({ version = version }):once(
        "closed",
        vim.schedule_wrap(function()
            if pkg:is_installed() then
                notify(("[mason-lspconfig.nvim] %s was successfully installed"):format(lspconfig_name))
            else
                notify(
                    ("[mason-lspconfig.nvim] failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(
                        lspconfig_name
                    ),
                    vim.log.levels.ERROR
                )
            end
        end)
    )
end

return M

