return {
  {
    "ibhagwan/fzf-lua",

    cmd = "FzfLua",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    keys = {
      { "<leader>ff", "<cmd>FzfLua files<cr>",                      desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<cr>",                  desc = "Live grep (rg)" },
      { "<leader>fb", "<cmd>FzfLua buffers<cr>",                    desc = "Buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<cr>",                  desc = "Help tags" },
      { "<leader>fc", "<cmd>FzfLua git_commits<cr>",                desc = "Git commits" },
      { "<leader>fs", "<cmd>FzfLua git_status<cr>",                 desc = "Git status" },
      { "<leader>ft", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", desc = "LSP symbols" },
      { "<leader>fr", "<cmd>FzfLua resume<cr>",                     desc = "Resume last picker" },
    },

    opts = {
      winopts = {
        height  = 0.85,
        width   = 0.80,
        row     = 0.30,
        col     = 0.50,
        border  = "rounded",
        preview = { layout = "vertical" },
      },

      fzf_opts = {
        ["--ansi"]   = "",
        ["--prompt"] = "  ",
        ["--info"]   = "inline",
        ["--layout"] = "reverse",
      },

      files = {
        prompt  = "Files❯ ",
        git_icons = true,
        fd_opts = "--color=never --type f --follow --hidden --exclude .git",
      },

      grep = {
        prompt  = "Rg❯ ",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case -e",
      },

      lsp = {
        async   = true,
        symbols = {
          "method", "function", "constructor",
          "field",  "variable",
          "class",  "interface", "module",
        },
      },
    },
  },
}
