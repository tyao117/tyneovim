local M = {}

local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'lua_ls', 'gopls', 'terraform-ls' }

function M.setup()
  require('mason-lspconfig').setup {
    ensure_installed = servers,
  }
end

return M
  
