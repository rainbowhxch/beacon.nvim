local M = {}

local conf_module = require('beacon.config')
local utils = require('beacon.utils')
local fader = require('beacon.fader')
local config = nil
local initialized = false

M.cursor_moved = function()
  fader.cursor_move()
end

M.highlight_position = function(is_force)
  fader.highlight_position(is_force)
end

M.clear_highlight = function()
  fader.clear_highlight()
end

M.beacon_on = function()
  fader.beacon_on()
end

M.beacon_off = function()
  fader.beacon_off()
end

M.beacon_toggle = function()
  fader.beacon_toggle()
end

M.setup = function(opts)
  if initialized then
    return
  end

  config = conf_module.merge_config(opts)
  fader.setup(config)
  utils.create_default_highlight_group()

  local ac = [[
        augroup BeaconHighlightMoves
            autocmd!
    ]]
  if config.show_jumps then
    ac = ac .. [[
                silent autocmd CursorMoved * lua require'beacon'.cursor_moved()
        ]]
  end
  if config.focus_gained then
    ac = ac .. [[
                silent autocmd FocusGained * lua require'beacon'.highlight_position(false)
        ]]
  end
  ac = ac
    .. [[
            silent autocmd WinEnter * lua vim.schedule(function() require'beacon'.highlight_position(false) end)
            silent autocmd CmdwinLeave * lua require'beacon'.clear_highlight()
        augroup end
    ]]
  vim.cmd(ac)
  vim.cmd([[
        command! Beacon lua require'beacon'.highlight_position(true)
        command! BeaconOn lua require'beacon'.beacon_on()
        command! BeaconOff lua require'beacon'.beacon_off()
        command! BeaconToggle lua require'beacon'.beacon_toggle()
    ]])
  initialized = true
end

return M
