local status_ok, fzfLua = pcall(require, "fzf-lua")
if not status_ok then
	return
end

local utils = require("fzf-lua").utils
local actions = require("fzf-lua").actions

local function hl_validate(hl)
  return not utils.is_hl_cleared(hl) and hl or nil
end

fzfLua.setup({
  desc             = "match telescope default highlights|keybinds",
  fzf_opts         = { ["--layout"] = "default", ["--marker"] = "+" },
  actions          = {
    files = {
      ["default"] = actions.file_edit_or_qf,
      ["ctrl-x"]  = actions.file_split,
      ["ctrl-v"]  = actions.file_vsplit,
    },
    buffers = {
      ["default"] = actions.buf_edit,
      ["ctrl-x"]  = actions.buf_split,
      ["ctrl-v"]  = actions.buf_vsplit,
      ["ctrl-t"]  = actions.buf_tabedit,
    }
  }
})
