return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",

    opts = { servers = {} },

    config = function(_, opts)
      local capabilities = require("lsp.capabilities")
      local on_attach    = require("lsp.on_attach")

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          on_attach(vim.lsp.get_client_by_id(args.data.client_id), args.buf)
        end,
      })

      for name, cfg in pairs(opts.servers) do
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
      end
    end,
  },
}
