local M = {}

local function collect_job_output()
  local chunks = { stdout = {}, stderr = {} }
  return chunks, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then table.insert(chunks.stdout, line) end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then table.insert(chunks.stderr, line) end
        end
      end
    end,
  }
end

function M.run_in_dir(dir, cmd, opts)
  opts = opts or {}
  local full_cmd = string.format("cd %s && %s", vim.fn.shellescape(dir), cmd)

  if vim.fn.has("nvim-0.10") == 1 or vim.fn.exists(":terminal") == 2 then
    local chunks, handlers = collect_job_output()
    local job_id = vim.fn.jobstart(full_cmd, vim.tbl_extend("force", {
      stdout_buffered = true,
      stderr_buffered = true,
      on_exit = function(_, code)
        local ok = code == 0
        local out = table.concat(chunks.stdout, "\n")
        local err = table.concat(chunks.stderr, "\n")
        if opts.on_exit then opts.on_exit(ok, code, out, err) end
      end,
    }, handlers))
    if job_id <= 0 then
      vim.notify("Failed to start job: " .. full_cmd, vim.log.levels.ERROR)
      if opts.on_exit then opts.on_exit(false, -1, "", "jobstart failed") end
    end
    return job_id
  else
    local out = vim.fn.system(full_cmd)
    local ok = vim.v.shell_error == 0
    if opts.on_exit then opts.on_exit(ok, vim.v.shell_error, out, ok and "" or out) end
    return ok and 0 or -1
  end
end

return M


