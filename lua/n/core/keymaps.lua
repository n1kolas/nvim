vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights " })

-- window management
-- keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
-- keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ bufnr = 0 })
end)

-- snips
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

vim.keymap.set("n", "<leader>ef", 'oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\\n", err.Error())<Esc>jj')

vim.keymap.set("n", "<leader>el", 'oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i')

vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv") -- move line down(v)

vim.keymap.set("n", "<C-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>do", ":lua require('neogen').generate()<CR>", opts)

vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true, nowait = true })

-- Terminal
local set = vim.opt_local
-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		set.number = false
		set.relativenumber = false
		set.scrolloff = 0

		vim.bo.filetype = "terminal"
	end,
})

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>st", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end)

vim.keymap.set("n", "-", "<cmd>Oil<CR>")

-- quickfix
vim.keymap.set("n", "<C-S-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<C-S-k>", "<cmd>cprev<CR>")
