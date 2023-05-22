local api = vim.api

local attach_to_buffer  = function (output_bufnr, pattern, command)
api.nvim_create_autocmd("BufWritePost", {
  group = api.nvim_create_augroup("PlaygroundExperiments", { clear = true }),
  -- pattern = "*.swift",
  pattern = pattern,
  callback = function ()
    local append_data = function(_, data)
      if data then
        api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
      end
    end

    api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { "output of: main.swift" })
    vim.fn.jobstart(command, {
      stdout_buffered = true,
      on_stdout = append_data,
      on_stderr = append_data,
    })
  end,
})
end

-- vim.api.nvim_create_user_autocmd("Autorun", function()
     -- print("Autorun starts now...")
     --[[ local bufnr = vim.fn.input "Bufnr: "
     local pattern = vim.fn.input "Pattern: "
     local command = vim.split(vim.fn.input " command: ", " ")
     attach_to_buffer(tonumber(bufnr), pattern, command) ]]
   -- end,{})

 vim.api.nvim_create_user_command("Autorun", function ()
  print("MYAutorun command is working")
  local bufnr = vim.fn.input "Bufnr: "
  local pattern = vim.fn.input "Pattern: "
  local command = vim.split(vim.fn.input " command: ", " ")
  attach_to_buffer(tonumber(bufnr), pattern, command )
 end, {})

 vim.api.nvim_create_user_command("Swiftrun", function ()
  print("MYAutorun command is working")
  local bufnr = vim.fn.input "Bufnr: "
  attach_to_buffer(tonumber(bufnr), "*.swift", {"swift", "run"})
 end, {})


 vim.api.nvim_create_user_command("CProgram", function ()
  print("MYAutorun command is working")
  local bufnr = vim.fn.input "Bufnr: "
  attach_to_buffer(tonumber(bufnr), "main.c", {"gcc", "-g", "-o", "c_output", "main.c" })
  attach_to_buffer(tonumber(bufnr), "main.c", {"./c_output" })
 end, {})
