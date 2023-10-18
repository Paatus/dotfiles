local status_ok, lualine = pcall(require, "lualine")
local status_ok_bufferline, bufferline = pcall(require, "bufferline")
if not status_ok_bufferline then
  return
end
if not status_ok then
  return
end

vim.opt.termguicolors = true
bufferline.setup({
  options = {
    name_formatter = function(buf) 
      -- buf contains:
      -- name                | str        | the basename of the active file
      -- path                | str        | the full path of the active file
      -- bufnr (buffer only) | int        | the number of the active buffer
      -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
      -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
      local ret = ""
      local path = string.gsub(buf.path, buf.name, "")
      local parts = {}
      for i in string.gmatch(path, "[^/]+") do
          parts[#parts + 1] = i
      end
      for i = #parts-1, #parts do
          local part = parts[i]
          ret = ret .. string.sub(part, 1, 1) .. '/'
      end
      return ret .. buf.name
    end,
    diagnostics = "nvim_lsp",
  }
})

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "packer", "NvimTree", "NvimTree_1" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = { "diff", "diagnostics" },
    lualine_x = { "filetype" },
    lualine_y = { "branch" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = nil,
  extensions = { "nvim-tree" },
})
