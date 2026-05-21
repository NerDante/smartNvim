return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {
      n_lines = 200,
      search_method = "cover_or_next",
    },
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      npairs.setup(opts)

      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "Mr-LLLLL/interestingwords.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      search_count = true,
      navigation = true,
      scroll_center = true,
      search_key = "<leader>mm",
      cancel_search_key = "<leader>mM",
      color_key = "<leader>mk",
      cancel_color_key = "<leader>mK",
      select_mode = "loop",
    },
    config = function(_, opts)
      require("interestingwords").setup(opts)
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", gs.next_hunk, "Next hunk")
        map("n", "[h", gs.prev_hunk, "Previous hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gb", gs.blame_line, "Blame line")
      end,
    },
  },
}
