--[[ local function get_mise_java(version)
  local cmd = version and ('mise where java@' .. version) or 'mise where java'
  local handle = io.popen(cmd .. ' 2>/dev/null')
  if not handle then
    return nil
  end
  local path = handle:read '*l'
  handle:close()
  return path
end

local java_21 = get_mise_java '21' ]]

-- sometimes using custom gradle wouldn't work because it matches to JBR 25
-- just use intellij for kotlin, for now.
-- nvim is good for fast viewing code/diff
return {
  filetypes = { 'kotlin' },
  cmd = { 'intellij-server', '--stdio' },
  --[[ settings = {
    intellij = {
      jdkForSymbolResolution = java_21,
    },
  }, ]]
  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
    'build.gradle',
    'build.gradle.kts',
    'workspace.json',
  },
}
