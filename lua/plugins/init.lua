-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- lsp related
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            {
                'folke/neodev.nvim',
                config = function()
                    -- Setup neovim lua configuration
                    require('neodev').setup()
                end
            },
        },
        config = function()
            require "plugins.config.lspconfig"
            vim.diagnostic.disable()
        end
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',

            'hrsh7th/cmp-buffer',
            'ray-x/cmp-treesitter',
        },
        opts = function()
            return require "plugins.config.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim',  opts = {} },
    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },
    },

    {
        -- Theme inspired by Atom
        'navarasu/onedark.nvim',
        priority = 1000,
        config = function()
            require('onedark').setup {
                --   Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                style = 'dark',
                code_style = {
                    comments = 'italic',
                    keywords = 'bold',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },
            }
            vim.cmd.colorscheme 'onedark'
        end,
    },

    {
        'sainnhe/gruvbox-material',
        -- config = function()
        --     vim.cmd.colorscheme 'gruvbox-material'
        -- end,

    },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'onedark',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help indent_blankline.txt`
        opts = {
            char = '┊',
            show_trailing_blankline_indent = false,
        },
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = function()
            return require "plugins.config.telescope"
        end,
        config = function(_, opts)
            require("telescope").setup(opts)
            require('telescope').load_extension('fzf') 
        end
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },

    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
        opts = function()
            return require "plugins.config.treesitter"
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },


    {
        "phaazon/hop.nvim",
        config = function()
            require("hop").setup()
        end,
    },

    {
        "max397574/better-escape.nvim",
        lazy = true,
        event = { "InsertEnter" },
        config = function()
            require("better_escape").setup({
                mapping = { "jk", "jl" },
                timeout = 200,
                clear_empty_lines = false,
                keys = "<Esc>",
            })
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        opts = function()
            return require "plugins.config.symbols-outline"
        end,
        config = function(_, opts)
            require("symbols-outline").setup(opts)
        end,
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },

    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            icons = {
                buffer_index = true,
                button = '',
            }
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    {
        'Mr-LLLLL/interestingwords.nvim',
        config = function()
            require('interestingwords').setup {
                search_count = true,
                navigation = true,
                search_key = "<Nop>",
                cancel_search_key = "<Nop>",
                color_key = "<leader>m",
                cancel_color_key = "<leader>M",
            }
        end
    },

    {
        'mhinz/vim-startify',
        config = function()
            vim.cmd([[
                let g:startify_session_persistence = 1
                let g:startify_lists = [
                 \ { 'type': 'sessions',  'header': ['   Saved Sessions'] },
                 \ { 'type': 'files',     'header': ['   Recent files']   },
                 \ ]
            ]])
        end
    },

    -- transparent
    {
        'xiyaowong/transparent.nvim',
    },

}, {})
