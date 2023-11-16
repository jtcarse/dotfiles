"settings
syntax on
set number
set autoindent
set showtabline=2
set splitright
set splitbelow

"tabs and spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

"keybinds
""leader
nnoremap <SPACE> <Nop>
let mapleader=" "
""change mode
inoremap jk <esc>

""change pane
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

""move pane
nnoremap <leader><S-h> <C-w><S-h>
nnoremap <leader><S-j> <C-w><S-j>
nnoremap <leader><S-k> <C-w><S-k>
nnoremap <leader><S-l> <C-w><S-l>

""arbitrary filetype stuff
au BufReadPost *.yaml set syntax=gotpl
au BufNewFile,BufRead Jenkinsfile setf groovy
