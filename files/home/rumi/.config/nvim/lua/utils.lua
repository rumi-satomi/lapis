local M = {}

function M.smart_terminal(cmd)
	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)

	if width > height then
		vim.cmd('vsplit')
	else
		vim.cmd('split')
	end

	vim.cmd('terminal ' .. cmd)end

return M
