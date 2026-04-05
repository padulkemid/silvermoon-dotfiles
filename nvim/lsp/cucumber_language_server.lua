return {
  cmd = { 'cucumber-language-server', '--stdio' },
  filetypes = { 'cucumber' },
  settings = {
    cucumber = {
      features = { '**/*.feature' },
      glue = { '**/*_steps.ts', '**/*_step.ts' },
    },
  },
}
