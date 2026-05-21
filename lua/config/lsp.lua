local M = {}

function M.capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  return capabilities
end

function M.setup()
  local signs = {
    Error = "E",
    Warn = "W",
    Hint = "H",
    Info = "I",
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 2,
      source = "if_many",
    },
    float = {
      border = "rounded",
      source = "if_many",
    },
  })

  local lsp_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(event)
      local builtin = require("telescope.builtin")
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      local map = function(keys, func, desc, mode)
        vim.keymap.set(mode or "n", keys, func, {
          buffer = event.buf,
          desc = desc,
        })
      end

      map("gd", builtin.lsp_definitions, "Goto definition")
      map("gD", vim.lsp.buf.declaration, "Goto declaration")
      map("gr", builtin.lsp_references, "Goto references")
      map("gI", builtin.lsp_implementations, "Goto implementation")
      map("gt", builtin.lsp_type_definitions, "Goto type definition")
      map("K", vim.lsp.buf.hover, "Hover documentation")
      map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
      map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
      map("<leader>cf", function()
        local ok, conform = pcall(require, "conform")
        if ok then
          conform.format({ async = true, lsp_format = "fallback" })
        else
          vim.lsp.buf.format({ async = true })
        end
      end, "Format buffer")
      map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
      map("<leader>cD", builtin.diagnostics, "Workspace diagnostics")
      map("<leader>cs", builtin.lsp_document_symbols, "Document symbols")
      map("<leader>cS", builtin.lsp_workspace_symbols, "Workspace symbols")
      map("<leader>cl", "<cmd>LspInfo<cr>", "LSP info")
      map("<leader>cx", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols trouble")
      map("<leader>cX", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP trouble")
      map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
      map("]d", vim.diagnostic.goto_next, "Next diagnostic")

      if client and client.name == "clangd" then
        map("<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", "Switch source/header")
        map("<leader>ci", "<cmd>ClangdShowSymbolInfo<cr>", "Clangd symbol info")
      end

      if client and client.server_capabilities.documentHighlightProvider then
        local highlight_group = vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })

        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = event.buf,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })
end

return M
