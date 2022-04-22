local M = {}

M.create_default_highlight_group = function()
  vim.cmd([[highlight BeaconDefault guibg=white ctermbg=15]])
  vim.cmd([[
        if !hlexists("Beacon")
            hi! link Beacon BeaconDefault
        endif
    ]])
end

M.is_ignored_filetype = function(ignore_filetypes)
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  if ignore_filetypes[ft] then
    return true
  end
  return false
end

M.is_ignored_buffer = function(ignore_buffers)
  if
    vim.fn.getcmdwintype() ~= ''
    or vim.fn.getcmdline() ~= ''
    or vim.fn.getcmdtype() ~= ''
    or vim.fn.getcmdpos() > 0
  then
    return true
  end

  local buf_name = vim.fn.bufname()
  if buf_name == '[Comand Line]' then
    return true
  end
  if ignore_buffers[buf_name] then
    return true
  end
  return false
end

return M
