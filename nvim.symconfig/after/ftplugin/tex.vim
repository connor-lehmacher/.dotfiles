" Wrap lines at 80 automatically
" setlocal textwidth=80

" Make c a new surround command for a latex command
" e.g. ysapc[arg] would surround a paragraph like \arg{[paragraph]}
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

setlocal spell

" soft wrap instead of hard wrapping in latex mode
setlocal wrap linebreak
nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

nnoremap <buffer> <LocalLeader>o :!open %:r.pdf<CR><CR>
nnoremap <buffer> <LocalLeader>m :make<CR>
nnoremap <buffer> <LocalLeader>s :VimtexCompile<CR>
nnoremap <buffer> <LocalLeader>e :VimtexErrors<CR>
nnoremap <buffer> <LocalLeader>c :!md5 %:r.pdf<CR>

let g:vimtex_compiler_latexmk_engines = {
        \ '_'                : '-lualatex',
        \ 'pdflatex'         : '-pdf',
        \ 'dvipdfex'         : '-pdfdvi',
        \ 'lualatex'         : '-lualatex',
        \ 'xelatex'          : '-xelatex',
        \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
        \ 'context (luatex)' : '-pdf -pdflatex=context',
        \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
        \}
