require("emyasa.python.lsp")

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python"},
    callback = function()
        vim.lsp.start(vim.lsp.config.pyright)
    end,
})
