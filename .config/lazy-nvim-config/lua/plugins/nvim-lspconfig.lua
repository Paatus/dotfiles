return {
  "neovim/nvim-lspconfig",
  init = function()
  local opts = { noremap = true, silent = true }
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "<F1>", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>' }
    -- disable a keymap
    -- keys[#keys + 1] = { "K", false }
    -- add a keymap
    -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    keys[#keys + 1] = { "<F1>", '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>' }
    keys[#keys + 1] = { "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts }
    keys[#keys + 1] = { "<leader>n", "<cmd>lua vim.lsp.buf.references()<CR>", opts }
    keys[#keys + 1] = { "<leader>e", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts }
    keys[#keys + 1] = { "<leader>t", "<cmd>:TroubleToggle<CR>", opts }
    keys[#keys + 1] = { "T", "<cmd>lua vim.lsp.buf.hover()<CR>", opts }
    keys[#keys + 1] = { "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts }
    keys[#keys + 1] = { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts }
  end,
  opts = {
    servers = {
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectories = { mode = "location" },
        },
      },
    },
  }
}
