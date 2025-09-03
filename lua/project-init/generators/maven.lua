local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local utils = require('project-init.utils')
  local groupId = vim.fn.input({ prompt = "Group ID: ", default = "com.example" })
  local artifactId = name
  local cmd = string.format(
    "mvn -B archetype:generate -DgroupId=%s -DartifactId=%s -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false",
    vim.fn.shellescape(groupId),
    vim.fn.shellescape(artifactId)
  )
  vim.notify("Running: " .. cmd)
  utils.run_in_dir(path, cmd, {
    on_exit = function(ok, _, out, err)
      if not ok then
        vim.notify("Maven init failed: " .. (err ~= '' and err or out), vim.log.levels.ERROR)
      else
        vim.notify("Maven project created at " .. path .. "/" .. name)
      end
    end,
  })
end

return M


