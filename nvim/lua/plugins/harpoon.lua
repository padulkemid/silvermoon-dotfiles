return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    require('utils.helpers').lazy_load 'harpoon'
  end,
  config = function()
    local set = vim.keymap.set
    local harpoon = require 'harpoon'
    local telescope_config = require('telescope.config').values

    local function toggle_telescope(harpoon_files)
      local finder = function()
        local fp = {}

        for _, item in ipairs(harpoon_files.items) do
          table.insert(fp, item.value)
        end

        return require('telescope.finders').new_table {
          results = fp,
        }
      end

      require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = finder(),
            previewer = telescope_config.file_previewer {},
            sorter = telescope_config.generic_sorter {},
            attach_mappings = function(buf_num, map)
              map('i', '<C-d>', function()
                local state = require 'telescope.actions.state'
                local selected_entry = state.get_selected_entry()
                local current_picker = state.get_current_picker(buf_num)

                harpoon:list():remove_at(selected_entry.index)
                current_picker:refresh(finder())
              end)

              return true
            end,
          })
          :find()
    end

    harpoon:setup()

    set('n', '<leader>ha', function() harpoon:list():add() end, { desc = '[H]arpoon [A]dd' })
    set('n', '<leader>hc', function() harpoon:list():clear() end, { desc = '[H]arpoon [C]lear' })
    set('n', '<leader><space>', function() toggle_telescope(harpoon:list()) end, { desc = '[H]arpoon [F]iles' })
  end,
}
