return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>sl",
        function()
          require("persistence").load()
        end,
        desc = "Load session",
      },
      {
        "<leader>sL",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Load last session",
      },
      {
        "<leader>ss",
        function()
          require("config.session_picker").select()
        end,
        desc = "Select session",
      },
      {
        "<leader>sd",
        function()
          require("persistence").stop()
        end,
        desc = "Stop session save",
      },
    },
  },
}
