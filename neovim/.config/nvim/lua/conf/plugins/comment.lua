-- https://github.com/numToStr/Comment.nvim
local status, Comment = pcall(require, "Comment")
if not status then
    vim.notify("没有找到 Comment")
    return
end

Comment.setup({

})
