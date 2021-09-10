" 4 space tabs
set number relativenumber
autocmd BufWinEnter,BufRead * set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Set cursor modes
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

" Update cursor when entering/leaving vim
augroup myCmds
au!
autocmd VimEnter * silent !echo -e "\e[2 q"
autocmd VimLeave * silent !echo -e "\e[6 q"
augroup END

" No delay pressing escape to leave insert mode
set timeoutlen=1000
set ttimeoutlen=50

" Autoindent
set autoindent
set smartindent

" Search highlighting
set hls is
nnoremap \<CR> :let @/ = ""<CR>:<Del>
set nowrapscan

" Commands to run current file as a language
command Cp %y+
command -nargs=* C w | !execc % <args>
command -nargs=* Cpp w | !execcpp % <args>
command -nargs=* Rust w | !execrust % <args>
command -nargs=* Hask w | !exechask % <args>
command -nargs=* Haski w | !ghci % <args>
command -nargs=* Stk w | !stack --silent ghci % <args>
command -nargs=* Go w | !go run % <args>
command -nargs=* Node w | !node % <args>
command -nargs=* Nodei w | !nodei % <args>
command -nargs=* Py w | !python3 % <args>
command -nargs=* Py2 w | !python2 % <args>
command -nargs=* Pyi w | !python3 -i % <args>
command -nargs=* Py2i w | !python2 -i % <args>
command -nargs=* Bash w | !bash % <args>
command -nargs=* Sh w | !Sh % <args>
command -nargs=* Exec w | !./% <args>

" Quality of life
set mouse-=a
set formatoptions-=cro
autocmd BufWinEnter,BufRead * setlocal formatoptions-=cro
command Pa set paste
command Npa set nopaste
autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))

" Clipboard
vnoremap <C-c> "+y
map <C-p> "+p

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'kaicataldo/material.vim'
Plug 'itchyny/lightline.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
Plug 'stevearc/vim-arduino'
call plug#end()

" Theme
syntax enable
colorscheme material
let g:material_theme_style='palenight'
let g:material_terminal_italics=1
autocmd BufWinEnter,BufRead * highlight LineNr ctermfg=white

" Lightline
set laststatus=2
set t_Co=256
let g:lightline={
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'arduino'] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \   'arduino': 'ArduinoStatus'
    \ },
    \ }

" Haskell-vim
syntax on
filetype plugin indent on
let g:haskell_indent_before_where=4
let g:haskell_indent_after_bare_where=4
let g:haskell_indent_guard=4
let g:haskell_indent_case=4
let g:haskell_indent_if=4

" Vim-CPP-enhanced-highlight
let g:cpp_class_scope_highlight=1
let g:cpp_member_variable_highlight=1
let g:cpp_class_decl_highlight=1
let g:cpp_posix_standard=1
let g:cpp_experimental_template_highlight=1
let g:cpp_concepts_highlight=1
let c_no_curly_error=1
