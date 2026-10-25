vim.pack.add{
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/folke/tokyonight.nvim' },
	{ src = 'https://github.com/catgoose/nvim-colorizer.lua' },
	{ src = 'https://github.com/Saghen/blink.lib' },
	{ src = 'https://github.com/Saghen/blink.cmp' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}

vim.opt.termguicolors = true

require('colorizer').setup({
	filetypes = {
		'*',
	}
})

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()

require('nvim-tree').setup()

require('cmake/commands')

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

vim.cmd.colorscheme('tokyonight')

-- Enable language servers
vim.lsp.enable('bashls')
vim.lsp.enable('clangd')
vim.lsp.enable('cmake')
vim.lsp.enable('lua_ls')
vim.lsp.enable('jdtls')
vim.lsp.enable('cssls')

vim.lsp.config('qmlls', { cmd = { 'qmlls6' } })
vim.lsp.enable('qmlls')

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')

vim.api.nvim_create_user_command('PackUpdate', function()
	vim.pack.update()
end, {});

