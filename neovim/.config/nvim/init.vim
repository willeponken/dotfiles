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
let g:go_version_warning = 0
let g:go_fmt_command = "goimports"

" Typescript
Plug 'leafgarland/typescript-vim', {'for': ['typescript']}

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
let g:ale_linter_aliases = {
\	'jsx': ['css', 'javascript'],
\}
let g:ale_linters = {
\	'jsx': ['stylelint', 'eslint'],
\	'javascript': ['eslint'],
\	'typescript': ['eslint'],
\	'python': ['flake8'],
\	'cpp': ['gcc'],
\	'c': ['gcc'],
\	'go': ['gofmt', 'govet'],
\	'java': ['javalsp']
\}
let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'java': ['google_java_format'],
\	'python': ['isort', 'yapf'],
\	'cpp': ['clang-format'],
\	'c': ['clang-format'],
\	'go': ['goimports'],
\	'typescript': ['prettier', 'eslint'],
\	'javascript': ['prettier', 'eslint']
\}
let g:ale_fix_on_save = 1
" let g:ale_java_javalsp_jar = '~/local/usr/bin/javalsp.jar'
let g:airline#extensions#ale#enabled = 1

" Jump to previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" Jump to next error
nmap <silent> <C-j> <Plug>(ale_next_wrap)

call plug#end()

" Use H and L to navigate between tabs
nnoremap H gT
nnoremap L gt

""" HNEI arrows. Swap 'gn'/'ge' and 'n'/'e'.
"noremap n gj|noremap e gk|noremap i l|noremap gn j|noremap ge k
"
"" In(s)ert. The default s/S is synonymous with cl/cc and is not very useful.
"" - s/S is the new i/I ["inSert"].
"noremap s i|noremap S I
"
"" Repeat search.
"" - ö/Ö is the new n/N.
"noremap ö n|noremap Ö N
"
"" BOL/EOL/Join.
"" - l/L skip to the beginning and end of lines. Much more intuitive than ^/$.
"" - Ctrl-l joins lines, making l/L the veritable "Line" key.
"noremap l ^|noremap L $|noremap <C-l> J
"
"" _r_ = inneR text objects.
"" - r replaces i as the "inneR" modifier [e.g. "diw" becomes "drw"].
"onoremap r i
"
"" EOW.
"" - j/J is the new e/E ["Jump" to EOW].
"noremap j e|noremap J E

" Enable 256 color mode for VIM (Neovim ignores this)
set t_Co=256

" Enable mouse scrolling
set mouse=a

" Auto write before :next and :make
set autowrite

" Persistent undo
set undofile

" Increase size of history
set history=10000

" Allow Ctrl-A and Ctrl-X to increment and decrement alphabetical characters.
set nrformats+=alpha

" Case insensitive search unless using uppercase.
set ignorecase
set smartcase

" Line numbers
set number relativenumber
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Wordwrap
set textwidth=80
autocmd Filetype python setlocal textwidth=120
autocmd Filetype javascript,json setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab

" Solarized
set background=dark
colorscheme solarized
set cursorline
set colorcolumn=+1

" Use clipboard for yanking
set clipboard=unnamedplus

" Load all plugins before loading tags
packloadall
" Generate helptags (silently)
silent! helptags ALL
