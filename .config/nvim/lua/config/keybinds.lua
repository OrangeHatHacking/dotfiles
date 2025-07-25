vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- space + e to open file explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Remove highlight from search after escaping
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Double space to escape insert mode
-- vim.keymap.set('i', '<leader><leader>', '<ESC>')

-- Disable arrow keys, git gud scrub
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!"<CR>')

