local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require('lspconfig')

-- Perl
lspconfig.perlnavigator.setup{
    settings = {
        perlnavigator = {
            perlimportsLintEnabled = true,
            perlimportsTidyEnabled = true,
            includePaths = {"t/lib"},
        }
    }
}

-- Lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    }
  }
}

-- TypeScript
lspconfig.ts_ls.setup {}
lspconfig.biome.setup {
  cmd = { "bunx", "biome", "lsp-proxy" }
}

lspconfig.tailwindcss.setup {}

-- Go
lspconfig.gopls.setup {}

-- Rust
-- Ref: https://rust-analyzer.github.io/manual.html#nvim-lsp
lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

-- misc
lspconfig.efm.setup{
  -- SEE ALSO: .config/efm-langserver/config.yaml
  filetypes = { 'graphql', 'markdown', 'javascript' },
}

lspconfig.yamlls.setup {
  settings = {
    yaml = {
      validate = true,
      -- disable the schema store
      schemaStore = {
        enable = false,
        url = "",
      },
      -- manually select schemas
      schemas = {
        ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] = 'docker-compose*.{yml,yaml}',
        ['https://raw.githubusercontent.com/skaji/cpmfile/main/jsonschema.json'] = 'cpm.yml'
      }
    }
  }
}

lspconfig.jsonls.setup {
  cmd = { "vscode-json-languageserver", "--stdio" },
  capabilities = capabilities,
  filetypes = {"json", "jsonc"},
  settings = {
    json = {
      schemas = {
        {
            fileMatch = {"package.json"},
            url = "https://json.schemastore.org/package.json"
        },
        {
            fileMatch = {"tsconfig*.json"},
            url = "https://json.schemastore.org/tsconfig.json"
        },
      }
    }
  },
}

lspconfig.typos_lsp.setup({
  init_options = {
    config = '~/.config/typos.toml',
  },
})


