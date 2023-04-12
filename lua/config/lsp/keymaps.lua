local M = {}

local whichkey = require "which-key"

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Key mappings
  buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

  -- Whichkey
  local keymap_l = {
    l = {
      name = "Code",
      r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
    },
  }
  if client.server_capabilities.documentFormattingProvider then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  end

  local keymap_g = {
    name = "Goto",
    d = { "<Cmd>Telescope lsp_definitions<CR>", "Definitions" },
    D = { "<Cmd>Telescope lsp_declarations<CR>", "Declarations" },
    r = { "<Cmd>Telescope lsp_references<CR>", "References" },
    s = { "<Cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<Cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
    t = { "<Cmd>Telescope lsp_type_definitions<CR>", "Goto Type Definition" },
  }
  whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>", silent=true, noremap = true })
  whichkey.register(keymap_g, { buffer = bufnr, prefix = "g", silent = true, noremap = true })
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
end

return M
