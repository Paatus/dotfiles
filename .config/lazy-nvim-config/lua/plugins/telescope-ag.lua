return {
    "kelly-lin/telescope-ag",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
        local telescope_ag = require("telescope-ag")
        telescope_ag.setup({
            cmd = telescope_ag.cmds.rg, -- defaults to telescope_ag.cmds.ag
        })
    end
}
