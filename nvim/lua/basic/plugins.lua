local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

return require("packer").startup(function(use)
	if packer_bootstrap then
		require("packer").sync()
	end

	-- 包管理系统
	use({ "wbthomason/packer.nvim" })

	-- 主题
	use({
		"folke/tokyonight.nvim",
		config = function()
			require("conf.theme.init")
		end,
	})

	use({
		"EdenEast/nightfox.nvim",
		config = function()
			require("conf.theme.init")
		end,
	})

	-- 文件树
	use({
		"kyazdani42/nvim-tree.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("conf.plugins.nvim-tree")
		end,
	})

	-- buffer栏
	use({
		"akinsho/bufferline.nvim",
		requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" },
		config = function()
			require("conf.plugins.bufferline")
		end,
	})

	-- 底部状态栏
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("conf.plugins.lualine")
		end,
	})

	-- 状态栏LSP部件
	use({ "arkav/lualine-lsp-progress" })

	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("conf.plugins.telescope")
		end,
	})

	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("conf.plugins.project")
		end,
	})

	-- 启动页
	use({
		"glepnir/dashboard-nvim",
		config = function()
			require("conf.plugins.dashboard")
		end,
	})

	-- 代码高亮 增量选择 代码缩进
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("conf.plugins.treesitter")
		end,
	})

	-- LSP与DAP的安装
	use({ "williamboman/mason.nvim" })

	use({
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("conf.plugins.mason-tool-installer")
		end,
	})

	-- LSP配置以及美化
	use({ "neovim/nvim-lspconfig" })

	use({
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("conf.plugins.mason-lspconfig")
		end,
	})

	use({ "onsails/lspkind-nvim" })

	-- use {
	--   "glepnir/lspsaga.nvim",
	--   branch = "main",
	--   config = function()
	--     require("conf.lsp.ui.lspsaga")
	--   end
	-- }

	-- DAP配置
	use({ "theHamsta/nvim-dap-virtual-text" })

	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("conf.dap.ui.dap")
		end,
	})

	-- 代码格式化
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("conf.plugins.null-ls")
		end,
	})

	-- 代码补全
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("conf.plugins.cmp")
		end,
	})
	use({
		"hrsh7th/vim-vsnip", -- snippet 引擎
	})
	use({
		"hrsh7th/cmp-vsnip", -- 补全源
	})
	use({
		"hrsh7th/cmp-nvim-lsp", -- { name = nvim_lsp }
	})
	use({
		"hrsh7th/cmp-buffer", -- { name = 'buffer' }
	})
	use({
		"hrsh7th/cmp-path", -- { name = 'path' }
	})
	use({
		"hrsh7th/cmp-cmdline", -- { name = 'cmdline' }
	})
	use({
		"rafamadriz/friendly-snippets", -- 常见编程语言代码段
	})

	-- 文件线
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("conf.plugins.indent-blackline")
		end,
	})

	-- 自动括号补全
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("conf.plugins.autopairs")
			require("nvim-autopairs").setup({})
		end,
	})

	-- 代码注释
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("conf.plugins.comment")
		end,
	})

	use({
		"qujihan/asyncrun.vim",
		as = "asyncrun",
		config = function()
			require("asyncrun_toggleterm").setup({
				mapping = "<leader>tt",
				start_in_insert = false,
			})
		end,
	})

	use({
		"skywind3000/asynctasks.vim",
		config = function()
			require("conf.plugins.asynctasks")
		end,
	})

	-- buffers中集成git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("conf.plugins.gitsigns")
		end,
	})

	-- 浮动窗口
	use({
		"akinsho/toggleterm.nvim",
		tag = "v2.*",
		config = function()
			require("conf.plugins.toggleterm")
		end,
	})

	-- 快捷键设置
	use({
		"folke/which-key.nvim",
		config = function()
			require("conf.plugins.whichkey")
		end,
	})

	-- rust 增强
	use({ "simrat39/rust-tools.nvim" })
end)
