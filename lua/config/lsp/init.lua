local M = {}

local servers = {
  gopls = {
    analyses = {
      unusedparams = true,
      unreachable = true,
    },
    staticcheck = true,
  },
  html = {},
  jsonls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  vimls = {},
}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure formatting
  require("config.lsp.null-ls.formatters").setup(client, bufnr)

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)

  -- nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    local navic = "nvim-navic"
    navic.attach(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

M.capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
  -- null-ls
  require("config.lsp.null-ls").setup(opts)

  -- Installer
  require("config.lsp.mason-installer").setup(servers, opts)
end

return M
