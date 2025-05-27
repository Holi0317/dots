local M = {}

function M.sudo_exec(cmd, on_completed)
	local password = vim.fn.inputsecret("Password: ")

	if not password or #password == 0 then
		vim.notify("Invalid password. sudo aborted")
		return
	end

	local stdout_data = {}
	local stderr_data = {}

	-- Spawn the command with sudo
	local job_id = vim.fn.jobstart(string.format("sudo -p '' -S -- %s", cmd), {
		stderr_buffered = true,
		on_stdout = function(_, data)
			vim.list_extend(stdout_data, data)
		end,
		on_stderr = function(_, data)
			vim.list_extend(stderr_data, data)
		end,
		on_exit = function(_, exitcode)
			if exitcode ~= 0 then
				vim.notify(table.concat(stderr_data, "\n"), "warn")

				if on_completed ~= nil then
					on_completed(false)
				end
				return
			end

			vim.notify(table.concat(stdout_data, "\n"), "info")

			if on_completed ~= nil then
				on_completed(true)
			end
		end,
	})

	vim.fn.chansend(job_id, password)
	vim.fn.chanclose(job_id, "stdin")

	return job_id
end

function M.sudo_write(tmpfile, filepath)
	if not tmpfile then
		tmpfile = vim.fn.tempname()
	end
	if not filepath then
		filepath = vim.fn.expand("%")
	end
	if not filepath or #filepath == 0 then
		print("E32: No file name")
		return
	end
	-- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
	-- Both `bs=1M` and `bs=1m` are non-POSIX
	local cmd = string.format("dd if=%s of=%s bs=1048576", vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
	-- no need to check error as this fails the entire function
	vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })

	M.sudo_exec(cmd, function(succeed)
		if succeed then
			print(string.format('[Sudo] "%s" written', filepath))
			vim.cmd("e!")
		end
		vim.fn.delete(tmpfile)
	end)
end

function M.setup()
	vim.cmd(":ca w!! lua require('user.plugins.sudo').sudo_write()")
end

return M
