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
	utils.smart_terminal('cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON')
end, {})

vim.api.nvim_create_user_command('CMakeBuild', function()
	utils.smart_terminal('cmake --build build')
end, {})

vim.api.nvim_create_user_command('CMakeRun', function(opts)
	local executable = opts.args

	if not executable or executable == '' then
		vim.notify('Usage: :CMakeRun <executable>', vim.log.levels.ERROR)
		return
	end

	local path = 'build/' .. executable

	if vim.fn.executable(path) ~= 1 then
		vim.notify('Not executable: ' .. path, vim.log.levels.ERROR)
		return
	end

	smart_terminal('./' .. path)
end, {
	nargs = 1,
	complete = function(arglead)
		local matches = {}

		for _, exe in ipairs(find_executables()) do
			if exe:find(arglead, 1, true) == 1 then
				table.insert(matches, exe)
			end
		end

		return matches
	end
})
