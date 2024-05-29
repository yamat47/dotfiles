vim.opt.whichwrap = "b,s,h,l,>,[,]"
vim.opt.matchpairs = "(:),{:},[:],<:>"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.wildmenu = true
vim.opt.incsearch = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.backspace = "start,eol,indent"
vim.opt.list = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.ambiwidth = "double"
vim.opt.termguicolors = true

vim.api.nvim_set_keymap("n", "<ESC><ESC>", ":nohlsearch <CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n><C-n>", ":set invnumber<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w><C-w>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-w><C-f>", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-g>", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_create_user_command("Pbcopy", ":%w !pbcopy", {})

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins via lazy.nvim
require("lazy").setup({
  "vim-ruby/vim-ruby",
  "tpope/vim-rails",
  "slim-template/vim-slim",
  "tpope/vim-haml",
  "bfontaine/Brewfile.vim",
  "thinca/vim-zenspace",
  "tpope/vim-commentary",
  "github/copilot.vim",

  {
    "sainnhe/sonokai",
    lazy = false,
    config = function()
      vim.cmd([[colorscheme sonokai]])
    end
  },

  {
    "tpope/vim-git",
    init = function()
      vim.g.gitcommit_cleanup = "scissors"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  }
})
