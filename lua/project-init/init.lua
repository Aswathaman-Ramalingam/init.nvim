local M = {}

local config = require("project-init.config")
local commands = require("project-init.commands")

function M.setup(user_config)
  config.setup(user_config)
  commands.register()

  -- WIP: Optional integrations
  local cfg = config.get()
  if cfg.integrations and cfg.integrations.dashboard and cfg.integrations.dashboard.enabled then
    pcall(function()
      require('project-init.integrations.dashboard').setup(cfg.integrations.dashboard)
    end)
  end
end

return M


