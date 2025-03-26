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

vim.api.nvim_create_autocmd("BufWritePre", {
  -- This autocommand will only trigger if the buffer name matches the following patterns
  pattern = { "*.elm" },
  -- The autocommand will trigger the following lua function
  callback = function()
    vim.lsp.buf.format()
  end
})

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

-- put this in your init.lua
vim.api.nvim_create_autocmd(
    {"BufEnter", "BufWinEnter"},
    {
        pattern = {"*.yuck"},
        callback = function(event)
            vim.lsp.start {
                name = "YuckLs",
                -- cmd = {"dotnet", "/home/gitrepos/yuckls/YuckLS/dist/YuckLS.dll"}, --this must be where you cloned this repo to.
                cmd = {"yuckls"}, -- if installed from aur
                root_dir = vim.fn.getcwd()
            }
        end
    }
)
