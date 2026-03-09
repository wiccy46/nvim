local dap = require("dap")

-- 1. Tell DAP where the debugger executable is
-- If you installed 'codelldb' via Mason, this is the standard path:
local mason_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = mason_path,
    args = {"--port", "${port}"},
  }
}

-- 2. Map 'cpp' to use the codelldb adapter
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- 3. Automatically load your VS Code launch.json if it exists
require("dap.ext.vscode").load_launchjs(nil, { codelldb = {"cpp", "c"} })
