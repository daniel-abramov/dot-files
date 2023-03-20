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


-- Main colorscheme: gruvbox
vim.g.gruvbox_italic_keywords = false
vim.g.gruvbox_flat_style = "hard"
vim.cmd "colorscheme gruvbox-flat"

-- Secondary colorscheme: rose-pine
-- vim.cmd "colorscheme rose-pine"

-- Experimental colorscheme: everforest
-- vim.cmd [[
--     let g:everforest_background = 'hard'
--     colorscheme everforest
-- ]]
