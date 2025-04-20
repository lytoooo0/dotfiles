return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip", -- Snippet engine
        "saadparwaiz1/cmp_luasnip", -- Snippet completion
    },
    config = function()
        local cmp = require('cmp')

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For snippet support
                end,
            },
            mapping = {
                ['<C-n>'] = cmp.mapping.select_next_item(), -- Navigate to the next item
                ['<C-p>'] = cmp.mapping.select_prev_item(), -- Navigate to the previous item
                ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
                ['<C-e>'] = cmp.mapping.close(), -- Close completion
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
            },
            sources = {
                { name = 'nvim_lsp' }, -- LSP source
                { name = 'buffer' }, -- Buffer source
                { name = 'path' }, -- Path source
                { name = 'luasnip' }, -- Snippet source
            },
        })

        -- Setup for command line completion
        cmp.setup.cmdline(':', {
            sources = {
                { name = 'cmdline' }
            }
        })

        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' }
            }
        })
    end,
}
