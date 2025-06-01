-- JoosepAlviste/nvim-ts-context-commentstring: Skip compatibility check
vim.g.skip_ts_context_commentstring_module = true

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
			"nvim-treesitter/playground",
			"theHamsta/nvim-treesitter-pairs",
			"adelarsq/vim-matchit", -- Required by pairs
			"nvim-treesitter/nvim-treesitter-context",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			vim.treesitter.language.register("markdown", "mdx")

			local ts = require("nvim-treesitter")

			ts.install({
				-- vim
				"lua",
				"luadoc",
				"vim",
				"vimdoc",

				-- MD
				"markdown",
				"markdown_inline",
				"mermaid",

				-- Webs
				"javascript",
				"jsdoc",
				"typescript",
				"tsx",
				"vue",
				"html",
				"css",
				"scss",
				"prisma",
				"astro",

				-- Config languages
				"json",
				"json5",
				"jsonc",
				"yaml",
				"toml",
				"dockerfile",
				"hcl",
				"terraform",
				"scheme",
				"ini",

				-- C
				"c",
				"cpp",
				"cmake",
				"make",

				-- Go
				"go",
				"gomod",

				-- PHP
				"php",
				-- "phpdoc",  -- This is causing problem with installing on aarch darwin

				-- Git
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",

				-- Rust
				"rust",

				"comment",
				"c_sharp",
				"python",
				"regex",
				"sql",
				"bash",
				"nu",
				"typst",
			})

			-- Highlighting module
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					vim.treesitter.start()
				end,
			})

			-- Enable indention
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

			require("nvim-treesitter").install({
				-- ==== Module settings ====
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
					enable = true,
				},

				pairs = {
					enable = true,
					keymaps = {
						goto_partner = "%",
					},
				},
			})

			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})

			require("treesitter-context").setup({
				max_lines = 5,
			})

			-- Enable folding with treesitter
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			vim.o.foldlevelstart = 99
		end,
	},
}
