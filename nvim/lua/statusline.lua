local branch = vim.fn.system 'git branch --show-current 2>/dev/null | tr -d "\n"'
local branch_status = function()
  if branch ~= '' then
    return '[' .. branch .. ']'
  end

  return ''
end

local get_time = function()
  local get_time_string = os.date '%H:%M'

  return '[' .. get_time_string .. ']'
end

_G.stl_active = function()
  return table.concat {
    '%#StatusLine#',
    branch_status(),
    '%y',
    '%=',
    '[%f]',
    '%=',
    '%h%w%m%r[%l:%c][%P]',
    get_time(),
  }
end

_G.stl_inactive = function()
  return '%#StatusLineNC#[%f]'
end

vim.o.statusline = '%{%(nvim_get_current_win()==#g:actual_curwin || &laststatus==3) ? v:lua.stl_active() : v:lua.stl_inactive()%}'
