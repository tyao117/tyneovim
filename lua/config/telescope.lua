local previewers = require "telescope.previewers"
local telescope = require "telescope"

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then
      return
    end
    if stat.size > 100000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

local M = {}

function M.setup()
  telescope.setup {
    defaults = {
      buffer_previewer_maker = new_maker,
    },
  }
  pcall(telescope.load_extension, 'fzf')
end

return M
