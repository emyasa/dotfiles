
require('lualine').setup({
    sections = {
        lualine_a = { {"mode", separator = { right = "", left = "" }} },
        lualine_b = { {"branch", separator = { right = "", left = "" }} },
        lualine_c = {
            { "filename", path = 1 },
        },

        lualine_x = {},
        lualine_y = {},
        lualine_z = {
            {
                "diff", separator = {right = "", left = ""},
                color = { bg = "#3c1f1f" },
                symbols = { added = "+", modified = "~", removed = "-" },
                source = function()
                    local gs = vim.b.gitsigns_status_dict
                    if gs then
                        return {
                            added    = gs.added,
                            modified = gs.changed,
                            removed  = gs.removed,
                        }
                    end
                end,
            },
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn" },
                symbols = {
                    error = "E:",
                    warn  = "W:",
                },
                diagnostics_color = {
                    error = "DiagnosticError",
                    warn  = "DiagnosticWarn",
                },
            },
        },
    },
})

