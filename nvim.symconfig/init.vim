" initialize $VIMHOME to the configuration home
let $VIMHOME=expand('<sfile>:p:h')

" load plugins
if filereadable($VIMHOME."/plugins.vim")
    source $VIMHOME/plugins.vim
endif

" make syntax work
filetype plugin indent on
syntax enable

" improve vim command completion
set wildmode=longest:full,full
set wildmenu

" tabs and stuff
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set smarttab
set autoread

" display
set mouse=a
set scrolloff=4
set showcmd
set number
set nohlsearch
set laststatus=2
set background=dark

" searching
set magic
set ignorecase
set smartcase
set incsearch

" buffers
set hidden

" history
set undolevels=10000

" formatting
" delete comment character when joining lines
set formatoptions+=jn
set nojoinspaces

" Completion
" probably replacing all of this configuration with deoplete
set omnifunc=syntaxcomplete#Complete
" inoremap <NUL> <C-x><C-o>
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <NUL> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Make backspace behave the way I expect
set backspace=indent,eol,start

set fileformat=unix

" Global mappings
" Easy macro-replay
nnoremap Q @q
" make Y more logical
nnoremap Y y$
" Force save a file
cmap W! w !sudo tee % >/dev/null
" navigation from terminal
tnoremap <C-\>j <C-\><C-n><C-w><C-j>
tnoremap <C-\>k <C-\><C-n><C-w><C-k>
tnoremap <C-\>l <C-\><C-n><C-w><C-l>
tnoremap <C-\>h <C-\><C-n><C-w><C-h>

" Leader mappings
let mapleader=" "
" Edit vimrc
nnoremap <Leader>ev :split $MYVIMRC<CR>
" Edit plugins
nnoremap <Leader>ep :split $VIMHOME/plugins.vim<CR>
" Edit filetype file
nnoremap <expr> <Leader>ef ':split '.$VIMHOME.'/ftplugin/'.&filetype.'.vim<CR>'
" Source vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>
" Install plugins
nnoremap <Leader>ip :PlugInstall<CR>
" Fuzzy file open
nnoremap <Leader>o :FZF<CR>
" Trim whitespace
noremap <Leader>t<Space> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Generate ctags
nnoremap <Leader>mt :!ctags -R .<CR><CR>
" Toggle hlsearch
nnoremap <Leader>ht :set hlsearch!<CR>
" Open buffer list
nnoremap <Leader>b :Buffers<CR>
" run the last normal mode command
nnoremap <Leader>: :<Up><CR>
xnoremap <Leader>: :<Up><CR>

" Toggle colorcolumn
set colorcolumn=81
let s:color_column_old = 0
function! s:ToggleColorColumn()
    let l:tmp = &colorcolumn
    windo let &colorcolumn = s:color_column_old
    let s:color_column_old = l:tmp
endfunction
nnoremap <Leader>8 :call <SID>ToggleColorColumn()<CR>

" Spelling related things
if &spell
    nnoremap <Leader>z 1z=

    " Spelling corrections
    abbreviate teh the
end

" finally load local vim configuration if it exists
if filereadable($VIMHOME."/local.vim")
    source $VIMHOME/local.vim
endif
