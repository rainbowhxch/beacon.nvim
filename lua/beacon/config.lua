local M = {}

local default_config = {
  enable = true,
  size = 40,
  fade = true,
  minimal_jump = 10,
  show_jumps = true,
  focus_gained = false,
  shrink = true,
  timeout = 500,
  ignore_buffers = {},
  ignore_filetypes = {},
}

M.merge_config = function(opts)
  opts = opts or {}
  return vim.tbl_deep_extend('force', default_config, opts)
end

return M
