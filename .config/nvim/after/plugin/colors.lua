-- Colorsheme set up.
require('rose-pine').setup({
    --- @usage 'main' | 'moon'
    dark_variant = 'main',
    dim_nc_background = true,
    disable_italics = true,

    highlight_groups = {
	MatchParen = { fg = 'love', bg = 'base' },
    }
})

-- Set colorscheme
vim.cmd "colorscheme rose-pine"
