-- require("lazy").setup({
  -- {import = "plugins"}
-- })
-- using spaces instead of tabs as tabs
vim.cmd("set expandtab")
-- tab with = 2 spaces
vim.cmd("set tabstop=2")
-- 
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

-- lazy.nvim installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then 
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",

		"--branch=stable", -- latest stable release
		lazypath,
	})
end
   
vim.opt.rtp:prepend(lazypath)

-- plugins 
local plugins = {
  -- for fast and incremental parsing of code
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  -- for line and block commenting 
  {"numToStr/Comment.nvim"},
  {"catppuccin/nvim", name = "catppuccin", priority = 1000},
  -- {"shaunsingh/nord.nvim", priority = 1000, lazy = false},
  -- fuzzy finding and grep functionality
  {"nvim-telescope/telescope.nvim", tag = "0.1.5",
    dependencies = {"nvim-lua/plenary.nvim"}
  },
  -- to see project structure in editor 
  {"nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icons
    config = function()
      require("nvim-tree").setup({
        -- Your nvim-tree configuration here
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        view = {
          width = 30,
        },
      })
    end,
  },
}

local opts = {}

-- loading plugins
require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- color theme 
vim.o.termguicolors = true
vim.g.catppuccin_flavour = "mocha"
vim.g.catppuccin_custom_colors = true

require("catppuccin").setup({
  transparent_background = false,
  term_colors = true,
  styles = {
    comments = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
  },
})

-- vim.g.nord_contrast = false
-- vim.g.nord_borders = false
-- vim.g.nord_disable_background = false

vim.cmd("colorscheme catppuccin")
vim.api.nvim_set_hl(0, "Conditional", { fg = "#d1b0fa" }) -- Example for 'if'
-- vim.api.nvim_set_hl(0, "Keyword", { fg = "#81a1c1", italic = true })   -- Example for 'then' and 'end'


-- commenting
require("Comment").setup({
  toggler = {
    line = "gcc",
    block = "gbc",
  },
  opleader = {
    line = "gc",
    block = "gb",
  },
})

-- parser 
require("nvim-treesitter.configs").setup({
  ensure_installed = {"lua", "vim", "java", "typescript", "javascript", "go", "html", "css", "scss"},
  highlight = {
    enable = true, -- false will disable whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})
vim.wo.foldmethod = "manual"
vim.wo.foldenable = false

-- numbers on the side
vim.o.number = true
vim.o.relativenumber = false

-- for copy paste
vim.opt.clipboard = 'unnamedplus'

-- key mapping for commenting
vim.keymap.set("n", "<C-7>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>")
vim.keymap.set("n", "<C-S-7>", "<cmd>lua require('Comment.api').toggle.blockwise.current()<CR>")

