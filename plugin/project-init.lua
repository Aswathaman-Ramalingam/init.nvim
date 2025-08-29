-- Loads the plugin on startup and registers commands
local ok, project_init = pcall(require, "project-init")
if ok then
  project_init.setup()
end


