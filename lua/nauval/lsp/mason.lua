local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
mason_lspconfig.setup({
  automatic_installation = true,
  ensure_installed = { "lua_ls", "jsonls", "tsserver", "tailwindcss" },
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

mason_lspconfig.setup_handlers({
  -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
  function(server_name)
    local opts = {
      on_attach = require("nauval.lsp.handlers").on_attach,
      capabilities = require("nauval.lsp.handlers").capabilities,
    }

    if server_name == "emmet_ls" then
      local emmetls_opts = require("nauval.lsp.settings.emmetls")
      opts = vim.tbl_deep_extend("force", emmetls_opts, opts)
    end
    if server_name == "jsonls" then
      local jsonls_opts = require("nauval.lsp.settings.jsonls")
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end
    if server_name == "lua_ls" then
      local lua_ls_opts = require("nauval.lsp.settings.lua_ls")
      opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
    end
    if server_name == "tailwindcss" then
      local tailwindcss_opts = {
        settings = {
          tailwindCSS = {
            experimental = {
              -- for CVA
              classRegex = {
                "cva\\(([^)]*)\\)",
                "[\"'`]([^\"'`]*).*?[\"'`]",
              },
            },
          },
        },
      }
      opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
    end

    lspconfig[server_name].setup(opts)
  end,
})
