return {
  -- key guide
  "folke/which-key.nvim",

  "nvim-telescope/telescope.nvim",

  -- neorg, note taking
  {
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    ft = "norg",
    -- options for neorg. This will automatically call `require("neorg").setup(opts)`
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },

{
  "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup()
    end,
},

    "nvim-treesitter/nvim-treesitter",

    {
	    "ellisonleao/gruvbox.nvim",
	    config = function()
		    vim.o.background = "dark" -- or "light" for light mode
		    vim.cmd([[colorscheme gruvbox]])
	    end,
    },

    -- alduin theme
    'AlessandroYorba/Alduin',

    "kylechui/nvim-surround",
}
