local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-telescope/telescope.nvim" },
	{ "chrisgrieser/nvim-spider",               lazy = true },
	{ "stevearc/conform.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "gbrlsnchs/telescope-lsp-handlers.nvim" },
	{ "FabianWirth/search.nvim" },
	{ "rcarriga/nvim-notify" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "hrsh7th/nvim-cmp" },
	{ "onsails/lspkind.nvim" },
	{ "scalameta/nvim-metals" },
	{ "nvim-lua/plenary.nvim" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "marko-cerovac/material.nvim" },
	{ "mfussenegger/nvim-dap" },
	{ "adrissonGalvao/nvim-web-devicons" },
	{ "kyazdani42/nvim-tree.lua" },
	{ "j-hui/fidget.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	}
})

require("base")
require("misc")
require("telescope-config")
require("treesitter-config")
require("completion-config")
require("scala-config")
require("tree")
require("fidget-config")
require("theme-config")
require("statusline")
