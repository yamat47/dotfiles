local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n", "v" }, "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "x", '"_x', opts)
map("n", "<leader>w", "<cmd>w<cr>", opts)
map("n", "<leader>q", "<cmd>confirm q<cr>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<leader>tn", "<cmd>tabnew<cr>", opts)

local function yank_github_range()
  local relpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  local start_line = vim.fn.getpos("v")[2]
  local end_line = vim.fn.getpos(".")[2]
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local range = "#L" .. start_line
  if end_line ~= start_line then
    range = range .. "-L" .. end_line
  end

  local text = relpath .. range
  vim.fn.setreg("+", text)
  print("Yanked: " .. text)

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
    "n",
    true
  )
end

vim.keymap.set("x", "gy", yank_github_range, { silent = true })
