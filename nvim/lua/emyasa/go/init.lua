require("emyasa.go.lsp")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function()
    vim.lsp.start(vim.lsp.config.gopls)
  end,
})

