-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap  -- for conciseness

-----------------------
-- General Keymaps --

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("v", "jk", "<ESC>", { desc = "Exit visual mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management -----------------

-- use 'space'+s+v to split the current window vertically
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) 
-- use 'space'+s+h to split the current window horizontally
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split windwo horizontally" })
-- use 'space'+s+e to make splits equal size
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal" })
-- use 'space'+s+x to close the current active split window
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tab management -----------------------

-- use 'space'+t+o to open a new nvim tab
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) 
-- use 'space'+t+x to close the current active tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- use 'space'+t+n to go/navigate to the next tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
-- use 'space'+t+p to go/navigate to the previous tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab"})
-- use 'space'+t+f to open.move the current buffer in a new tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })










