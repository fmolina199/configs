print("=> Loading remaps...")
-- Set mapleader as space
vim.g.mapleader = " "
-- Return to folder
vim.keymap.set("n", "<leader>aa", vim.cmd.Ex)
-- Move to window on left
vim.keymap.set("n", "<C-h>", "<C-w>h")
-- Move to window below
vim.keymap.set("n", "<C-j>", "<C-w>j")
-- Move to window above
vim.keymap.set("n", "<C-k>", "<C-w>k")
-- Move to windows on right
vim.keymap.set("n", "<C-l>", "<C-w>l")
-- Copy selected text to system clipboard
vim.keymap.set('v', '<leader>yy', '"+y', { desc = "Copy to System Clipboard" })
-- Copy the current line to system clipboard in Normal mode
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = "Copy line to System Clipboard" })
-- Toggle line numbers (both absolute and relative)
vim.keymap.set('n', '<leader>nn', function()
  local number = vim.wo.number -- Get current state of "number"
  local relativenumber = vim.wo.relativenumber -- Get current state of "relativenumber"

  if number or relativenumber then
    -- If any numbers are on, turn them all off
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.opt.list = false
  else
    -- If numbers are off, turn them on (adjust preference here)
    vim.wo.number = true
    vim.wo.relativenumber = true -- Set to false if you only want absolute numbers
    vim.opt.list = true
  end
end, { desc = "Toggle Line Numbers" })
