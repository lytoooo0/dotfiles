local M = {}

function M.insert(opts)
    local left = opts.left
    local right = opts.right
    local move = opts.move or '<Left>'

    return function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local line = vim.api.nvim_get_current_line()
        local next_char = line:sub(col + 1, col + 1)

        if next_char == right then
            return '<Right>'
        end
        return left .. right .. move
    end
end

function M.bind(trigger, opts, extra)
    local key_opts = vim.tbl_extend('force', {
        expr = true,
        noremap = true,
        silent = true,
        buffer = true,
    }, extra or {})
    vim.keymap.set('i', trigger, M.insert(opts), key_opts)
end

return M
