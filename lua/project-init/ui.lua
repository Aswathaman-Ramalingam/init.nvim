local M = {}

local has_telescope, telescope = pcall(require, "telescope")
local pickers = has_telescope and require("telescope.pickers") or nil
local finders = has_telescope and require("telescope.finders") or nil
local conf = has_telescope and require("telescope.config").values or nil

local config = require("project-init.config")

local function prompt_input(prompt, default)
  local result = vim.fn.input({ prompt = prompt .. ": ", default = default or "" })
  return result
end

local function run_generator(generator_key)
  local generators = require("project-init.generators")
  local generator = generators[generator_key]
  if not generator then
    vim.notify("No generator found for " .. generator_key, vim.log.levels.ERROR)
    return
  end

  local name = prompt_input("Project name")
  if name == nil or name == "" then
    vim.notify("Project name is required", vim.log.levels.WARN)
    return
  end

  local path = prompt_input("Directory (absolute)", vim.loop.cwd())
  if path == nil or path == "" then
    path = vim.loop.cwd()
  end

  generator.run({ name = name, path = path, config = config.get() })

  local cfg = config.get()
  if cfg.post_actions and cfg.post_actions.open_dir then
    local target = path .. "/" .. name
    vim.cmd("lcd " .. vim.fn.fnameescape(target))
    vim.notify("Changed directory to " .. target)
  end
end

function M.open_picker()
  local items = {}
  for key, meta in pairs(config.get().stacks) do
    table.insert(items, { key = key, label = meta.label })
  end

  if has_telescope and pickers and finders and conf then
    pickers.new({}, {
      prompt_title = "Init Project",
      finder = finders.new_table({
        results = items,
        entry_maker = function(entry)
          return {
            value = entry.key,
            display = entry.label,
            ordinal = entry.label .. " " .. entry.key,
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        map("i", "<CR>", function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          run_generator(selection.value)
        end)
        map("n", "<CR>", function(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          run_generator(selection.value)
        end)
        return true
      end,
    }):find()
  else
    local choices = {}
    for _, item in ipairs(items) do
      table.insert(choices, item.label .. " (" .. item.key .. ")")
    end
    local idx = vim.fn.inputlist(vim.list_extend({ "Select stack:" }, choices))
    if idx and idx > 0 and idx <= #items then
      run_generator(items[idx].key)
    end
  end
end

function M.list_stacks()
  local items = {}
  for key, meta in pairs(config.get().stacks) do
    table.insert(items, string.format("%s - %s", key, meta.label))
  end
  vim.notify(table.concat(items, "\n"))
end

return M


