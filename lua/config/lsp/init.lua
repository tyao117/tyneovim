local M = {}

local servers = {
  gopls = {
    analyses = {
      unusedparams = true,
      unreachable = true,
    },
    staticcheck = true,
    buildFlags = {"-tags=integration,examples"},
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  html = {},
  jsonls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  terraformls = {},
  vimls = {},
  yamlls = {
    yaml = {
      validate = false,
    },
  },
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

  -- Configure using help on a function
  -- require("lsp_signature").on_attach(signature_setup, bufnr)

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
    debounce_text_changes = 500,
  },
}

function M.setup()
  -- Setup LSP handlers
  require("config.lsp.handlers").setup()

  -- null-ls
  require("config.lsp.null-ls").setup(opts)

  -- Mason Installer
  require("config.lsp.mason-installer").setup(servers, opts)
end

return M
