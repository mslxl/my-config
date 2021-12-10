local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


return require('packer').startup(function()
  -- Manage packer itself
  use 'wbthomason/packer.nvim'

  use {
    "ellisonleao/gruvbox.nvim",
    requires = {"rktjmp/lush.nvim"}
  }

  use { 
    "glepnir/zephyr-nvim",
    config = function()
      vim.cmd("hi! clear Conceal")
    end

  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
     'lervag/vimtex',
     ft = 'tex'
  }

  use {
    "sirver/ultisnips"
  }

  use {
      'neovim/nvim-lspconfig',
      'williamboman/nvim-lsp-installer',
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

end)
