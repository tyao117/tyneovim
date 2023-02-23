local M = {}

function M.setup(servers, options)
  local lspconfig = require "lspconfig"

  require("mason-lspconfig").setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_isntallation = false,
  }

  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})
      lspconfig[server_name].setup { opts }
    end,
  }
end

return M