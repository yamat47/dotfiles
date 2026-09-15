return {
  {
    "loctvl842/monokai-pro.nvim",

    lazy = false,

    opts = {
      filter = "octagon",
      transparent_background = true,
      terminal_colors = true,
      devicons = true,
    },

    config = function()
      vim.cmd([[colorscheme monokai-pro]])
    end
  }
}
