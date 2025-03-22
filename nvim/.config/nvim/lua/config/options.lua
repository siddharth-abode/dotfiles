vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

vim.opt.number = true
vim.cmd([[
set cursorline
set cursorlineopt=number
autocmd ColorScheme * highlight CursorLineNr cterm=bold term=bold gui=bold
]])                -- Highlights line number
