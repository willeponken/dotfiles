" Muh Neovim config
"  - willeponken anno. 2018
"
" Dependencies:
"  * ctags
"
" Good To Know:
"  * Update plugins :PlugUpdate!
"  * Upgrade vim-plug :PlugUpgrade!
"
" Keybindings:
"  <C-n> File tree
"
"  <C-t> Tagbar
"
"  <C-f> Fuzzy finder
"  	<C-t> Tab split
"  	<C-x> Split
"  	<C-v> Vertical split
"
"  <C-Space> Toggle auto completion
"
"  <C-a> Accept snippet suggestion
"
" Copyright (C) 2018 High On Coffee Ltd

call plug#begin('~/.config/nvim/plugins')

" Sensible defaults
Plug 'tpope/vim-sensible'

" File tree
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '<'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" I don't really use <C-f> (page down) anyways
map <C-f> :FZF<CR>

" Go tools
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Tagbar
Plug 'majutsushi/tagbar'
map <C-t> :TagbarToggle<CR>

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' " Some default snippets
let g:UltiSnipsExpandTrigger="<C-a>" " <C-a> to accept snippet

" Airline/powerline
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 0 " Disable powerline fonts
let g:airline_symbols = {
\	'paste': 'PASTE',
\ 	'spell': 'SPELL',
\ 	'readonly': 'RO',
\ 	'whitespace': '!',
\ 	'linenr': 'ln',
\ 	'maxlinenr': '',
\ 	'branch': '',
\ 	'notexists': '?',
\ 	'modified': '+',
\ 	'space': ' ',
\ 	'crypt': 'cr'}

" Airline themes
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='solarized'

" Solarized colors
Plug 'altercation/vim-colors-solarized'

" So I can git praise people
Plug 'tpope/vim-fugitive'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitelines_at_eof = 1

" Autocompletion/linting
Plug 'w0rp/ale'
let g:ale_completion_enabled = 1
let g:ale_linters = {
\	'python': ['flake8'],
\	'cpp': ['gcc'],
\	'c': ['gcc']
\}
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'python': ['isort'],
\	'cpp': ['clang-format'],
\	'c': ['clang-format']
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

" Jump to previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" Jump to next error
nmap <silent> <C-j> <Plug>(ale_next_wrap)

call plug#end()

" Enable 256 color mode for VIM (Neovim ignores this)
set t_Co=256

" Enable mouse scrolling
set mouse=a

" Auto write before :next and :make
set autowrite

" Line numbers
set number relativenumber
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Wordwrap
set textwidth=80
autocmd Filetype python setlocal textwidth=120

" Solarized
set background=dark
colorscheme solarized
set cursorline
set colorcolumn=+1

" Load all plugins before loading tags
packloadall
" Generate helptags (silently)
silent! helptags ALL
