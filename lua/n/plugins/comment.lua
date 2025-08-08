return {
	"numToStr/Comment.nvim",
	config = function()
		require("Comment").setup()
    local ft = require('Comment.ft')
	end,
	opts = {
		-- add any options here
	},
}
