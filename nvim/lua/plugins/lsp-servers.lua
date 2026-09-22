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

      -- TypeScript: the project's own TypeScript picks the server. 7+ gets tsc
      -- (TypeScript 7's built-in LSP); older gets ts_ls, since 7 has no tsserver
      -- and rejects tsconfig options they still use (baseUrl, target=ES5, ...).
      local function project_ts_major(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        local pkg = vim.fs.find("node_modules/typescript/package.json", {
          upward = true, path = vim.fs.dirname(name),
        })[1]
        if not pkg then return nil end
        local ok, data = pcall(vim.json.decode, vim.fn.readblob(pkg))
        local version = ok and vim.version.parse(data.version or "")
        return version and version.major or nil
      end

      -- nvim-lspconfig's config for `name`, attaching only when `wanted`. cmd is
      -- taken along with root_dir: tsc's root_dir hands the binary it found to
      -- its cmd through a file-local cache, which a re-resolved config wouldn't share.
      local function gated(name, wanted)
        local upstream = vim.lsp.config[name]
        return {
          cmd      = upstream.cmd,
          root_dir = function(bufnr, on_dir)
            if wanted(project_ts_major(bufnr) or 0) then
              upstream.root_dir(bufnr, on_dir)
            end
          end,
        }
      end

      opts.servers.tsc = gated("tsc", function(major) return major >= 7 end)

      -- For projects without their own TypeScript: mise's (mise/config.toml).
      local tsserver
      if vim.fn.executable("mise") == 1 then
        local out = vim.system({ "mise", "where", "npm:typescript" }, { text = true }):wait()
        local path = vim.fs.joinpath(vim.trim(out.stdout or ""), "node_modules", "typescript", "lib", "tsserver.js")
        if out.code == 0 and vim.uv.fs_stat(path) then tsserver = path end
      end

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

      opts.servers.ts_ls = vim.tbl_extend("force", gated("ts_ls", function(major) return major < 7 end), {
        init_options = { tsserver = { fallbackPath = tsserver } },
        settings = {
          typescript = { inlayHints = inlay_hints },
          javascript = { inlayHints = inlay_hints },
        },
      })
    end,
  },
}
