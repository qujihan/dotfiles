vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local opt = {
	noremap = true,
	silent = true,
}
local pluginKeys = {}

-- 常规快捷键
map("i", "jj", "<ESC>", opt)
map("n", "qq", ":q!<cr>", opt)

-- 分屏的快捷键
map("n", "<leader>sv", ":vsp<CR>", opt) -- 左右分屏
map("n", "<leader>sh", ":sp<CR>", opt) --上下分屏
map("n", "<leader>sc", "<C-w>c", opt) -- 关闭当前
map("n", "<leader>so", "<C-w>o", opt) -- 关闭其他
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- 调整比例
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 等比例
map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "<leader>t", ":sp | terminal<CR>", opt)
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
map("t", "<esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
-- 在visual 模式里粘贴不要复制
map("v", "p", '"_dP', opt)
-- insert 模式下，跳到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)

-- nvim-tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
pluginKeys.nvim_tree = {
	{
		key = { "<CR>", "o", "<2-LeftMouse>" },
		action = "edit",
	}, -- 分屏打开文件
	{
		key = "v",
		action = "vsplit",
	},
	{
		key = "h",
		action = "split",
	}, -- 显示隐藏文件
	{
		key = "i",
		action = "toggle_custom",
	}, -- 对应 filters 中的 custom (node_modules)
	{
		key = ".",
		action = "toggle_dotfiles",
	}, -- Hide (dotfiles)
	-- 文件操作
	{
		key = "<F5>",
		action = "refresh",
	},
	{
		key = "a",
		action = "create",
	},
	{
		key = "d",
		action = "remove",
	},
	{
		key = "r",
		action = "rename",
	},
	{
		key = "x",
		action = "cut",
	},
	{
		key = "c",
		action = "copy",
	},
	{
		key = "p",
		action = "paste",
	},
	{
		key = "s",
		action = "system_open",
	},
}

-- Telescope
map("n", "<C-p>", ":Telescope find_files<CR>", opt) -- 查找文件
map("n", "<C-f>", ":Telescope live_grep<CR>", opt) -- 全局搜索
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<C-n>"] = "move_selection_next",
		["<C-p>"] = "move_selection_previous",
		-- 历史记录
		["<Down>"] = "cycle_history_next",
		["<Up>"] = "cycle_history_prev",
		-- 关闭窗口
		-- ["<esc>"] = actions.close,
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
map("n", "<C-w>", ":Bdelete!<CR>", opt) -- "moll/vim-bbye"
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)

-- cmp
pluginKeys.cmp = function(cmp)
	return {
		-- 出现补全
		["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<A-,>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	}
end

-- lsp 回调函数快捷键设置
pluginKeys.lsp = function(mapbuf)
	mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
	-- rename
	mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
	-- code action
	mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
	-- go xx
	mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
	mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
	-- diagnostic
	mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
	mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
	mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
end

-- asynctasks
pluginKeys.asynctasks = {
	map("n", "<leader>rr", "<cmd> AsyncTask file-run <cr> ", opt),
	map("n", "<leader>bb", "<cmd> AsyncTask file-build <cr>", opt),
	map("n", "<leader>pr", "<cmd> AsyncTask project-build <cr>", opt),
	map("n", "<leader>pb", "<cmd> AsyncTask project-run <cr>", opt),
}
return pluginKeys
