return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
  },
  config = function()
    -- Search Files
    vim.keymap.set("n", "<C-p>", require("fzf-lua").files, {desc = "Files"})
    vim.keymap.set("n", "<leader>pf", require("fzf-lua").files, {desc = "Files"})

    -- Search Contents
    vim.keymap.set("n", "<leader>pg", require("fzf-lua").live_grep_native, {desc = "Grep"})

  end
}
