return {
  -- add gruvbox
  { "tiagovla/tokyodark.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyodark",
    },
  }
}
