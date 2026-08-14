require("emyasa.clang.lsp")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    vim.lsp.start(vim.lsp.config.clangd)
  end,
})
