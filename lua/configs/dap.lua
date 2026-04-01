local dap = require("dap")

-- 1. Tell DAP where the debugger executable is
local mason_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

-- FIX: We name the adapter 'lldb' to match your launch.json "type": "lldb"
-- This avoids needing to manually map them later.
dap.adapters.lldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = mason_path,
    args = {"--port", "${port}"},
  }
}

-- Optional: Keep the 'codelldb' name as an alias just in case
dap.adapters.codelldb = dap.adapters.lldb

-- 2. Map 'cpp' configurations
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "lldb", -- Use the name we defined above
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- Also apply these to C and Rust if you use them
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- 3. THE FIX: 
-- The line "require('dap.ext.vscode').load_launchjs(...)" has been removed.
-- nvim-dap now detects .vscode/launch.json automatically when you start debugging.
