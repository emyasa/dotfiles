local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/gopls"

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP rename"})

vim.lsp.config("gopls", {
  cmd = { mason_bin },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),

  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

