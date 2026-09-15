local aug = vim.api.nvim_create_augroup
local auc = vim.api.nvim_create_autocmd

aug("FileTypeSpecific", { clear = true })
auc("FileType", {
  group = "FileTypeSpecific",
  pattern = { "gitcommit", "markdown" },
  callback = function() vim.opt_local.wrap = true end,
})

auc("FileType", {
  group = "FileTypeSpecific",
  pattern = "gitrebase",
  callback = function()
    vim.keymap.set("n", "p", "ddkP", { buffer = true })
  end,
})

auc({ "FocusGained", "BufEnter" }, {
  callback = function()
    if vim.fn.getcmdwintype() == "" then vim.cmd.checktime() end
  end,
})

auc("BufWritePre", {
  group = aug("LspFormat", { clear = true }),
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
  end,
})

-- Set .jb files to be treated as Ruby files
aug("JbFiletype", { clear = true })
auc({ "BufRead", "BufNewFile" }, {
  group = "JbFiletype",
  pattern = "*.jb",
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})
