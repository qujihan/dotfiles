local status, mason_tool = pcall(require, "mason-tool-installer")
if not status then
    vim.notify("没有找到 mason-tool-installer")
    return
end

mason_tool.setup {
    ensure_installed = {
        -- LSP
        'clangd', -- cpp
        'gopls', -- golang
        'jdtls', -- java
        'lua-language-server', --lua
        'rust-analyzer', -- rust
        'pyright', -- python
        'cmake-language-server', -- cmake


        -- DAP
        'codelldb', -- c/cpp/rust
        'debugpy', -- python
        'delve', -- go

        -- Linter

        -- Formatter
        'clang-format',
        'stylua',
        'shfmt', -- shell
    },

    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = false,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = true,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay
}
