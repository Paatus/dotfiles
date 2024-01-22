-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--

function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local eslint_filetypes = Set {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact"
}

local group = vim.api.nvim_create_augroup("eslint_d", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "",
  callback = function (opts)
    local filetype = vim.bo[opts.buf].filetype
    if eslint_filetypes[filetype] then
      vim.cmd('EslintFixAll')
    end
  end,
  desc = "Run eslint when saving buffer.",
})
