local M = {}

function M.run(opts)
  local name = opts.name
  local path = opts.path
  local utils = require('project-init.utils')
  local cmd = string.format("npx --yes @angular/cli new %s --defaults --skip-git", vim.fn.shellescape(name))
  vim.notify("Running: " .. cmd)
  utils.run_in_dir(path, cmd, {
    on_exit = function(ok, _, out, err)
      if not ok then
        vim.notify("Angular init failed: " .. (err ~= '' and err or out), vim.log.levels.ERROR)
      else
        vim.notify("Angular project created at " .. path .. "/" .. name)
      end
    end,
  })
end

return M


