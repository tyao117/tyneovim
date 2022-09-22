-- require'lspconfig'.pyright.setup{}

-- Setup nvim-cmp.
vim.lsp.set_log_level("debug")
local nvim_lsp = require('lspconfig')

-- add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- on_attach function
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<space>ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gD',         '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',         '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa',  '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr',  '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>e',   '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d',         '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',         '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q',   '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f',   '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', '<space>wl',  '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

local border = {
      {"🭽", "FloatBorder"},
      {"▔", "FloatBorder"},
      {"🭾", "FloatBorder"},
      {"▕", "FloatBorder"},
      {"🭿", "FloatBorder"},
      {"▁", "FloatBorder"},
      {"🭼", "FloatBorder"},
      {"▏", "FloatBorder"},
}

local handlers = {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
  ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local coq = require('coq')
local util = require('lspconfig/util')
local servers = {
  -- pyright
  {
    name = 'pyright',
    config = { 
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
          },
          venvPath = {".direnv"}, 
        },
      },
      -- update the root detection to be the last thing to be used
      root_dir = function(fname)
        local root_files = {
          'pyproject.toml',
          'setup.py',
          'setup.cfg',
          'requirements.txt',
          'Pipfile',
          'pyrightconfig.json',
        }
        return util.find_git_ancestor(fname) or util.path.dirname(fname) or util.root_pattern(unpack(root_files))(fname)
      end
    }
  }, 
  -- gopls
  {
    name = 'gopls',
    config = {
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
            unusedparams = true,
     	    shadow = true,
          },
          staticcheck = true,
        },
	  },
    }
  },
}

-- overriding globally for the LSP settings
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

for _, lsp in ipairs(servers) do
  if lsp.config then
      lsp.config.on_attach = on_attach
  else
      lsp.config = {
          on_attach = on_attach
      }
  end

  nvim_lsp[lsp.name].setup( coq.lsp_ensure_capabilities(lsp.config))
end

-- overriding how diagnostic is displayed
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

-- show line diagnosticMode in hover window
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
