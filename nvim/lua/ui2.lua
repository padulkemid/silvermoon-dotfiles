local opts = {
  enable = true,
  msg = {
    targets = 'cmd',
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.5,
      timeout = 4000,
    },
    pager = {
      height = 0.5,
    },
  },
}

require('vim._core.ui2').enable(opts)
