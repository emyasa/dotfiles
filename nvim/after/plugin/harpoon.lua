require('harpoon').setup()
require('telescope').load_extension('harpoon')

vim.keymap.set('n', '<leader>h', ':Telescope harpoon marks <CR>', {})
vim.keymap.set('n', '<leader>m', require('harpoon.mark').add_file, {})
vim.keymap.set('n', '<leader>n', require('harpoon.ui').nav_next, {})
vim.keymap.set('n', '<leader>p', require('harpoon.ui').nav_prev, {})

