lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  indentation = {
    enable = true,
    disable = { "vim" },
  },
  folding = {
    enable = true,
    disable = { "vim" },
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "vim" },
  },
}
EOF
