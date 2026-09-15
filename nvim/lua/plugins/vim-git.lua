return {
  {
   "tpope/vim-git",

   init = function()
     vim.g.gitcommit_cleanup = "scissors"
   end,
  }
}
