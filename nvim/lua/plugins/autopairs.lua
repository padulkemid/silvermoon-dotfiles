return {
  'windwp/nvim-autopairs',
  event = { 'BufReadPre' },
  opts = {
    fast_wrap = {},
    disable_filetype = { 'TelescopePrompt', 'vim' },
  },
  config = function()
    require('nvim-autopairs').setup()

    -- setup cmp for autopairs
    local cmp = require 'cmp'
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
