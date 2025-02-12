local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

keymap("n", "<Space>", "<Nop>", {})
-- keymap('n', "<SPACE>", "<Nop>", {})
-- keymap("", "<Space>", "<Nop>", { noremap = true, silent = false })
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Move between splits with Ctrl-[H,J,K,L]
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Move between splits with Ctrl-[UP,DOWN,LEFT,RIGHT]
keymap("n", "<C-Right>", "<C-w>l", opts)
keymap("n", "<C-Left>", "<C-w>h", opts)
keymap("n", "<C-Up>", "<C-w>k", opts)
keymap("n", "<C-Down>", "<C-w>j", opts)

keymap("n", '<leader>s', ":source ~/.config/nvim/init.lua<CR>", opts)
keymap("n", '<leader><leader>', ":lua require('fzf-lua').git_files({ cmd = 'git ls-files --cached --other --exclude-standard' })<CR>", { noremap = true, silent = true })
keymap("n", '<Leader>b', ":FzfLua buffers<CR>", opts)

-- Toggle File menu with F3
keymap("n", "<F3>", ":NvimTreeFindFileToggle<CR>", opts)

-- Open silver-searcher with backspace
keymap("n", "\\", ":Ag ", opts)

-- Move between open buffers with Tab/Shift-tab
-- keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
-- keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

-- Repeats visual selection after indent/dedent
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- not sure
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

keymap("v", "p", '"_dP', opts)
