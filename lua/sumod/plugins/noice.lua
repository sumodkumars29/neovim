return{
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    {
      "rcarriga/nvim-notify",
      config= function()
        vim.notify = require("notify")
      end,
    },
  },
  config = function()
    require("noice").setup()

    -- Font style / color for the command line popup
    -- vim.cmd([[
    -- highlight NoiceCmdlinePopup guifg=#66FF00  gui=bold
    -- highlight NoiceCmdlinePopupBorder guifg=#89b4fa 
    -- ]])
  end,
}
