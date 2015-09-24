" Plugins {{{
" Enable Pathogen to manage plugins
execute pathogen#infect()

" }}}

" Syntax highlighting and vim style {{{

" enable syntax highlighting
syntax on

"setting the color scheme to GitHub, which is places in ~/.vim/colors
" set t_Co=256
set t_Co=256
colorscheme hybrid
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
set tw=80 " text width
set colorcolumn=160 " adds a ruler to the right side of Vim
set scrolloff=15
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

" normal ESC key for exiting terminal mode.
tnoremap <Esc> <c-\><c-n>

" auto-expand path (opening files like :tabedit %%/)
cabbr <expr> %% expand('%:p:h')
" }}}

" No backups and no swap file
set nobackup
set noswapfile
