return {
  -- key guide
  "folke/which-key.nvim",

  -- popup choice list
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-smart-history.nvim" },
      { "kkharji/sqlite.lua" }, -- required for telescope-smart-history
    },
    config = function()
      require("telescope").setup {
        defaults = {
          history = {
            path = '~/.telescope_history.sqlite3',
            limit = 10000000,
          }
        },
        extensions = {
          smart_history = {
            auto_prompt = true,
          },
        },
      }

      -- load the extension
      require("telescope").load_extension("smart_history")
    end,
  },

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

  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup()
    end,
  },

  -- prewritten treesitter configs
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require'nvim-treesitter.configs'.setup {
        -- a list of parser names, or "all" (the listed parsers must always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
        -- ensure_installed = 'all',
        -- ignore_install = { 'org' },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = { "c", "rust" },
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },

  -- show context of the cursor
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require'treesitter-context'.setup{
        enable = true, -- enable this plugin (can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- minimum editor window height to enable context. values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- maximum number of lines to show for a single context
        trim_scope = 'outer', -- which context lines to discard if `max_lines` is exceeded. choices: 'inner', 'outer'
        mode = 'cursor',  -- line used to calculate context. choices: 'cursor', 'topline'
        -- separator between context and content. should be a single character string, like '-'.
        -- when separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- the z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },

  -- favorite theme
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      vim.o.background = "dark" -- or "light" for light mode
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- alduin theme
  'AlessandroYorba/Alduin',

  -- surrounding text with delimiters
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },

  -- exchanging portions of text
  'gbprod/substitute.nvim',

  -- lsp
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      -- python
      lspconfig.pyright.setup {}
      -- typescript , javascript
      lspconfig.tsserver.setup {}
      -- lua
      lspconfig.lua_ls.setup {}
    end
  },

  -- file manager, i think
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup({})
    end
  },

  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })
    end,
  },

  {
    'neoclide/coc.nvim',
    config = function()
      vim.notify = require("notify")
    end
  },

  -- fancy notifications
  'rcarriga/nvim-notify',
}
