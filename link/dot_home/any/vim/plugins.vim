call plug#begin('~/.vim/plugged')

" Motion Plugins
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-repeat'
Plug 'tommcdo/vim-exchange'
Plug 'scrooloose/syntastic'

" Convenience Plugins
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'

" UI Plugins
Plug 'vim-airline/vim-airline'
    \| Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'

" vim-vim-plugins
Plug 'tpope/vim-scriptease'

" perl-plugins
Plug 'vim-perl/vim-perl'

" R plugins
Plug 'vim-scripts/csv.vim'

" Webdev plugins
Plug 'othree/html5.vim'
Plug 'tpope/vim-markdown'
Plug 'cakebaker/scss-syntax.vim'

" Other filetype specific
Plug 'lervag/vimtex'
Plug 'keith/tmux.vim'
Plug 'xu-cheng/brew.vim'
" idris highlighting + indentation
Plug 'idris-hackers/idris-vim'
" haskell highlighting + indentation
Plug 'neovimhaskell/haskell-vim'
" rust syntax, highlighting, etc.
Plug 'rust-lang/rust.vim'



Plug g:plug_home.'/eclim'

" Solarized
Plug 'altercation/vim-colors-solarized'
" Devicons
Plug 'ryanoasis/vim-devicons'
let g:EclimCompletionMethod = 'omnifunc'
call plug#end()

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Netrw
let g:netrw_liststyle = 3

" Solarized
colorscheme solarized
call togglebg#map("<F3>")

" vim-devicons
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" idris
let g:idris_conceal = 1

" syntastic checkers
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Externally managed plugins
if executable('opam')
    let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')

    if executable('ocamlmerlin') && has('python')
        execute "set rtp+=".g:opamshare . "/merlin/vim"
        " To update the documentation
        " execute "helptags " . g:opamshare . "/merlin/vim/doc"
        let g:syntastic_ocaml_checkers=['merlin']
    endif

    if executable('ocp-indent')
        execute "set rtp+=" . g:opamshare . "/ocp-indent/vim"
    endif
endif