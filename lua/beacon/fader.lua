local utils = require('beacon.utils')
local M = {}

local fake_buf = vim.api.nvim_create_buf(false, true)
local float_id = 0
local fade_timer = 0
local close_timer = 0
local config = nil
local ignore_buffers_set = {}
local ignore_filetypes_set = {}

M.setup = function(opts)
    config = opts
    for _, ignore_buffer in ipairs(config.ignore_buffers) do
        ignore_buffers_set[ignore_buffer] = true
    end
    for _, ignore_filetype in ipairs(config.ignore_filetypes) do
        ignore_filetypes_set[ignore_filetype] = true
    end
end

M.clear_highlight = function()
    if fade_timer > 0 then
        vim.fn.timer_stop(fade_timer)
    end

    if close_timer > 0 then
        vim.fn.timer_stop(close_timer)
    end

    if float_id > 0 and vim.api.nvim_win_is_valid(float_id) then
        vim.api.nvim_win_close(float_id, false)
        float_id = 0
    end
end

M.fade_window = function()
    if float_id > 0 and vim.api.nvim_win_is_valid(float_id) then
        local old_winbl =  vim.api.nvim_win_get_option(float_id, 'winblend')
        local old_cols = nil
        local speed = nil
        if config.shrink then
            old_cols = vim.api.nvim_win_get_width(float_id)
        else
            old_cols = 40
        end

        if old_winbl > 90 then
            speed = 3
        elseif old_winbl > 80 then
            speed = 2
        else
            speed = 1
        end

        if old_winbl == 100 or old_cols == 10 then
            M.clear_highlight()
            return
        end
        vim.api.nvim_win_set_option(float_id, 'winblend', old_winbl + speed)
        if config.shrink then
            vim.api.nvim_win_set_width(float_id, old_cols - speed)
        end
    end
end

M.highlight_position = function(is_force)
    if config.enable == false and is_force == false then
        return
    end
    if utils.is_ignored_filetype(ignore_filetypes_set) then
        return
    end
    if utils.is_ignored_buffer(ignore_buffers_set) then
        return
    end

    if float_id > 0 then
        M.clear_highlight()
    end

    local win_config = vim.api.nvim_win_get_config(0)
    if win_config.relative and win_config.relative ~= '' then
        return
    end

    local cursor_position = vim.api.nvim_win_get_cursor(0)
    cursor_position[1] = cursor_position[1] - 1
    local opts = {
        relative ='win',
        width = config.size,
        height = 1,
        bufpos = cursor_position,
        col = 0,
        row = 0,
        anchor = 'NW',
        style = 'minimal',
        focusable = false,
    }
    float_id = vim.api.nvim_open_win(fake_buf, false, opts)
    vim.api.nvim_win_set_option(float_id, 'winhl', 'Normal:Beacon')
    vim.api.nvim_win_set_option(float_id, 'winblend', 70)

    if config.fade then
        fade_timer = vim.fn.timer_start(16, M.fade_window, {['repeat'] = -1})
    end
        close_timer = vim.fn.timer_start(config.timeout, M.clear_highlight, {['repeat'] = 1})
end

local prev_cursor = 0
local prev_abs = 0

M.cursor_move = function()
    local cur_cursor = vim.fn.winline()
    local cur_abs = vim.fn.line('.')
    local diff = math.abs(cur_cursor - prev_cursor)
    local abs_diff = math.abs(cur_abs - prev_abs)
    if diff >= config.minimal_jump and abs_diff >= config.minimal_jump then
        M.highlight_position(false)
    end
    prev_cursor = cur_cursor
    prev_abs = cur_abs
end

M.beacon_toggle = function()
    if config.enable == false then
        config.enable = true
    else
        config.enable = false
    end
end

return M
