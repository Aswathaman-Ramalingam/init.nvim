local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local cmd = string.format("cd %s && npx --yes create-react-app %s", vim.fn.shellescape(path), vim.fn.shellescape(name))
  vim.notify("Running: " .. cmd)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("create-react-app failed: " .. output, vim.log.levels.ERROR)
  else
    vim.notify("React app created at " .. path .. "/" .. name)
  end
end

return M


