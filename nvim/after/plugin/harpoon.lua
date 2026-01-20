require('harpoon').setup()

vim.keymap.set('n', '<leader>h', require('harpoon.ui').toggle_quick_menu, {})
vim.keymap.set('n', '<leader>m', require('harpoon.mark').add_file, {})
vim.keymap.set('n', '<leader>n', require('harpoon.ui').nav_next, {})
vim.keymap.set('n', '<leader>N', require('harpoon.ui').nav_prev, {})

