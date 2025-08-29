local M = {}

local config = require("project-init.config")
local commands = require("project-init.commands")

function M.setup(user_config)
  config.setup(user_config)
  commands.register()
end

return M


