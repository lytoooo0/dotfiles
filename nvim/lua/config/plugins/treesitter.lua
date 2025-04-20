return {
   "nvim-treesitter/nvim-treesitter",
   build = function()
       require("nvim-treesitter.install").update({ with_sync = true} )()
   end,
   opts = {
       ensure_installed = {
	   "lua",
	   "python",
	   "tex",
       },
   },
}
