-- https://github.com/skywind3000/asynctasks.vim
vim.cmd([[
    let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
    let g:asynctasks_term_pos = 'toggleterm2'
    let g:asynctasks_term_reuse = 1 
    let g:asynctasks_term_close = 0 
]])
local map = require("basic.mapping").asynctask
