return{
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true, -- auto close tags like <div></div>
        enable_rename = true, -- auto rename closing tag when you rename the opening tag
        enable_close_on_slash = false, -- don't trigger autoclose when typing '</'
      },
    })
  end,
}

