vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.java",
  callback = function(args)
    local buf = args.buf
    local name = vim.api.nvim_buf_get_name(buf)

    -- only act on empty files
    if vim.api.nvim_buf_line_count(buf) ~= 1 then
      return
    end
    if vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] ~= "" then
      return
    end

    require("java.new_type").generate()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local ok, err = pcall(function()
      require("java.jdtls").setup()
    end)

    if not ok then
      print(err)
      vim.notify("JDTLS setup error:\n" .. err, vim.log.levels.ERROR)
    end
  end,
})

print("loaded java")

