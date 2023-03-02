local M = {}

local whichkey = require "which-key"

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymap()
  local keymap_f = nil

  keymap_f = {
    name = "Find",
      f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
      d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
      b = { "<cmd>lua require('telescope.builtin').buffers()<cr>", "Buffers" },
      h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
      m = { "<cmd>lua require('telescope.builtin').marks()<cr>", "Marks" },
      o = { "<cmd>lua require('telescope.builtin').oldfiles()<cr>", "Old Files" },
      g = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Live Grep" },
      c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
      r = { "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", "File Browser" },
      w = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Current Buffer" },
      e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  }

  local keymap = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    f = keymap_f,

    ["j"] = { "<cmd>lua require( 'grapple' ).select { key = '{name}' }<CR>", "Grapple Select"},
    ["J"] = { "<cmd>lua require( 'grapple' ).toggle { key = '{name}' }<CR>", "Grapple Toggle"},
  }
  whichkey.register(keymap, opts)
end

local function visual_keymap()
  local keymap = {
    r = {
      name = "Refactor",
      r = { [[ <Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], "Refactor" },
    }
  }
  whichkey.register(keymap, v_opts)
end

function M.setup()
  normal_keymap()
  visual_keymap()
end

return M
