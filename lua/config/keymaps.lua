-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://www.reddit.com/r/neovim/comments/wg8zin/best_way_to_remap_keys_using_an_initlua/
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		if opts.desc then
			opts.desc = "keymaps.lua: " .. opts.desc
		end
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "s", ":w<Enter>", { desc = "quicker key to save file" })
map("n", "r", "<C-r>", { desc = "quicker key redo" })

-- open config file
vim.api.nvim_set_keymap('n', '<leader>e', ':edit ~/work/nvim/init.lua<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files({ cwd = vim.fn.getcwd() }) end, { desc = "Find files in cwd" })

-- keys to act on buffers
map("n", "<leader>bk", ":enew<Enter>", { desc = "kill the current buffer" })
map("n", "<leader>bs", ":Telescope buffers<Enter>", { desc = "switch buffers" })

-- keys to change dir
map("n", "<leader>dt", ":cd ~/work/nvim/<Enter>", { desc = "cd into the nvim config dir" })
map("n", "<leader>dh", ":cd ~/<Enter>", { desc = "cd into home" })

-- windows
map("n", "<leader>w", "<C-w>")

-- more keys

vim.keymap.set('n', '<leader>o',
	function()
		vim.cmd([[:source %]])
		vim.notify('file sourced', vim.log.levels.INFO)
	end,
	{ desc = "source current file" })

-- for substitute.nvim
vim.keymap.set("n", "<leader>s", require('substitute').operator, { noremap = true })
vim.keymap.set("n", "<leader>ss", require('substitute').line, { noremap = true })
vim.keymap.set("n", "<leader>S", require('substitute').eol, { noremap = true })
vim.keymap.set("x", "<leader>s", require('substitute').visual, { noremap = true })

-- run command
map("n", "<leader><leader>", ":Telescope commands<Enter>")
