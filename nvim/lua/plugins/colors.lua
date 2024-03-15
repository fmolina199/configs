return {
	{
		'romainl/Apprentice'
	},
	{
		'rose-pine/neovim',
		name = 'rose-pine',
		config = function()
			require('rose-pine').setup({
				disable_background = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "storm",
				transparent = true,
				terminal_colors = true,
			})
		end
	}
}
