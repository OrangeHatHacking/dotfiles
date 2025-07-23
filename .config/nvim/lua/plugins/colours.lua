return {
    {
	"uZer/pywal16.nvim",
	config = function()
	    vim.cmd.colorscheme("pywal16")
	end,
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    theme = "pywal16-nvim",
	}
    },
    
}
