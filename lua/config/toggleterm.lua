local M = {}

function M.setup()
  require("toggleterm").setup {
    function(term)
      if term.direction == "float" then
        return 30
      elseif term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    start_in_insert = true,
    direction = "float"
  }
end

return M
