local branch_status = function()
  local branch = vim.fn.system 'git branch --show-current 2>/dev/null | tr -d "\n"'
  if branch ~= '' then
    return '[' .. branch .. ']'
  end

  return ''
end

local get_time = function()
  local get_time_string = os.date '%H:%M'

  return '[' .. get_time_string .. ']'
end

local get_filename = function()
  local bt = vim.bo.buftype
  local name = vim.api.nvim_buf_get_name(0)

  if bt == 'nofile' then
    return '[no file opened]'
  end
  if bt == 'terminal' then
    return '[terminal]'
  end
  if name == '' then
    return '[untitled]'
  end

  return '[%t]'
end

_G.stl_active = function()
  return table.concat {
    '%#StatusLine#',
    branch_status(),
    '%y',
    '%=',
    get_filename(),
    '%=',
    '%h%w%m%r[%l:%c][%P]',
    get_time(),
  }
end

_G.stl_inactive = function()
  return '%#StatusLineNC#' .. get_filename()
end

vim.o.statusline = '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.stl_active() : v:lua.stl_inactive()%}'
