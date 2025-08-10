return {
  'windwp/nvim-autopairs',
  event = { 'InsertEnter' },
  config = function()
    require('nvim-autopairs').setup {}

    -- setup cmp for autopairs
    local cmp = require 'cmp'
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
