-- https://github.com/folke/which-key.nvim
local status, whichkey = pcall(require, "which-key")
if not status then
    vim.notify("没有找到 which-key")
    return
end

whichkey.setup({

})
