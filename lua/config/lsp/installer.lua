local M = {}

function M.setup(servers, options)
  local lspconfig = require "lspconfig"
  require("mason-lspconfig").setup{
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
  }
  require("mason-lspconfig").setup_handlers {
    function(server_name)
      local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})
      lspconfig[server_name].setup { opts }
    end,
    ["tsserver"] = function()
      local opts = vim.tbl_deep_extend("force", options, servers["tsserver"] or {})
      require("typescript").setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    end,
  }

end

return M
