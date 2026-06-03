return {
  {
    "olimorris/persisted.nvim",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      autostart = true,
      autoload = true,
      use_git_branch = false,
      ignored_dirs = {
        "~/",
        "~/Downloads",
        "/",
      },
      should_save = function()
        local bufs = vim.tbl_filter(function(buf)
          if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted then
            return false
          end
          if vim.bo[buf].buftype ~= "" then
            return false
          end
          if vim.tbl_contains({ "alpha", "checkhealth" }, vim.bo[buf].filetype) then
            return false
          end
          return vim.api.nvim_buf_get_name(buf) ~= ""
        end, vim.api.nvim_list_bufs())

        return #bufs > 0
      end,
      telescope = {
        reset_prompt_after_deletion = true,
      },
    },
    keys = {
      {
        "<leader>ss",
        "<cmd>Telescope persisted<cr>",
        desc = "Search sessions",
      },
      {
        "<leader>sr",
        "<cmd>Persisted load<cr>",
        desc = "Restore session",
      },
      {
        "<leader>sd",
        "<cmd>Persisted delete_current<cr>",
        desc = "Delete session",
      },
      {
        "<leader>sw",
        "<cmd>Persisted save<cr>",
        desc = "Write session",
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      pcall(require("telescope").load_extension, "persisted")
    end,
  },
}
