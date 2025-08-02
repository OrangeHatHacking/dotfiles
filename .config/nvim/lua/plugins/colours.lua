return {
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true, -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "",  -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },
    {
        "RedsXDD/neopywal.nvim",
        name = "neopywal",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("neopywal").setup({
                transparent_background = true,
                default_plugins = false,
                plugins = {
                    blink_cmp = true,
                    harpoon = true,
                    lazy = true,
                    lazygit = true,
                    lsp = true,
                    mason = true,
                    nvim_cmp = true,
                    treesitter = true,
                },
            })
            vim.cmd.colorscheme("neopywal")
        end
    }
}
