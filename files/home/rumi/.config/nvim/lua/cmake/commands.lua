local utils = require('utils')

local function find_executables()
	local executables = {}

	local files = vim.fn.globpath('build', '**/*', false, true)

	for _, file in ipairs(files) do
		local rel = file:gsub('^build/', '')

		if not rel:match('^CMakeFiles/') then
			if vim.fn.isdirectory(file) == 0 and vim.fn.executable(file) == 1 then
				table.insert(executables, rel)
			end
		end
	end

	table.sort(executables)
	return executables
end

vim.api.nvim_create_user_command('CMakeConfigure', function()
	vim.cmd('botright vnew')

	vim.fn.jobstart(
		{
			'cmake',
			'-S', '.',
			'-B', 'build',
			'-DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
		}, {
			term = true,
			on_exit = function(_, exit_code)
				vim.schedule(function()
					if exit_code == 0 then
						vim.notify('CMake configure finished')
						if #vim.lsp.get_clients({ name = 'clangd' }) > 0 then
							vim.cmd('lsp restart clangd')
						end
					else
						vim.notify('CMake configure failed', vim.log.levels.ERROR)
					end
				end)
			end
		}
	)
end, {})

vim.api.nvim_create_user_command('CMakeBuild', function()
	utils.smart_terminal('cmake --build build')
end, {})

vim.api.nvim_create_user_command('CMakeRun', function(opts)
	local executable = opts.fargs[1]

	if not executable or executable == '' then
		vim.notify('Usage: :CMakeRun <executable>', vim.log.levels.ERROR)
		return
	end

	local path = 'build/' .. executable

	if vim.fn.executable(path) ~= 1 then
		vim.notify('Not executable: ' .. path, vim.log.levels.ERROR)
		return
	end

	utils.smart_terminal('./' .. path .. ' ' .. table.concat(opts.fargs, ' ', 2))
end, {
	nargs = '+',
	complete = function(arglead, cmdline, cursorpos)
		-- Only complete the executable (first argument)
		local before_cursor = cmdline:sub(1, cursorpos - 1)
		local before_arg = before_cursor:sub(1, #before_cursor - #arglead)

		local previous_args = before_arg:gsub(
			'^%s*:?CMakeRun%s*',
			''
		)

		if previous_args:match('%S') then
			return {}
		end

		local matches = {}

		for _, exe in ipairs(find_executables()) do
			if exe:find(arglead, 1, true) == 1 then
				table.insert(matches, exe)
			end
		end

		return matches
	end
})
