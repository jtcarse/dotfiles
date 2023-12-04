--disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--set colors
vim.opt.termguicolors = true

--use vim settings where applicable
vim.cmd('set runtimepath+=~/.vim')
vim.cmd('let &packpath = &runtimepath')
vim.cmd('source ~/.vimrc')

--bootstrap lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--load plugins
require('lazy').setup('plugins')
require('nvim-tree').setup({
  view = { width = 50 },
  actions = {
    open_file = { resize_window = true },
  },
})

--require colorschemes
require('monokai-pro').setup()
require('nvim-juliana').setup()

--set colorscheme
vim.cmd('colorscheme kanagawa-wave')

--treesitter
require('nvim-treesitter.configs').setup({
  highlight = { enable = true },
})

--indent
require('ibl').setup()

--LSPs
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({ autostart = true }) --enable python LSP
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    --enable completion with <C-x><C-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    --buffer local mappings
    local opts = { buffer = ev.buf }

    --keybinds
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'R', vim.lsp.buf.rename, opts)
  end,
})

--neovim specific mappings
vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>')
vim.keymap.set('i', '<C-n>', '<C-x><C-o>')

--no mouse
vim.opt.mouse = ''

vim.cmd('autocmd VimEnter * doautocmd FileType')
