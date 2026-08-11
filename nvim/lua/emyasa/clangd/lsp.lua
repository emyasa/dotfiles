local clangd_bin = "/usr/bin/clangd"

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP rename" })
vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.lsp.config("clangd", {
  cmd = { clangd_bin, "--background-index", "--clang-tidy" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = vim.fs.root(0, { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" }),
})
