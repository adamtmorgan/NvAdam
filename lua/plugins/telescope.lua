return {
	-- Main telescope plugin
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescopeBuiltin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", telescopeBuiltin.find_files, {})
			vim.keymap.set("n", "<leader>fg", telescopeBuiltin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", telescopeBuiltin.buffers, {})
		end,
	},
	-- plugin for telescope that makes select UI look nicer.
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				-- Override some mappings
				defaults = {
					max_results = 50,
					-- Use ripgrep (installed separately) as the live-grep source.
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},

					-- Cache results to make things snappier
					cache_picker = {
						num_pickers = 10,
					},
					layout_config = {
						horizontal = {
							width = 0.85,
							height = 0.85,
							preview_width = 0.4,
						},
						vertical = {
							width = 0.85,
							height = 0.85,
						},
						center = {
							width = 0.8,
							height = 0.4,
						},
					},
					-- Ignore certain dirs
					file_ignore_patterns = {
						"node_modules",
						".git",
						"dist",
						"build",
						"fontawesome*",
					},
					-- Format the search results to display the file name first
					-- followed by the full file path.
					-- path_display = function(ops, path)
					-- 	local tail = require("telescope.utils").path_tail(path)
					-- 	return string.format("%s - %s", tail, path)
					-- end,
					--
					-- NOTE: Disabled for now, as it had a huge impact on performance
					-- in larger projects. Big sad... will stay this way for now.
					-- path_display = { "smart" },
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-r>"] = actions.delete_buffer,
						},
						n = {
							["d"] = actions.delete_buffer,
						},
					},
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				},
				pickers = {
					lsp_code_actions = {
						theme = "cursor",
					},
					live_grep = {
						max_results = 50,
					},
					find_files = {
						-- find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
						-- theme = "dropdown",
						max_results = 50,
						find_command = {
							"fd",
							"--type",
							"f",
							"--hidden",
							"--follow",

							-- Exclusions
							"--exclude",
							".git",
							"--exclude",
							"*.png",
							"--exclude",
							"*.jpg",
							"--exclude",
							"*.jpeg",
							"--exclude",
							"*.gif",
							"--exclude",
							"*.bmp",
							"--exclude",
							"*.tiff",
							"--exclude",
							"*.ico",
							"--exclude",
							"*.mp4",
							"--exclude",
							"*.mp3",
							"--exclude",
							"*.wav",
							"--exclude",
							"*.ogg",
							"--exclude",
							"*.flac",
							"--exclude",
							"*.pdf",
							"--exclude",
							"*.doc",
							"--exclude",
							"*.docx",
							"--exclude",
							"*.ppt",
							"--exclude",
							"*.pptx",
							"--exclude",
							"*.xls",
							"--exclude",
							"*.xlsx",
							"--exclude",
							"*.zip",
							"--exclude",
							"*.tar",
							"--exclude",
							"*.gz",
							"--exclude",
							"*.rar",
							"--exclude",
							"*.7z",
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),

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
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}
