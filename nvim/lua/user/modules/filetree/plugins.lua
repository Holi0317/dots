local plugin = require("user.pack").register_plugin

plugin({
  "kyazdani42/nvim-tree.lua",
  requires = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
 require("user.modules.filetree.config").nvimtree()
  end
})
