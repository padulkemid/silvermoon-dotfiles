local M = {}

M.lazy_load = function(plugin)
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('BeLazyOnFileOpen' .. plugin, {}),
    callback = function()
      local file = vim.fn.expand '%'
      local condition = file ~= '[lazy]' and file ~= ''

      if condition then
        vim.api.nvim_del_augroup_by_name('BeLazyOnFileOpen' .. plugin)

        -- dont defer for tree-sitter as it will show slow highlighting
        -- this deferring only happens only when we do `nvim filename`

        if plugin ~= 'nvim-treesitter' then
          vim.schedule(
            function()
              require('lazy').load { plugins = plugin }

              if plugin == 'nvim-lspconfig' then
                vim.cmd 'silent! do FileType'
              end
            end
          )
        else
          require('lazy').load { plugins = plugin }
        end
      end
    end
  })
end

return M
