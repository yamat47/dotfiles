local function find_root(bufnr, patterns)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then return nil end
  local dir = vim.fs.dirname(fname)
  while dir and dir ~= "" and dir ~= "/" do
    for _, p in ipairs(patterns) do
      if vim.uv.fs_stat(dir .. "/" .. p) then
        return dir
      end
    end
    local parent = vim.fs.dirname(dir)
    if parent == dir then break end
    dir = parent
  end
  return nil
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "eruby" },
  callback = function(args)
    local bufnr        = args.buf
    local capabilities = require("lsp.capabilities")

    -- local r1 = find_root(bufnr, { "bin/rails", "config/application.rb", "Gemfile" })
    -- if r1 then
    --   vim.lsp.start({
    --     name         = "ruby_lsp",
    --     cmd          = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
    --     root_dir     = r1,
    --     cmd_cwd      = r1,
    --     cmd_env      = { BUNDLE_GEMFILE = vim.fs.joinpath(r1, "Gemfile") },
    --     capabilities = capabilities,
    --   })
    -- end

    local r2 = find_root(bufnr, { ".rubocop.yml", "bin/rails", "config/application.rb", "Gemfile" })
    -- vim.system raises on a missing executable instead of reporting a code.
    if not r2 or vim.fn.executable("bundle") ~= 1 then return end

    local cmd_env = { BUNDLE_GEMFILE = vim.fs.joinpath(r2, "Gemfile") }

    -- Gems may live only inside a devcontainer, so the Gemfile alone proves
    -- nothing. Probe the real command asynchronously and start the LSP only
    -- when it can actually run here; otherwise bundle exec dies with 127.
    vim.system(
      { "bundle", "exec", "rubocop", "--version" },
      { cwd = r2, env = cmd_env },
      function(res)
        if res.code ~= 0 then return end
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(bufnr) then return end
          vim.lsp.start({
            name         = "rubocop",
            cmd          = { "bundle", "exec", "rubocop", "--lsp" },
            root_dir     = r2,
            cmd_cwd      = r2,
            cmd_env      = cmd_env,
            capabilities = capabilities,
            init_options = {
              safeAutocorrect = true,
              lintMode        = false,
              layoutMode      = false,
            },
          }, { bufnr = bufnr })
        end)
      end
    )
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "rubocop"
        and client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer   = args.buf,
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 2000, name = "rubocop" })
        end,
      })
    end
  end,
})
