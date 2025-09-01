local M = {}

local defaults = {
  stacks = {
    react = { label = "React (CRA)" },
    vite = { label = "Vite" },
    maven = { label = "Java Maven" },
    angular = { label = "Angular" },
    vue = { label = "Vue" },
  },
  post_actions = {
    open_dir = true,
  },
}

local user = {}

function M.setup(user_config)
  user = user_config or {}
end

function M.get()
  local cfg = vim.tbl_deep_extend("force", {}, defaults, user)
  return cfg
end

return M


