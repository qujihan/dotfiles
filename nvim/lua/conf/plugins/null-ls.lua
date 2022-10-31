-- https://github.com/jose-elias-alvarez/null-ls.nvim
local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    -- Formatting ---------------------
    formatting.clang_format,
    formatting.shfmt,
    formatting.stylua,
  },

  -- null-ls offset_encoding default is utf-16
  -- on_init = function(new_client, _)
  --   new_client.offset_encoding = 'utf-16'
  -- end,


  -- 保存自动格式化
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
