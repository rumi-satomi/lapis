vim.pack.add{
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = 'https://github.com/folke/tokyonight.nvim' },
	{ src = 'https://github.com/Saghen/blink.lib' },
	{ src = 'https://github.com/Saghen/blink.cmp' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua'},
}

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()

require('nvim-tree').setup()

vim.cmd.colorscheme('tokyonight')

-- Enable language servers
vim.lsp.enable('bashls')
vim.lsp.enable('clangd')
vim.lsp.enable('cmake')
vim.lsp.enable('lua_ls')
vim.lsp.enable('java_language_server')
vim.lsp.enable('cssls')

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, {});

vim.api.nvim_create_user_command("CMakeConfigure", function()
	vim.cmd("split | terminal cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON")
end, {})

vim.api.nvim_create_user_command("CMakeBuild", function()
	vim.cmd("split | terminal cmake --build build")
end, {})
