return {
	'tpope/vim-fugitive',
	cmd = { 'Git' },
	config = function()
		vim.keymap.set("n", "<leader>gi", vim.cmd.Git)
	end
}
