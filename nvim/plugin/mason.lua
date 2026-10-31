vim.pack.add {
  'https://github.com/williamboman/mason.nvim'
}

local mason = require 'mason'

-- local check
--[[ mason.setup {
  registries = {
    "file:~/Work/personal-projects/nvim-plugins/mason-registry"
  }
} ]]
mason.setup()
