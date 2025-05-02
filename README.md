# Neovim config

## Requirements
There's a high chance this isn't complete.

- cargo (for building Drupal LS)
- go (for go language support), gofmt, goimports
- stylua (for formatting Lua)
- phpcbf
- rustup
- rust-analyzer (for Rust language support)
- intelephense (for PHP language support)
- fzf (for Fuzzy finder)
- vscode-php-debug (for debugging PHP: **Careful hardcoded path in dap.lua**)

## Installation
```
cd $HOME/.config
git clone git@github.com:n1kolas/nvim.git .nvim
```

Open up neovim `nvim .` and use `:Lazy` if necessary, which should autoinstall plugins.

## Keybinds
Non-exhaustive list of keybinds.

- `<leader>` is the Space key

### Finder
- Filenames: `<leader>pf` or `CTRL+P`
- Grep: `<leader>pg`

### LSP & Completion
- `Shift+K` Hover definition
- `<leader>gd` Go to definition
- `<leader>gr` Show references
- `CTRL+n/p` selecting auto completion
- `CTRL+y` confirming auto completion
- `<leader>aa` show PHP Symbols (Aerial)

### Showing errors/warnings
- `<leader>tt` Toggle Trouble Window

### Terminal
- `<leader>st` Toggle Terminal

### Formatting
- `<leader>f` to Format.
- `<leader>do` to generate Doc Block.

### Debugging
- `<leader>du` to toggle Debug UI
- `<leader>b` to toggle breakpoint
- `F1` to start debugging
- `F2` Step over
- `F3` Step into
- `<leader>?` show variable content

### Harpoon (Quick File Access)
- `<leader>ha` to add to harpoon
- `<leader>hl` to show harpoon list
- `<leader>{1,2,3,4,5,6,7,8,9}` to switch between harpooned files

### Multi Select
- `CTRL+n` after selecting word to select duplicate occurences

