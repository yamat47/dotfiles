local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if ok then
  return cmp_nvim_lsp.default_capabilities()
else
  return vim.lsp.protocol.make_client_capabilities()
end
