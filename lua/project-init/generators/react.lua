local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local utils = require('project-init.utils')
  local cmd = string.format("npx --yes create-react-app %s", vim.fn.shellescape(name))
  vim.notify("Running: " .. cmd)
  utils.run_in_dir(path, cmd, {
    on_exit = function(ok, _, out, err)
      if not ok then
        vim.notify("create-react-app failed: " .. (err ~= '' and err or out), vim.log.levels.ERROR)
      else
        vim.notify("React app created at " .. path .. "/" .. name)
      end
    end,
  })
end

return M


