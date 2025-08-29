local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local cmd = string.format("cd %s && npm init vue@latest %s -- --yes", vim.fn.shellescape(path), vim.fn.shellescape(name))
  vim.notify("Running: " .. cmd)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("Vue init failed: " .. output, vim.log.levels.ERROR)
  else
    vim.notify("Vue project created at " .. path .. "/" .. name)
  end
end

return M


