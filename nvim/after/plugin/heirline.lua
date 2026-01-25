local conditions = require("heirline.conditions")

require("heirline").setup({
  statusline = {
    {
      provider = function()
        return vim.fn.expand("%:~:.")
      end,
    },

    { provider = " " }, -- spacing

    {
      condition = conditions.is_git_repo,
      provider = function()
        return " " .. (vim.b.gitsigns_head or "")
      end,
    },
  },
})

