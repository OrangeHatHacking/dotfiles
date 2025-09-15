return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', function()
			require('telescope.builtin').find_files({
				hidden = true,
				follow = true,
				search_dirs = {
					vim.fn.expand("~/dotfiles/.bashrc"),
					vim.fn.expand("~/dotfiles/.config"),
				},
				file_ignore_patterns = {
					".*%.png", ".*%.jpg", ".*%.jpeg", ".*%.gif", ".*%.webp", ".*%.ico", ".git/*",
				},
			})
		end, { desc = 'Find files' })
		vim.keymap.set('n', '<leader>fg', function()
			require('telescope.builtin').live_grep({
				hidden = true,
				follow = true,
				search_dirs = {
					vim.fn.expand("~/dotfiles/.bashrc"),
					vim.fn.expand("~/dotfiles/.config"),
				},
				file_ignore_patterns = {
					".*%.png", ".*%.jpg", ".*%.jpeg", ".*%.gif", ".*%.webp", ".*%.ico", ".git/*",
				}
			})
		end, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end
}
