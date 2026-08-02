local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Perl
vim.lsp.config('perlnavigator', {
    settings = {
        perlnavigator = {
            perlimportsLintEnabled = true,
            perlimportsTidyEnabled = true,
            includePaths = {"t/lib"},
            perlcriticProfile = './.perlcriticrc',
            perltidyProfile = './.perltidyrc',
        }
    }
})

-- Lua
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    }
  }
})

-- TypeScript
vim.lsp.config('ts_ls', {})
vim.lsp.config('biome', {
  cmd = { "bunx", "biome", "lsp-proxy" }
})

vim.lsp.config('tailwindcss', {})

-- Go
vim.lsp.config('gopls', {})

-- Rust
-- Ref: https://rust-analyzer.github.io/manual.html#nvim-lsp
vim.lsp.config('rust_analyzer', {
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

-- Python
vim.lsp.config('pylsp', {})

-- misc
vim.lsp.config('efm', {
  -- SEE ALSO: .config/efm-langserver/config.yaml
  filetypes = { 'graphql', 'markdown', 'javascript' },
})

vim.lsp.config('yamlls', {
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
})

vim.lsp.config('jsonls', {
  cmd = { "vscode-json-language-server", "--stdio" },
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
})

vim.lsp.config('typos_lsp', {
  init_options = {
    config = '~/.config/typos.toml',
  },
})

vim.lsp.enable({
  'perlnavigator',
  'lua_ls',
  'ts_ls',
  'biome',
  'tailwindcss',
  'gopls',
  'rust_analyzer',
  'pylsp',
  'efm',
  'yamlls',
  'jsonls',
  'typos_lsp',
})
