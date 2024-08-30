-- use system clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- i need both
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- turn tabs to spaces of width 2
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- font
vim.o.guifont = "inconsolata:h13"  -- Set the font and size

vim.opt.listchars = {
  eol = '↵',
  trail = '~',
  tab = '> ',
  nbsp = '␣'
}
