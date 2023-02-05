local M = {}

function M.treesitter()
  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
      -- vim
      "lua",
      "vim",

      -- MD
      "markdown",
      "markdown_inline",

      -- Webs
      "javascript",
      "jsdoc",
      "typescript",
      "vue",
      "html",
      "css",
      "scss",

      -- Config languages
      "json",
      "json5",
      "jsonc",
      "yaml",
      "toml",

      "go",
      "gomod",
      "python",
      "regex",
      "sql",
      "bash",
      "c",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    -- ==== Module settings ====
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
      -- Some language indentation is broken
      disable = {},
    },

    textobjects = {
      swap = {
        enable = false,
        -- swap_next = textobj_swap_keymaps,
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",

          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          ["a,"] = "@parameter.outer",
          ["i,"] = "@parameter.inner",

          ["a/"] = "@comment",
          ["i/"] = "@comment.inner",

          ["ax"] = "@htmlattr.outer",
          ["ix"] = "@htmlattr.inner",
        },
      },
    },

    autotag = {
      enable = true,
    },

    playground = {
      enable = true
    },

    pairs = {
      enable = true,
      keymaps = {
        goto_partner = "%",
      },
    },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    }
  }


  require("treesitter-context").setup()

  -- Enable folding with treesitter
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevelstart = 99

end

function M.spellsitter()
  require('spellsitter').setup()
end

return M
