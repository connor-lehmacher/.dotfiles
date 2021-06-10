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
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set smarttab

" ui
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
silent! colorscheme onedark
set mouse=a
set scrolloff=4
set showcmd
set number
set nohlsearch
set laststatus=2
set background=dark
set belloff=all
let g:airline#extensions#whitespace#mixed_indent_algo = 2
let g:netrw_liststyle = 3

" fix delay when exiting insert mode
if !has('nvim')
    set noesckeys
endif

" searching
set ignorecase
set smartcase
set incsearch
if has('nvim')
    set inccommand=split
end

" buffers
set hidden

" history
set undolevels=10000
set undofile
if has('nvim')
    let g:terminal_scrollback_buffer_size = 10000
end

" polyglot
"let g:polyglot_disabled = ['latex']

" deoplete
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_smart_case = 1
    autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']
    " make backspace close the popup window
    inoremap <expr> <C-h> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr> <BS>  deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr> <C-Space> deoplete#manual_complete()
else
    set omnifunc=syntaxcomplete#Complete
    " inoremap <NUL> <C-x><C-o>
    set completeopt=longest,menuone
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
      \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
    inoremap <expr> <NUL> pumvisible() ? '<C-n>' :
      \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
end

" Make backspace behave the way I expect
set backspace=indent,eol,start

" Global mappings
" Easy macro-replay
nnoremap Q @q
" make Y more logical
nnoremap Y y$
" align lines
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
" toggle background color
nnoremap <F3> :set background!<CR>
if has('nvim')
    " navigation from terminal
    tnoremap <C-\>j <C-\><C-n><C-w><C-j>
    tnoremap <C-\>k <C-\><C-n><C-w><C-k>
    tnoremap <C-\>l <C-\><C-n><C-w><C-l>
    tnoremap <C-\>h <C-\><C-n><C-w><C-h>
end

" Leader mappings
let mapleader=" "
let maplocalleader = "\\"
" Edit vimrc
nnoremap <Leader>ev :split $MYVIMRC<CR>
" Edit plugins
nnoremap <Leader>ep :split $VIMHOME/plugins.vim<CR>
" Edit filetype file
nnoremap <expr> <Leader>ef ':split '.$VIMHOME.'/after/ftplugin/'.&filetype.'.vim<CR>'
" Edit syntax file
nnoremap <expr> <Leader>es ':split '.$VIMHOME.'/syntax/'.&filetype.'.vim<CR>'
" Edit detection file
nnoremap <expr> <Leader>ed ':split '.$VIMHOME.'/after/ftdetect/'.&filetype.'.vim<CR>'
" Edit config file
nnoremap <Leader>ec :split $VIMHOME/autoload/config.vim<CR>
" Source vimrc
nnoremap <Leader>sv :source $MYVIMRC<CR>
" Install plugins
nnoremap <Leader>ip :PlugInstall<CR>
" Fuzzy file open
nnoremap <Leader>o :FZF<CR>
" Fuzzy ag
nnoremap <Leader>/ :Ag<CR>
" Trim whitespace
noremap <Leader>t<Space> :call config#StripWhitespace()<CR>
" Generate ctags
nnoremap <Leader>mt :!ctags -R .<CR><CR>
" Toggle hlsearch
nnoremap <Leader>th :set hlsearch!<CR>
" Open buffer list
nnoremap <Leader>b :Buffers<CR>
" run the last normal mode command
nnoremap <Leader>: :<Up><CR>
xnoremap <Leader>: :<Up><CR>
" insert a single character
" nnoremap <Leader>qqq

" toggle colorcolumn with <space>8
" set colorcolumn=81
" nnoremap <Leader>8 :call config#ToggleColorColumn()<CR>
