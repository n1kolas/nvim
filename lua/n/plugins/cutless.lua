return {
	"gbprod/cutlass.nvim",
	opts = {},
  config = function()
    require("cutlass").setup({
      cut_key = "m"
    })
  end
}
