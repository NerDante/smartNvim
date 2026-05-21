return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        cuda = { "clang-format" },
        cmake = { "cmake_format" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "isort", "black" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local executable = vim.fn.executable

      local function available(...)
        local linters = {}
        for _, item in ipairs({ ... }) do
          if executable(item.cmd) == 1 then
            table.insert(linters, item.name)
          end
        end
        return linters
      end

      lint.linters_by_ft = {
        c = available(
          { name = "clangtidy", cmd = "clang-tidy" },
          { name = "cppcheck", cmd = "cppcheck" }
        ),
        cpp = available(
          { name = "clangtidy", cmd = "clang-tidy" },
          { name = "cppcheck", cmd = "cppcheck" }
        ),
        python = available({ name = "ruff", cmd = "ruff" }),
        cmake = available({ name = "cmakelint", cmd = "cmakelint" }),
        markdown = available({ name = "markdownlint-cli2", cmd = "markdownlint-cli2" }),
      }

      local group = vim.api.nvim_create_augroup("UserLinting", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          local names = lint._resolve_linter_by_ft(vim.bo.filetype)
          if names and #names > 0 then
            lint.try_lint(names)
          end
        end,
      })
    end,
  },
}
