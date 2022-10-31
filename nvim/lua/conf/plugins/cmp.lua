-- https://github.com/hrsh7th/nvim-cmp
local status, cmp = pcall(require, "cmp")
if not status then
  vim.notify("没有找到 cmp")
  return
end

cmp.setup({
  -- 指定 snippet 引擎
  snippet = {
    expand = function(args)
      -- For `vsnip` users.
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- 补全源
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    -- For vsnip users.
    { name = "vsnip" },
  },
    {
      { name = "buffer" },
      { name = "path" }
    }),

  -- 快捷键设置
  mapping = require("basic.mapping").cmp(cmp),
  formatting = require('conf.lsp.ui.lspkind').formatting
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
