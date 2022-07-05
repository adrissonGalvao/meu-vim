vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- lspconfig-scala
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP

  -- install metals
  use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim",  "mfussenegger/nvim-dap"}})

  -- install telescope
  use {'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' ,  { "nvim-telescope/telescope-live-grep-args.nvim" }} }

  use { 'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'} }

  use {'nvim-telescope/telescope-ui-select.nvim' }
end)

