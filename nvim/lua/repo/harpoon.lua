return {
  'theprimeagen/harpoon',
  event = { 'BufReadPre', 'BufNewFile' },
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    require('utils.helpers').lazy_load 'harpoon'
  end,
  config = function()
    local harpoon = require 'harpoon'
    local telescope_config = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local fp = {}

      for _, item in ipairs(harpoon_files.items) do
        table.insert(fp, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = fp,
          },
          previewer = telescope_config.file_previewer {},
          sorter = telescope_config.generic_sorter {},
        })
        :find()
    end

    harpoon:setup()

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd' })

    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end, { desc = '[H]arpoon [C]lear' })

    vim.keymap.set('n', '<leader><space>', function()
      toggle_telescope(harpoon:list())
    end, { desc = '[H]arpoon [F]iles' })
  end,
}
