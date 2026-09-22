return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      opts.servers.lua_ls = {
        cmd = { "lua-language-server" },
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
          },
        },
      }

      -- TypeScript: pick the server by the project's own TypeScript version.
      --   7+ : tsc (TypeScript 7's built-in LSP). nvim-lspconfig's tsc config
      --        only starts a tsc >= 7, from node_modules or $PATH; mise puts
      --        TypeScript 6 on $PATH, so this means "the project uses 7+".
      --   <7 : ts_ls, on the project's TypeScript or mise's TypeScript 6.
      -- TypeScript 7 rejects options older projects still use (baseUrl,
      -- target=ES5, moduleResolution=node), and ships no tsserver for ts_ls.
      opts.servers.tsc = {}

      local function project_ts_major(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name == "" then return nil end
        for dir in vim.fs.parents(name) do
          local pkg = vim.fs.joinpath(dir, "node_modules", "typescript", "package.json")
          if vim.uv.fs_stat(pkg) then
            local ok, data = pcall(vim.json.decode, table.concat(vim.fn.readfile(pkg), "\n"))
            return ok and tonumber(tostring(data.version):match("^(%d+)")) or nil
          end
        end
      end

      -- Defers to nvim-lspconfig's own ts_ls root detection (monorepo and Deno
      -- handling), which is a root_dir function or, in older versions, root_markers.
      local upstream
      local function ts_ls_root_dir(bufnr, on_dir)
        if (project_ts_major(bufnr) or 0) >= 7 then return end
        if not upstream then
          upstream = {}
          for _, f in ipairs(vim.api.nvim_get_runtime_file("lsp/ts_ls.lua", true)) do
            if f:find("nvim-lspconfig", 1, true) then
              upstream = dofile(f)
              break
            end
          end
        end
        if upstream.root_dir then
          return upstream.root_dir(bufnr, on_dir)
        end
        on_dir(vim.fs.root(bufnr, upstream.root_markers or { "package.json", ".git" }) or vim.fn.getcwd())
      end

      -- Used when the project has no node_modules/typescript of its own.
      -- mise installs tsc as <install>/node_modules/.bin/tsc.
      local tsc = vim.fn.exepath("tsc")
      local tsserver = tsc ~= ""
        and vim.fs.joinpath(vim.fs.dirname(vim.fs.dirname(tsc)), "typescript", "lib", "tsserver.js")
        or nil
      if tsserver and not vim.uv.fs_stat(tsserver) then tsserver = nil end

      local inlay_hints = {
        includeInlayParameterNameHints                        = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints                = true,
        includeInlayVariableTypeHints                         = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName      = false,
        includeInlayPropertyDeclarationTypeHints              = true,
        includeInlayFunctionLikeReturnTypeHints               = true,
        includeInlayEnumMemberValueHints                      = true,
      }

      opts.servers.ts_ls = {
        root_dir     = ts_ls_root_dir,
        init_options = { tsserver = { fallbackPath = tsserver } },
        settings = {
          typescript = { inlayHints = inlay_hints },
          javascript = { inlayHints = inlay_hints },
        },
      }
    end,
  },
}
