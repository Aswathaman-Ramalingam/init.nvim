local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local utils = require('project-init.utils')
  local cmd = string.format("npm init vue@latest %s -- --yes", vim.fn.shellescape(name))
  vim.notify("Running: " .. cmd)
  utils.run_in_dir(path, cmd, {
    on_exit = function(ok, _, out, err)
      if not ok then
        vim.notify("Vue init failed: " .. (err ~= '' and err or out), vim.log.levels.ERROR)
      else
        vim.notify("Vue project created at " .. path .. "/" .. name)
      end
    end,
  })
end

return M


