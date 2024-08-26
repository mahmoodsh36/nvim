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
