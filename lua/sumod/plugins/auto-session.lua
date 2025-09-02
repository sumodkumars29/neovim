return{
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      auto_restore_enable = false,
--      auto_session_suppress_dirs = { "~/", "~/Dev", "~/Dowloads", "~/Documents", "~/Desktop" },
    suppressed_dirs = { "~/", "~/Dev", "~/Dowloads", "~/Documents", "~/Desktop" }
    })

  vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  -- set keymaps
  local keymap = vim.keymap  -- for conciseness

  keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for current working directory" })  -- restore last workspace session for current directory
  keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" })  -- save workspace session for current working directory
  end,

}
