-- https://github.com/williamboman/mason-lspconfig.nvim
local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("没有找到 mason-lspconfig")
  return
end

-- https://github.com/williamboman/mason.nvim
local status, mason = pcall(require, "mason")
if not status then
  vim.notify("没有找到 mason")
  return
end

-- https://github.com/neovim/nvim-lspconfig
local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("没有找到 lspconfig")
  return
end

require("conf.lsp.ui.ui")


mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
mason_lspconfig.setup {}

local default_config = {
  on_attach = function(client, bufnr)
    -- 禁用格式化功能，交给专门插件插件处理
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- 绑定快捷键
    require('basic.mapping').lsp(buf_set_keymap)
    -- 保存时自动格式化
    -- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end,
}

local servers = {
  clangd = require("conf.lsp.lang.clangd"), -- cpp
  gopls = default_config, -- golang
  jdtls = default_config, -- java
  sumneko_lua = default_config, --lua
  rust_analyzer = default_config, -- rust
  pyright = default_config, -- python
}

for name, config in pairs(servers) do
  lspconfig[name].setup(config)
end
