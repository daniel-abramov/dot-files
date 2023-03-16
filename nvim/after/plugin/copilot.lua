-- Copilot set up
-- We're disabling the default use of `Tab`, so that Copilot runs automatically each time we type.
-- This is a bit of a hack, but it works. And we're also using the right arrow to complete.
-- let g:copilot_no_tab_map = v:true
vim.cmd([[
  imap <silent><script><expr> <c-j> copilot#Accept("\<CR>")
]])
vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])
