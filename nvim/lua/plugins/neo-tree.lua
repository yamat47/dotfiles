return {
  {
    "nvim-neo-tree/neo-tree.nvim",

    branch = "v3.x",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },

    lazy = false,

    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" }
    },

    opts = {
      filesystem = { filtered_items = { visible = true } },
      window     = { position = "left", width = 34 },
    },
  }
}
