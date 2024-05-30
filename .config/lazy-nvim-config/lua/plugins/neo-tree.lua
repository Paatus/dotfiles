return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
  opts = {
    window = {
      mappings = {
        ["<C-v>"] = "open_vsplit",
        ["<C-x>"] = "open_split",
      }
    }
  }
}
