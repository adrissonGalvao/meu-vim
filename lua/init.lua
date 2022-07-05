require('plugins')
vim.wo.number = true
require'lspconfig'.pyright.setup{}

vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt_global.shortmess:remove("F"):append("c")


metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"

metals_config.settings = {
  showImplicitArguments = true
}
local dap = require("dap")

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach({metals_config})
    end,
    group = nvim_metals_group,
  })

local map = vim.api.nvim_set_keymap
-- Metals
map("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", { noremap = true, silent = true })
map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", {noremap= true, silent= true}) 
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {noremap= true, silent= true}) 
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {noremap= true, silent= true}) 
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", {noremap= true, silent= true}) 
map("n", "[c", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>", {noremap= true, silent= true}) 
map("n", "]c", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>", {noremap= true, silent= true}) 

-- Telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>", {noremap = true, silent = true})
map("n", "<leader>fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {noremap = true, silent = true})

-- Disabled find target
require('telescope').setup { 
	defaults = {  
		file_ignore_patterns = {"./target/*", "target", "*/target/*", "target/*"}
	},
	 extensions = {
		["ui-select"] = {
      			require("telescope.themes").get_dropdown {}
		},
		 live_grep_args = {
      			auto_quoting = true, -- enable/disable auto-quoting
    		}
	 }
}
require("telescope").load_extension("ui-select")
require("telescope").load_extension("live_grep_args")
-- nvim-tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true, 
  },
  filters = {
    dotfiles = true,
  },
})

map("n", "<leader>to", "<cmd>NvimTreeToggle<CR>", {noremap = true, silent = true})
map("n", "<leader>tc", "<cmd>NvimTreeClose<CR>", {noremap = true, silent = true})

-- duplicated line
map("n", "<leader>d", "yyp", {noremap = true, silent = true})
