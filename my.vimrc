set number
set encoding=utf-8
syntax on

" Set split direction
set splitbelow
set splitright

" show whitespace characters
set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:·

let python_highlight_all=1
let mapleader = " "

" Vundle stuff begins
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'prashanthellina/follow-markdown-links'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Vundle stuff ends


" remap keys for split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable code folding
set foldmethod=indent
set foldlevel=99

" remap key for folding/unfolding
nnoremap <space> za

" see docstrings of folded code
let g:SimpylFold_docstring_preview=1

" PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" HTML/CSS/JS files
au BufNewFile,BufRead *.js,*.html,*.css,*.jsx
     \ set tabstop=2
     \ softtabstop=2
     \ shiftwidth=2
     \ expandtab

" Flag unnecessary whitespace
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/

" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" Ignore files in 'venv' and '__pycache__' dirs in ctrl-p
let g:ctrlp_custom_ignore = '\v(venv|__pycache__)'

" nerdtree mappings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" set up powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set t_Co=256
set laststatus=2

" resizing windows
nnoremap <leader>. <C-w>>
nnoremap <leader>, <C-w><
nnoremap <leader>m <C-w>-
nnoremap <leader>k <C-w>+

" set powerline font for gui vim
set guifont=Source\ Code\ Pro\ for\ Powerline:h14

" Markdown support for Obsidian vault
" export KB_DIRECTORY=/path/to/obsidian/vault
au BufNewFile,BufRead *.md setlocal filetype=markdown
au BufRead,BufNewFile $KB_DIRECTORY* setlocal path+=**
set suffixesadd+=.md
" open [[wikilinks]]
nnoremap <leader>z F[lvt]gf
" open [[renamed wikilinks|cool links]]
nnoremap <leader>x F[lvt<bar>gf

