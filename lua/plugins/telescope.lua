return {
    -- Main telescope plugin
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescopeBuiltin = require("telescope.builtin")
            vim.keymap.set('n', '<leader>ff', telescopeBuiltin.find_files, {})
            vim.keymap.set('n', '<leader>fg', telescopeBuiltin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', telescopeBuiltin.buffers, {})
        end
    },
    -- plugin for telescope that makes select UI look nicer.
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                -- Override some mappings
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-r>"] = actions.delete_buffer,
                        },
                        n = {
                            ["d"] = actions.delete_buffer,
                        }
                    }
                },
                extensions = {
                    ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                    -- even more opts
                    }

                    -- pseudo code / specification for writing custom displays, like the one
                    -- for "codeactions"
                    -- specific_opts = {
                    --   [kind] = {
                    --     make_indexed = function(items) -> indexed_items, width,
                    --     make_displayer = function(widths) -> displayer
                    --     make_display = function(displayer) -> function(e)
                    --     make_ordinal = function(e) -> string
                    --   },
                    --   -- for example to disable the custom builtin "codeactions" display
                    --      do the following
                    --   codeactions = false,
                    -- }
                    }
                }
            })
        -- To get ui-select loaded and working with telescope, you need to call
        -- load_extension, somewhere after setup function:
        require("telescope").load_extension("ui-select")
        end
    }
}