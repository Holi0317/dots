require("user.lsp").setup("yamlls", {
	override = {
		settings = {
			yaml = {
				hover = true,
				completion = true,
				validate = true,
				customTags = { "!vault" },
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
			},
		},
	},
})

-- This only loads in ft=yaml.ansible
require("user.lsp").setup("ansiblels")
