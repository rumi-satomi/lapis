vim.pack.add{
	-- UI related packages
	{ src = 'https://github.com/folke/tokyonight.nvim' },
	{ src = 'https://github.com/catgoose/nvim-colorizer.lua' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },

	-- LSP and treesitter related packages
	{ src = 'https://github.com/mason-org/mason.nvim'},
	{ src = 'https://github.com/mason-org/mason-lspconfig.nvim'},
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/Saghen/blink.lib' },
	{ src = 'https://github.com/Saghen/blink.cmp' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },

	-- Other util
	{ src = 'https://github.com/Julian/lean.nvim'}
}

-- Setup ui and theme
vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')
require('colorizer').setup()
require('nvim-tree').setup({
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true
	}
})

-- Setup lsp and treestitter
require('mason').setup()
require('mason-lspconfig').setup()

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()

require('nvim-treesitter').install({
	'bash',
	'c',
	'cpp',
	'cmake',
	'css',
	'java',
	'lua',
	'vim',
	'vimdoc',
})

-- Setup other util
vim.g.lean_config = {
	mappings = true,
	infoview = {
		autoopen = true,
	}
}


require('cmake/commands')

-- Enable language servers
--vim.lsp.enable('bashls')
--vim.lsp.enable('clangd')
--vim.lsp.enable('cmake')
--vim.lsp.enable('lua_ls')
--vim.lsp.enable('jdtls')
--vim.lsp.enable('cssls')

--vim.lsp.config('qmlls', { cmd = { 'qmlls6' } })
--vim.lsp.enable('qmlls')

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')

vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {});

