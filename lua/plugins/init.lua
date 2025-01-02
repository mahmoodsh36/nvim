return {
  -- key guide
  'folke/which-key.nvim',

  -- popup choice list
  {
    "nvim-telescope/telescope.nvim",
    -- dependencies = {
    --   { "nvim-telescope/telescope-smart-history.nvim" },
    --   { "kkharji/sqlite.lua" }, -- required for telescope-smart-history
    -- },
    config = function()
      require("telescope").setup {
        defaults = {
          history = {
            path = '~/.telescope_history.sqlite3',
            limit = 10000000,
          }
        },
        -- extensions = {
        --   smart_history = {
        --     auto_prompt = true,
        --   },
        -- },
      }

      -- load the extension
      -- require("telescope").load_extension("smart_history")
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
      -- vim.o.background = "dark" -- or "light" for light mode
      -- vim.cmd([[colorscheme gruvbox]])
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
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- typescript, javascript
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }
      -- lua
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }
      -- python
      lspconfig.pylsp.setup {
        settings = {
          pylsp = {
            plugins = {
              -- formatter options
              -- black = { enabled = true },
              -- autopep8 = { enabled = false },
              -- yapf = { enabled = false },
              -- linter options
              -- pylint = { enabled = true, executable = "pylint" },
              -- pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              -- type checker
              -- pylsp_mypy = { enabled = true },
              -- auto-completion options
              -- jedi_completion = { fuzzy = true },
              -- import sorting
              pyls_isort = { enabled = true },
            },
          },
        },
        flags = {
          debounce_text_changes = 200,
        },
        capabilities = capabilities,
      }
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

  -- {
  --   'neoclide/coc.nvim',
  --   config = function()
  --     vim.notify = require("notify")
  --   end
  -- },

  -- fancy notifications
  'rcarriga/nvim-notify',

  -- autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-cmdline" },
      { "hrsh7th/cmp-buffer" },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require'luasnip'.lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users
        }, {
          { name = 'buffer' },
        }),
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require'luasnip'.expand_or_jumpable() then
              require'luasnip'.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require'luasnip'.jumpable(-1) then
              require'luasnip'.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
      })
      -- set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- you can specify the `cmp_git` source if you were using it
        }, {
          { name = 'buffer' },
        })
      })

      -- use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },

  -- better snippets
  -- 'SirVer/ultisnips',

  -- tree-sitter text objects
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,

            -- automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- you can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- you can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- you can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- you can choose the select mode (default is charwise 'v')
            --
            -- can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- if you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = { query = "@class.outer", desc = "Next class start" },
            --
            -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
            ["]o"] = "@loop.*",
            -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
            --
            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
          -- Below will go to either the start or the end, whichever is closer.
          -- Use if you want more granular movements
          -- Make it even more gradual by adding multiple queries and regex.
          goto_next = {
            ["]d"] = "@conditional.outer",
          },
          goto_previous = {
            ["[d"] = "@conditional.outer",
          }
        },
        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      }
    end
  },

  -- remove highlighting after search
  'romainl/vim-cool',

  -- a collection of utility lua functions
  -- 'nvim-lua/plenary.nvim',

  'nvim-tree/nvim-web-devicons',

  -- git changes highlighting
  -- 'lewis6991/gitsigns.nvim',

  -- TUI library
  -- 'MunifTanjim/nui.nvim',

  -- indent guides
  'lukas-reineke/indent-blankline.nvim',

  -- set of predefined snippets
  -- 'rafamadriz/friendly-snippets',

  -- auto insert pairs
  -- 'windwp/nvim-autopairs',

  -- 
  'folke/trouble.nvim',

  -- 
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- code formatting
  'stevearc/conform.nvim',

  -- improve builtin UIs using fzf, telescope and more
  'stevearc/dressing.nvim',

  -- 
  'sindrets/diffview.nvim',

  -- "UI for Neovim notifications and LSP progress messages"
  'j-hui/fidget.nvim',

  -- tree fs manager
  'nvim-neo-tree/neo-tree.nvim',

  -- highlight current line
  'akinsho/bufferline.nvim',

  -- 'onsails/lspkind.nvim'

  -- code navigation with labels
  'folke/flash.nvim',

  -- reset comment string based on cursor location
  'JoosepAlviste/nvim-ts-context-commentstring',

  -- code folding
  'kevinhwang91/nvim-ufo',

  -- magit-like git client
  'NeogitOrg/neogit',

  -- colorize text representing colors, e.g. #f00
  'NvChad/nvim-colorizer.lua',

  -- a theme
  'rebelot/kanagawa.nvim',

  -- generate annotations (code docstrings)
  {
    'danymat/neogen',
    config = true,
  },

  -- rainbow delimiters
  'HiPhish/rainbow-delimiters.nvim',

  {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },

  -- pretty good-looking dark theme
  {
    "xero/miasma.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme miasma")
    end,
  },

  {
    'comfysage/evergarden',
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      transparent_background = true,
      contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
      overrides = { }, -- add custom overrides
    }
  },

  {
      'b0o/incline.nvim',
      config = function()
          require('incline').setup()
      end,
      -- Optional: Lazy load Incline
      event = 'VeryLazy',
  },
}