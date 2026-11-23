vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "<C-CR>", "<esc>o")
vim.keymap.set("n", "-", "ddp")
vim.keymap.set("n", "_", "ddkkp")
-- vim.keymap.set("n", "<leader>;", "A;<esc>")
vim.keymap.set("i", "<C-;>", "<esc>A;<CR>")

-- For sommenting using ctrl+/ with respect to the file extension
local function smart_comment()
	-- Map file extensions to their respective comment symbols
	local comment_map = {
		py = "#",
		sh = "#",
		bash = "#",
		yaml = "#",
		yml = "#",
		lua = "--",
		java = "//",
		js = "//",
		ts = "//",
		c = "//",
		cpp = "//",
		rs = "//",
	}

	local ext = vim.fn.expand("%:e")
	local comment_char = comment_map[ext]

	-- If the extension isn't in our map, do nothing
	if not comment_char then
		return
	end

	local line = vim.api.nvim_get_current_line()
	local pattern = "^%s*" .. vim.pesc(comment_char)

	if line:match(pattern) then
		-- Already commented: remove the comment characters and an optional space
		local new_line = line:gsub("(%s*)" .. vim.pesc(comment_char) .. " ?", "%1", 1)
		vim.api.nvim_set_current_line(new_line)
	else
		-- Not commented: prepend the comment character with a space
		local indent = line:match("^%s*") or ""
		local content = line:sub(#indent + 1)
		local new_line = indent .. comment_char .. " " .. content
		vim.api.nvim_set_current_line(new_line)
	end
end
vim.keymap.set("n", "<C-/>", smart_comment, { desc = "Toggle smart line comment" })
