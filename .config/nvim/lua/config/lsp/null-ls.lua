local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    diagnostics.eslint_d,
    formatters.eslint_d,
    code_actions.eslint_d,
  },
  on_attach = function(client)
    local group = vim.api.nvim_create_augroup("Eslint", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = "",
      command = "EslintFixAll",
      desc = "Run eslint when saving buffer.",
    })
  end,
})
