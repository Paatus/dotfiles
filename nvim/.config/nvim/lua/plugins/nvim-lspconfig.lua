return {
  "neovim/nvim-lspconfig",
  dependencies = { "nvim-lua/plenary.nvim" },
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
      tailwindcss = {
        filetypes_include = { "elm" }
      },
      eslint = {
        settings = {
          -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
          workingDirectories = { mode = "location" },
        },
      },
    },
    setup = {
      tailwindcss = function(_, opts)
        -- local tw = LazyVim.lsp.get_raw_config("tailwindcss")
        opts.filetypes = opts.filetypes or {}

        -- Add default filetypes
        -- vim.list_extend(opts.filetypes, tw.default_config.filetypes)

        -- Remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)

        -- Additional settings for Phoenix projects
        opts.settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "classList" },
            includeLanguages = {
              elm = "html",
            },
            experimental = {
              classRegex = {
                "\\bclass[\\s(<|]+\"([^\"]*)\"",
                "\\bclass[\\s(]+\"[^\"]*\"[\\s+]+\"([^\"]*)\"",
                "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
                "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
                "\\bclass[\\s<|]+\"[^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" [^\"]*\"\\s*\\+{2}\\s*\" ([^\"]*)\"",
                "\\bclassList[\\s\\[\\(]+\"([^\"]*)\"",
                "\\bclassList[\\s\\[\\(]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"([^\"]*)\"",
                "\\bclassList[\\s\\[\\(]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"[^\"]*\",\\s[^\\)]+\\)[\\s\\[\\(,]+\"([^\"]*)\""
              }
            },
          },
        }

        -- Add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
    },
  },
}
