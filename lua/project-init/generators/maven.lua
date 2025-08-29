local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local groupId = vim.fn.input({ prompt = "Group ID: ", default = "com.example" })
  local artifactId = name
  local cmd = string.format(
    "cd %s && mvn -B archetype:generate -DgroupId=%s -DartifactId=%s -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false",
    vim.fn.shellescape(path),
    vim.fn.shellescape(groupId),
    vim.fn.shellescape(artifactId)
  )
  vim.notify("Running: " .. cmd)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Maven init failed: " .. output, vim.log.levels.ERROR)
  else
    vim.notify("Maven project created at " .. path .. "/" .. name)
  end
end

return M


