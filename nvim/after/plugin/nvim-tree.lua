-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- setup
vim.keymap.set("n", "<leader>w", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle nvim-tree" })
vim.keymap.set("n", "<leader>e", function() 
    local ft = vim.bo.filetype
    if ft == "NvimTree" then
        vim.cmd("wincmd p")
    else
        vim.cmd("NvimTreeFocus")
    end
end, { desc = "Toggle Focus nvim-tree" })

local function create_and_edit()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    api.fs.create(node)  -- create the file
    -- schedule opening it to make sure the file exists
    vim.schedule(function()
        -- jump to the newly created file
        api.node.open.edit()
        -- optional: go directly into insert mode
        vim.cmd("startinsert")
    end)
end

local function nvim_tree_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- apply all default mappings first
  api.config.mappings.default_on_attach(bufnr)

  -- remove default `a` binding (create)
  vim.keymap.del("n", "a", { buffer = bufnr })
  vim.keymap.del("n", "d", { buffer = bufnr })
  vim.keymap.del("n", "r", { buffer = bufnr })

  -- bind `%` to the same create action (`fs.create`)
  vim.keymap.set("n", "%", create_and_edit, opts("Create File/Directory"))
  vim.keymap.set("n", "N", api.fs.create, opts("Create File/Directory"))
  vim.keymap.set("n", "D", api.fs.remove, opts("Delete File/Directory"))
  vim.keymap.set("n", "R", api.fs.rename_full, opts("Rename: Full Path"))
end

require("nvim-tree").setup({
    on_attach = nvim_tree_on_attach,
    notify = {
        threshold = vim.log.levels.ERROR,
    },
})

-- Flatten empty directories in nvim-tree
local function flatten_node(node)
    if not node.children or #node.children == 0 then
        return
    end

    while #node.children == 1 and node.children[1].type == "directory" do
        local child = node.children[1]
        node.name = node.name .. "/" .. child.name
        node.children = child.children or {}
    end

    for _, child in ipairs(node.children) do
        flatten_node(child)
    end
end

-- Hook into nvim-tree render
vim.api.nvim_create_autocmd("User", {
    pattern = "NvimTreeRefresh",
    callback = function()
        local lib = require("nvim-tree.lib")
        local view = lib.get_tree()
        if view and view.root and view.root.children then
            for _, node in ipairs(view.root.children) do
                flatten_node(node)
            end
        end
    end,
})



