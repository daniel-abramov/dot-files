-- nvim-tree confiugration
vim.g.loaded_netrw = 1 -- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle)

-- Focus the current buffer in a nvim-tree iff the nvim-tree is active
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.fn.exists(':NvimTreeFindFile') == 2 then
            if require 'nvim-tree.view'.is_visible() then
                local current_file_path = vim.fn.expand("%:p")
                require 'nvim-tree.api'.tree.find_file(current_file_path)
            end
        end
    end
})
