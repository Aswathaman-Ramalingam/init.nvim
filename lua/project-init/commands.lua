local M = {}

local ui = require("project-init.ui")

function M.register()
  vim.api.nvim_create_user_command("Init", function(opts)
    ui.open_picker()
  end, { nargs = 0, desc = "Initialize a new project" })

  vim.api.nvim_create_user_command("InitStacks", function()
    ui.list_stacks()
  end, { nargs = 0, desc = "List available stacks" })

  vim.api.nvim_create_user_command("InitHere", function()
    ui.open_picker({ path = vim.loop.cwd() })
  end, { nargs = 0, desc = "Initialize project in current directory" })
end

return M


