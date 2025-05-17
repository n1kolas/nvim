vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true -- tab to space
opt.autoindent = true

opt.wrap = false

-- search
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

---

-- Enable mouse mode.
vim.o.mouse = "a"

-- Disable horizontal scrolling.
vim.o.mousescroll = "ver:3,hor:0"

-- Wrap long lines at words.
vim.o.linebreak = true

-- Sync clipboard between the OS and Neovim.
vim.o.clipboard = "unnamedplus"

-- Save undo history.
vim.o.undofile = true

-- Update times and timeouts.
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 10

-- Completion.
vim.opt.wildignore:append({ ".DS_Store" })
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 15

-- Diff mode settings.
-- Setting the context to a very large number disables folding.
vim.opt.diffopt:append("vertical,context:99")

vim.opt.shortmess:append({
	w = true,
	s = true,
})

-- Status line.
vim.o.laststatus = 3
vim.o.cmdheight = 1

-- Don't change background color on active / inactive state.
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*", -- Apply to all colorschemes
	group = vim.api.nvim_create_augroup("NoDimInactive", { clear = true }), -- Create a group for clarity
	callback = function()
		-- Link NormalNC to Normal
		vim.api.nvim_set_hl(0, "NormalNC", { link = "Normal" })
		-- Optional: You might also want to do this for line numbers in inactive windows
		vim.api.nvim_set_hl(0, "SignColumnNC", { link = "SignColumn" }) -- If using Neovim >= 0.9
	end,
})

-- Allow CTRL+(j,k) to work from Terminal when in Terminal mode.
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", {
	noremap = true,
	silent = true,
	desc = "Terminal: Exit and move window down",
})
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", {
	noremap = true,
	silent = true,
	desc = "Terminal: Exit and move window up",
})

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", {}),
	desc = "Hightlight selection on yank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
	end,
})
