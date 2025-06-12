local M = {}

local function find_project_root(start_dir, item_name)
	local current_search_dir = start_dir
	if not current_search_dir or current_search_dir == "" then
		return nil
	end

	while true do
		local item_path
		if current_search_dir:sub(-1) == "/" then
			item_path = current_search_dir .. item_name
		else
			item_path = current_search_dir .. "/" .. item_name
		end

		if vim.fn.filereadable(item_path) == 1 or vim.fn.isdirectory(item_path) == 1 then
			return current_search_dir -- Found the directory containing the item
		end

		local parent_dir = vim.fn.fnamemodify(current_search_dir, ":h")

		if parent_dir == current_search_dir or parent_dir == "" then
			return nil
		end
		current_search_dir = parent_dir
	end
end

local function command_prefix()
	local current_buffer_dir = vim.fn.expand("%:p:h")
	if not current_buffer_dir or current_buffer_dir == "" then
		current_buffer_dir = vim.fn.getcwd()
	end

	if not current_buffer_dir or current_buffer_dir == "" then
		return nil
	end

	if find_project_root(current_buffer_dir, ".doc.yaml") then
		return "doc"
	end

	local drupal_root_dir = find_project_root(current_buffer_dir, "composer.json")

	if drupal_root_dir then
		if vim.fn.isdirectory(".ddev") == 1 then
			return "ddev"
		end
	end

	return nil
end

local function drush_exec(cmd, on_complete)
	local prefix = command_prefix()
	local cmd_parts = {}

	if prefix then
		table.insert(cmd_parts, prefix)
	end
	table.insert(cmd_parts, "drush")
	table.insert(cmd_parts, cmd)

	local full_command = table.concat(cmd_parts, " ")

	local stdout_lines = {}
	local stderr_lines = {}

	local job_id = vim.fn.jobstart(full_command, {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data, _)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(stdout_lines, line)
					end
				end
			end
		end,
		on_stderr = function(_, data, _)
			if data then
				for _, line in ipairs(data) do
					if line ~= "" then
						table.insert(stderr_lines, line)
					end
				end
			end
		end,
		on_exit = function(_, exit_code, _)
			if on_complete then
				on_complete(exit_code, stdout_lines, stderr_lines, full_command)
			end
		end,
	})

	if job_id == 0 or job_id == -1 then
		vim.notify("Failed to start drush command: " .. full_command, vim.log.levels.ERROR)
		if on_complete then
			on_complete(-1, {}, { "Failed to start job: " .. full_command }, full_command)
		end
	end
end

function M.drush_cr()
	vim.notify(string.format("Clearing Drupal cache (%s) ...", command_prefix() .. " drush cr"), vim.log.levels.INFO, { title = "Drush" })

	drush_exec("cr", function(exit_code, stdout_data, stderr_data, executed_command)
		if exit_code == 0 then
			local success_msg = "Cache cleared successfully."
			vim.notify(success_msg, vim.log.levels.INFO, { title = "Drush Success" })
		else
			local err_msg = "Drush cr failed (exit code: " .. tostring(exit_code) .. ")."
			if #stderr_data > 0 then
				err_msg = err_msg .. "\nErrors:\n" .. table.concat(stderr_data, "\n")
			end
			-- Sometimes important error info might also be on stdout
			if #stdout_data > 0 then
				err_msg = err_msg .. "\nOutput:\n" .. table.concat(stdout_data, "\n")
			end
			vim.notify(err_msg, vim.log.levels.ERROR, { title = "Drush Error" })
			print("Drush command failed: " .. executed_command) -- Also print to messages
		end
	end)
end

return M
