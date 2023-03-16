-- nvim-tree confiugration
vim.g.loaded_netrw = 1 -- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle)
