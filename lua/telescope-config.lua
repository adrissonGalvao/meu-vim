local telescope = require("telescope")
local builtin = require("telescope.builtin")
local search = require("search")

telescope.load_extension("ui-select")
telescope.load_extension("lsp_handlers")

search.setup({
	append_tabs = { -- append_tabs will add the provided tabs to the default ones
		{
			name = "Git Files",
			tele_func = require("telescope.builtin").git_files,
			available = function()
				return false
			end,
		},
	},
	-- default tabs
	tabs = {
		{ "Files", builtin.find_files },
		{ "Grep",  builtin.live_grep },
	},
})

local resolve = require("telescope.config.resolve")

TelescopeLayoutConfigVertical = {
	horizontal = { width = 0.9 },
	width = resolve.resolve_width(0.9),
	height = resolve.resolve_height(0.99),
	preview_height = resolve.resolve_height(0.75),
	prompt_position = "bottom",
}

TelescopeLayoutConfigHorizontal = {
	vertical = { width = 0.9 },
	width = resolve.resolve_width(0.9),
	height = resolve.resolve_height(0.99),
	preview_width = resolve.resolve_width(0.65),
}

require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "which_key",
			},
		},
		file_ignore_patterns = { "./target/*", "target", "*/target/*", "target/*" },
		layout_strategy = "horizontal",
		layout_config = TelescopeLayoutConfigHorizontal,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--fixed-strings",
		},
		path_display = { "smart" },
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
		},
	},
})

-- -- nvim-tree
-- require("nvim-tree").setup({
-- 	sort_by = "case_sensitive",
-- 	view = {
-- 		adaptive_size = true,
-- 		-- mappings = {
-- 		-- 	list = {
-- 		-- 		{ key = "u", action = "dir_up" },
-- 		-- 	},
-- 		-- },
-- 	},
-- 	renderer = {
-- 		group_empty = true,
-- 	},
-- 	filters = {
-- 		dotfiles = true,
-- 	},
-- })

vim.keymap.set("n", "<leader>g", search.open, {})

local map = vim.api.nvim_set_keymap

map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true })
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { silent = true })
map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", { silent = true })
map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { silent = true })
map("n", "gr", "<cmd>Telescope lsp_references<CR>", { silent = true })
map("n", "<C-l>", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { silent = true })
map("n", "<space>d", "<cmd>Telescope diagnostics<CR>", { silent = true })
map("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
map("n", "<space>c", "<cmd>lua Call_server_ui()<CR>", { silent = true })

function Call_server_ui()
	local current_file = vim.bo.filetype

	if current_file == "scala" or current_file == "sbt" then
		require("telescope").extensions.metals.commands(TelescopeLayoutConfigVertical)
	end
end
