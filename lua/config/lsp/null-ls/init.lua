local M = {}

local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local mnls = require "mason-null-ls"
local b = nls.builtins

local sources = {
  -- formatting
  b.formatting.shfmt,
  b.formatting.fixjson,
  b.formatting.isort,
  b.formatting.stylua,
  b.formatting.autopep8,
  b.formatting.gofumpt,

  -- diagnostics
  b.diagnostics.yamllint.with(
    {
      rules = {
        key_ordering = disable,
      },
    }
  ),

  -- hover
  b.hover.dictionary,
}

function M.setup(opts)
  nls.setup {
    -- debug = true,
    debounce = 500,
    save_after_format = false,
    sources = sources,
    on_attach = opts.on_attach,
    root_dir = nls_utils.root_pattern ".git",
  }

  mnls.setup {
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = false,
  }
end

return M
