call plug#begin('~/.local/share/nvim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'
Plug 'dag/vim2hs'
Plug 'AndrewRadev/linediff.vim'
Plug 'airblade/vim-gitgutter'
call plug#end()

set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside
set mouse=a

" Fuzzy find
set rtp+=/usr/local/opt/fzf

let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

augroup whitespace
   au!
   autocmd FileType objc,objcpp,haskell,markdown autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

syntax on		" syntax highlight
set hlsearch		" search highlighting

colors desert256

" set leader to ,
let mapleader=","
let g:mapleader=","
let maplocalleader=","
let g:maplocalleader=","

hi LineNr ctermfg=darkgray guifg=#555555 gui=none

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc,build/**,*.xcodeproj/**,*.m,*.hi,*.png,*.dyn_hi,*.dyn_o

set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set number
set nofoldenable

" disable sound on errors
set noerrorbells
set vb " this removes the bells on MacVim
set t_vb=
set tm=500

" TAB setting{
   set tabstop=8                   "A tab is 8 spaces
   set expandtab                   "Always uses spaces instead of tabs
   set softtabstop=4               "Insert 4 spaces when tab is pressed
   set shiftwidth=4                "An indent is 4 spaces
   set smarttab                    "Indent instead of tab at start of line
   set shiftround                  "Round spaces to nearest shiftwidth multiple
   set nojoinspaces                "Don't convert spaces to tabs

   au FileType Makefile set noexpandtab
"}

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}


" C/C++ specific settings
"autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" Tip #382: Search for <cword> and replace with input() in all open buffers
"---------------------------------------------------------------------------
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
    :unlet! s:word
endfun

"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------

"replace the current word in all opened buffers
"noremap <leader>r :call Replace()<CR>

"reload the config
noremap <Leader>z :source $MYVIMRC<CR>:echom "~/.vimrc reloaded"<CR>

"Find
nnoremap <expr> <Leader>f ":Ack " . input("Search: ") . "<CR>"
nnoremap <expr> <Leader>F ":tabe<CR>:Ack " . input("Search: ") . "<CR>"
nnoremap <expr> <Leader>u ":tabe<CR>:Ack " . expand('<cword>') . "<CR>"

nnoremap <expr> <Leader>s ":cdo s/" . input("Replace: ") . "/" . input("With: ") . "/c \| update<CR>"
"xnoremap <expr> <Leader>s "y:s/<C-r>=fnameescape(@")" . "/" . input("Replace: ") . "/c \| update"
"<C-r>=fnameescape(@")<CR><CR>

"quick substitution
noremap <Leader>r :%s/\<<C-R><C-W>\>//ge<left><left><left>

"Fuzzy find
noremap <Leader>t :FZF<CR>
noremap <Leader>T :tabe<CR>:FZF<CR>

nmap <leader>/ :nohl<CR>
nmap <leader>p :set paste!<BAR>set paste?<CR>

noremap 9 $
noremap <Leader>l :ListMethods<CR>
noremap <Leader>q <C-W><C-W>
noremap <S-Down> <C-D>zz
noremap <S-Up> <C-U>zz
noremap <C-J> <C-D>zz
noremap <C-K> <C-U>zz
nmap <BACKSPACE> <C-o>
noremap Q ZQ
noremap <Leader>m :Linediff<CR>
noremap <Leader>M :LinediffReset<CR>

noremap L :tabn<CR>
noremap H :tabp<CR>

nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>``

" open the error console
noremap <leader>cc :botright cope<CR>

noremap g= mfgg=G`f

" use easymotion to yank/paste a particular line
function! PullInLine()
    normal mu
    call EasyMotion#Sol(0,2)
    normal yy'up
endfunction

noremap <leader>y :call PullInLine()<CR>


" --- move around splits {
set wmw=0                     " set the min width of a window to 0 so we can maximize others
set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }


" open help file in vertical split to the right
cnoreabbrev vhelp vert bo help


" cabs - less stupidity                                                      {{{
fu! Single_quote(str)
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfu
fu! Cabbrev(key, value)
  exe printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), Single_quote(a:value), Single_quote(a:key))
endfu
"}}}

call Cabbrev('fixdquotes',   '%s/“\\|”/"/g')
call Cabbrev('fixdash',   '%s/ \- /—/g')
call Cabbrev('fixsquotes', "%s/’/'/g")

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

noremap Y y$

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Fix syntastic error jumping
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> <leader>[  <Plug>LocationPrevious
nmap <silent> <leader>]  <Plug>LocationNext

"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

let g:ackprg = 'ag --vimgrep'

" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \	if &omnifunc == "" |
              \		setlocal omnifunc=syntaxcomplete#Complete |
              \	endif
endif


" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
"set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------

set grepprg=grep\ -nH\ $*

" --- SuperTab
let g:SuperTabDefaultCompletionType = "<c-p>"
"let g:SuperTabMappingForward = '<c-tab>'

" --- NERD_commenter
map - <Leader>c<Space>

" --- EasyMotion
"let g:EasyMotion_leader_key = '<Space>'

map <Space> <Plug>(easymotion-jumptoanywhere)

let g:EasyMotion_re_anywhere = '\v' .
    \       '(<.|^)'

let g:haskell_conceal = 0

au BufRead * normal zR
