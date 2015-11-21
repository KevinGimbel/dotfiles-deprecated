" vim:fdm=marker
set nocompatible
" Plugins {{{
" Enable Pathogen to manage plugins
execute pathogen#infect()

" Auto-load NERDTree
" autocmd vimenter * NERDTree
" }}}

" Syntax highlighting and vim style {{{

" enable syntax highlighting, setting colors to use 256 colorshemes,
" light background and hemisu as theme.
syntax on
set t_Co=256
set background=dark
colorscheme material-theme
" highlight JSX in all files (not only .jsx)
let g:jsx_ext_required = 0

autocmd BufRead,BufNewFile *.scss set syntax=sass

set showmode
set showcmd
set modeline
set ruler
" line number
set number
" }}}

" Write settings {{{
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set smartindent
set formatoptions+=t " wikia said I need this
set tw=80 
set colorcolumn=160 " adds a ruler to the right side of Vim
set scrolloff=50
set wmh=0
" }}}

" Key mappings {{{
" The <Enter> command behind each mapping executes the
" command directly. Otherwise the command would be written
" to the VIM 'console' thing
" start spell checking when hitting F5
map <F5> :set spell spelllang=en_us <Enter>
" switch to previous tab
nmap <F2> :tabp <Enter>
" switch to next tab
nmap <F3> :tabn <Enter> 

" hold CTRL + k (up) or j (down)
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
" remove information in which line the non-active file currently is

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" auto-expand path (opening files like :tabedit %%/)
cabbr <expr> %% expand('%:p:h')
" }}}

" Status Line {{{
set ls=2 " always show statusline
set statusline=%f " show current file
" %= align the text to the right
set statusline+=%=
set statusline+=%{''.(&fenc!=''?&fenc:&enc).''} " file encoding
set statusline+=\ \ "space
set statusline+=%c 
set statusline+=\ %l/%L "current line / total lines
" }}}

" No backups and no swap file
set nobackup
set noswapfile
