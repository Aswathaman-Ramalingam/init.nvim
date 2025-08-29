local M = {}

local ui = require("project-init.ui")

function M.register()
  vim.api.nvim_create_user_command("Init", function(opts)
    ui.open_picker()
  end, { nargs = 0, desc = "Initialize a new project" })
end

return M


