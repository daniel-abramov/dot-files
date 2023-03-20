-- See https://github.com/VonHeikemen/lsp-zero.nvim/blob/v1.x/doc/md/lsp.md#default-keybindings
-- for the list of the available bindings that are enabled by default.
local lsp = require("lsp-zero").preset("recommended")

lsp.ensure_installed({
  'gopls',
  'rust_analyzer',
  'lua_ls',
})

-- Set up statusline for the LSP
require('fidget').setup()

-- Set up Lua completion and other stuff
require('neodev').setup()

lsp.on_attach(function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<C-s>', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- When the cursor is placed on a variable or a function, the other references of it are highlighted.
  if client.server_capabilities.documentHighlightProvider then
    local highlight_name = vim.fn.printf("lsp_document_highlight_%d", bufnr)
    vim.api.nvim_create_augroup(highlight_name, {})
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = highlight_name,
      buffer = bufnr,
      callback = function() vim.lsp.buf.document_highlight() end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = highlight_name,
      buffer = bufnr,
      callback = function() vim.lsp.buf.clear_references() end,
    })
  end

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end)

lsp.setup_nvim_cmp({
  preselect = 'none',
  completion = {
    completeopt = 'menu,menuone',
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
    { name = 'path', keyword_length = 2 },
  },
})

lsp.setup()


-- Add virtual text when displaying errors and stuff
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
})

-- Format go on save
local go_auto_format = vim.api.nvim_create_augroup('GoAutoFormat', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
  group = go_auto_format,
  pattern = '*.go',
})
