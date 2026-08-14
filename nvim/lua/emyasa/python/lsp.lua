local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver"

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "rn", vim.lsp.buf.rename, { desc = "LSP rename"})
vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { desc = "Code Action" })

vim.lsp.config("pyright", {
    cmd = { mason_bin, "--stdio" },
    filetypes = {"python"},
    settings = {
        python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportInvalidTypeForm = "none",
                },
            },
        },
    },
})
