vim.pack.add {
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '^1' },
}

local group = vim.api.nvim_create_augroup('BlinkCmpLazyLoad', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  group = group,
  once = true,
  callback = function()
    local blink = require 'blink.cmp'

    blink.setup {
      keymap = {
        preset = 'none',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      appearance = {
        nerd_font_variant = 'mono',
        use_nvim_cmp_as_default = true,
      },
      completion = {
        menu = {
          border = 'single',
        },
        documentation = {
          auto_show = true,
          window = {
            border = 'single',
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = 'single',
        },
      },
      fuzzy = {
        implementation = 'prefer_rust_with_warning',
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer',
        },
      },
    }
  end,
})
