local telescope = require('telescope')
local builtin = require('telescope.builtin')

local options = {
	defaults = {
		vimgrep_arguments = { 
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',

		}
	}
}

telescope.setup(options)


function grepString() 
	builtin.grep_string({
		search = vim.fn.input('-> ')
	})
end

vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ag', grepString, {})
