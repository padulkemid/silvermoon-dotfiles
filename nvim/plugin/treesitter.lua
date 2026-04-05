vim.pack.add {
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

local ts = require 'nvim-treesitter'

ts.setup()

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
  end,
})

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    local ft = vim.bo.filetype

    if ft and ft ~= '' then
      local ok = pcall(function()
        vim.treesitter.start()
      end)

      if not ok then
        return
      end
    end
  end,
})
