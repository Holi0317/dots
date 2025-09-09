return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		config = function()
			vim.treesitter.language.register("markdown", "mdx")

			require("nvim-treesitter").install({
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

			vim.api.nvim_create_autocmd("FileType", {
				-- pattern = { "<filetype>" },
				callback = function()
					-- Ignore error if language don't have treesitter with pcall
					pcall(vim.treesitter.start)
				end,
			})

			-- Enable folding with treesitter
			vim.o.foldmethod = "expr"
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.o.foldlevelstart = 99

			-- Indent with treesitter
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
				},
			})

			local function mkkeymap(key, selector)
				vim.keymap.set({ "x", "o" }, key, function()
					require("nvim-treesitter-textobjects.select").select_textobject(selector, "textobjects")
				end)
			end

			mkkeymap("af", "@function.outer")
			mkkeymap("if", "@function.inner")

			mkkeymap("ac", "@class.outer")
			mkkeymap("ic", "@class.inner")

			mkkeymap("a,", "@parameter.outer")
			mkkeymap("i,", "@parameter.inner")

			mkkeymap("a/", "@comment")
			mkkeymap("i/", "@comment.inner")

			mkkeymap("ax", "@htmlattr.outer")
			mkkeymap("ix", "@htmlattr.inner")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				max_lines = 5,
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
		end,
	},
}
