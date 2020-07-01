" Muh Neovim config
"  - willeponken anno. 2018
"
" Dependencies:
"  * ctags
"  * hfmt, hlint
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
"  <C-l> Line completion (INSERT mode)
"  <C-d> Dictionary completion (INSERT mode)
"
"  <C-f> Fuzzy finder
"  	<C-t> Tab split
"  	<C-x> Split
"  	<C-v> Vertical split
"
"  <C-k> Jump to previous error.
"  <C-j> Jump to next error.
"
"  <C-Space> Toggle auto completion
"
"  <C-a> Accept snippet suggestion
"
"  <Space>g Search current directory recursively.
"  [f Previous search result.
"  ]f Next search result.
"
"  <Space>lt Toggle table of content in TeX file.
"  <Space>lc Compile TeX file (subsequent saves are automatically compiled).
"
"  <Space><Tab> Auto completed buffer switching with <Tab>.
"
"  <H> Switch to the next buffer on the left side.
"  <L> Switch to the next buffer on the right side.
"
" Copyright (C) 2018-2020 High On Coffee Ltd

call plug#begin('~/.config/nvim/plugins')

" Sensible defaults
Plug 'tpope/vim-sensible'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" I don't really use <C-f> (page down) anyways
map <C-f> :FZF<CR>

" Gists
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_post_private = 1
let g:gist_show_privates = 1

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

" Vimtex
Plug 'lervag/vimtex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_latexmk_continuous = 1
let g:vimtex_view_method = 'zathura'

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

" Haskell
Plug 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
"Plug 'alx741/vim-hindent'

" Nim
Plug 'zah/nim.vim'

" Elm
Plug 'elmcast/elm-vim'

" Terraform / HCL
Plug 'hashivim/vim-terraform'

" Highlight trailing whitespace
Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitelines_at_eof = 1

" Autocompletion/linting
Plug 'w0rp/ale', {
            \ 'do': '
            \   pip install --user \"python-language-server[all]\" &&
            \   pip install --user isort black mypy &&
            \   yarn global add eslint prettier &&
            \   go get golang.org/x/tools/gopls@latest
            \'
            \}
let g:ale_completion_enabled = 0
let g:ale_linter_aliases = {
            \   'jsx': ['css', 'javascript'],
            \}
let g:ale_linters = {
            \	'jsx': ['stylelint', 'eslint'],
            \	'javascript': ['eslint'],
            \	'typescript': ['tsserver'],
            \	'python': ['pyls', 'mypy'],
            \	'cpp': ['clangtidy'],
            \	'c': ['clangtidy'],
            \	'go': ['gopls', 'gofmt', 'govet'],
            \	'java': ['javalsp'],
            \   'terraform': ['terraform'],
            \	'haskell': ['stack-ghc-mod', 'hlint']
            \}
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \   'cpp': ['clang-format'],
            \   'java': ['google_java_format'],
            \   'python': ['isort', 'black'],
            \   'go': ['goimports'],
            \   'rust': ['rustfmt'],
            \   'yaml': ['prettier'],
            \	'c': ['clang-format'],
            \   'typescript': ['prettier'],
            \   'javascript': ['eslint'],
            \   'terraform': ['terraform']
            \}
let g:ale_fix_on_save = 1
" let g:ale_java_javalsp_jar = '~/local/usr/bin/javalsp.jar'
let g:airline#extensions#ale#enabled = 1

" Toggle fixer.
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" Jump to previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" Jump to next error
nmap <silent> <C-j> <Plug>(ale_next_wrap)

call plug#end()

" Use H and L to navigate between tabs
nnoremap H gT
nnoremap L gt

" Mmmmm, use dat space intead :*
let mapleader = " "

" Open new stuff in tabs (aka. do not replace current buffer)
set switchbuf+=usetab,newtab

" Set grep command
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
nnoremap <Leader>g :silent lgrep<Space>
nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>

" Save some key strokes with Vimtex
nnoremap <Leader>lt :VimtexTocToggle<CR>
nnoremap <Leader>lc :w \| :VimtexCompile<CR><CR>

" Format JSON with :FormatJSON
com! FormatJSON %!python -m json.tool

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

" Tab completed options.
set wildmenu
set wildmode=full
" Tab completed buffer switching.
set wildcharm=<Tab>
nnoremap <Leader><Tab> :buffer<Space><Tab>

" Line numbers
set number relativenumber
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Global substitute (so I do not have to add the annoying /g on search &
" replace).
set gdefault

" Wordwrap
set textwidth=80
set wrap linebreak nolist
" Remap j -> gj, k -> gk so that it's easier to navigate in word wrapped lines.
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Auto resize splits on window change.
autocmd VimResized * wincmd =

" Improve scroll performance.
augroup syntaxSyncMinLines
    autocmd!
    autocmd Syntax * syntax sync minlines=2000
augroup END

" Default indenting
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" File specific indenting
autocmd Filetype python setlocal textwidth=120 ts=4 sw=4 sts=0 expandtab
autocmd Filetype javascript,json setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype haskell setlocal ts=2 sw=2 expandtab
autocmd Filetype proto setlocal cindent expandtab shiftwidth=2
autocmd Filetype c,cpp setlocal cindent ts=8 sw=2 sts=2 textwidth=80 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" Interpret Jenkinsfile* and *.groovy.* as groovy
au BufNewFile,BufRead {Jenkinsfile,*.groovy}* setf groovy
autocmd Filetype groovy setlocal textwidth=120
autocmd Filetype tex setlocal textwidth=140 expandtab

" Spell checking
set spell spelllang=en_us

" Line completion.
inoremap <C-l> <C-x><C-l>

" Dictionary completion.
set dictionary=/usr/share/dict/words
inoremap <C-d> <C-x><C-k>

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
