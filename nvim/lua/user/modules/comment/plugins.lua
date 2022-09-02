local plugin = require("user.pack").register_plugin

plugin({
  "numToStr/Comment.nvim",
  config = function()
    require("user.modules.comment.config").comment()
  end
})
