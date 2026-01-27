local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/gopls"

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

