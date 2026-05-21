return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown" },
      heading = {
        enabled = true,
        sign = false,
      },
      checkbox = {
        enabled = true,
      },
      bullet = {
        enabled = true,
      },
      code = {
        sign = false,
        width = "block",
      },
      dash = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown" },
    config = function()
      require("autolist").setup()

      local group = vim.api.nvim_create_augroup("UserMarkdownAutolist", { clear = true })

      local function on_markdown(bufnr)
        local autolist = require("autolist")

        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
        vim.opt_local.conceallevel = 2

        local map = function(mode, lhs, rhs, desc, extra)
          local opts = vim.tbl_extend("force", {
            buffer = bufnr,
            desc = desc,
          }, extra or {})
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("i", "<Tab>", "<cmd>AutolistTab<cr>", "Markdown list indent")
        map("i", "<S-Tab>", "<cmd>AutolistShiftTab<cr>", "Markdown list outdent")
        map("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>", "Markdown new list item")
        map("n", "o", "o<cmd>AutolistNewBullet<cr>", "Markdown open list item below")
        map("n", "O", "O<cmd>AutolistNewBulletBefore<cr>", "Markdown open list item above")
        map("n", "<leader>mc", "<cmd>AutolistToggleCheckbox<cr>", "Markdown toggle checkbox")
        map("n", "<leader>mf", function()
          require("conform").format({
            async = true,
            lsp_format = "never",
          })
        end, "Markdown format buffer")
        map("n", "<leader>mr", "<cmd>AutolistRecalculate<cr>", "Markdown recalculate list")
        map("n", "<leader>mn", autolist.cycle_next_dr, "Markdown next list style", { expr = true })
        map("n", "<leader>mN", autolist.cycle_prev_dr, "Markdown previous list style", { expr = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "markdown",
        callback = function(event)
          on_markdown(event.buf)
        end,
      })

      if vim.bo.filetype == "markdown" then
        on_markdown(vim.api.nvim_get_current_buf())
      end
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_page_title = "${name}"
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview" },
      { "<leader>mP", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown preview stop" },
    },
  },
}
