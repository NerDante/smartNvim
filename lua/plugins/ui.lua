return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>m", group = "mark/md" },
        { "<leader>s", group = "session" },
        { "<leader>t", group = "theme" },
        { "<leader>w", group = "window" },
        { "<leader>x", group = "diagnostics" },
      },
      win = {
        border = "rounded",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "|",
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        mode = "buffers",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      focus = false,
      follow = true,
      auto_preview = true,
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    opts = {
      auto_close = false,
      auto_preview = false,
      position = "right",
      relative_width = true,
      width = 22,
      show_symbol_details = true,
    },
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  _   _           _         _                         ",
        " | \\ | | ___  ___| |__   __| | ___  _ __ ___          ",
        " |  \\| |/ _ \\/ _ \\ '_ \\ / _` |/ _ \\| '__/ _ \\         ",
        " | |\\  |  __/  __/ |_) | (_| | (_) | | |  __/         ",
        " |_| \\_|\\___|\\___|_.__/ \\__,_|\\___/|_|  \\___|         ",
        "                                                     ",
        "          C/C++   Python   Lua   Session-aware        ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "  New File", "<cmd>ene <bar> startinsert<cr>"),
        dashboard.button("f", "󰈞  Find File", "<cmd>Telescope find_files hidden=true<cr>"),
        dashboard.button("r", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "󰈬  Live Grep", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("s", "  Select Session", "<cmd>lua require('config.session_picker').select()<cr>"),
        dashboard.button("l", "󰁯  Restore Last Session", "<cmd>lua require('persistence').load({ last = true })<cr>"),
        dashboard.button("c", "  Edit Config", "<cmd>edit ~/.config/nvim/init.lua<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.section.footer.val = "Session-aware workspace launcher"
      dashboard.opts.layout[1].val = 6

      local function set_alpha_hl()
        vim.api.nvim_set_hl(0, "AlphaHeader", { link = "Type" })
        vim.api.nvim_set_hl(0, "AlphaButtons", { link = "Function" })
        vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "Keyword" })
        vim.api.nvim_set_hl(0, "AlphaFooter", { link = "Comment" })
      end

      set_alpha_hl()

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("alpha_dashboard_theme", { clear = true }),
        callback = set_alpha_hl,
      })

      alpha.setup(dashboard.opts)

      local function refresh_alpha_footer()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        dashboard.section.footer.val = "Loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"

        if vim.bo.filetype ~= "alpha" then
          return
        end

        local ok, alpha = pcall(require, "alpha")
        if ok then
          pcall(alpha.redraw)
        end
      end

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = refresh_alpha_footer,
      })

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "VeryLazy",
        callback = refresh_alpha_footer,
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
  },
}
