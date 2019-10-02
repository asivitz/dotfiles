call plug#begin('~/.local/share/nvim/plugged')
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'ervandew/supertab'
Plug 'parsonsmatt/vim2hs'
Plug 'AndrewRadev/linediff.vim'
Plug 'airblade/vim-gitgutter'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'tomtom/tcomment_vim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'tpope/vim-unimpaired'
Plug 'whiteinge/diffconflicts'
call plug#end()

set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//
set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside
set mouse=a

let $FZF_DEFAULT_COMMAND = 'fd -t f'

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

augroup whitespace
   au!
   autocmd FileType objc,objcpp,haskell,markdown autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

syntax on		" syntax highlight
set hlsearch		" search highlighting

hi! link hsOperator hsDelimiter

set termguicolors
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colors gruvbox
set background=dark
let g:airline_theme='luna'

" set leader to ,
let mapleader=","
let g:mapleader=","
let maplocalleader=","
let g:maplocalleader=","

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu
set hidden

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
" autocmd BufWinEnter,WinEnter term://* startinsert

" TAB setting{
   set tabstop=8                   "A tab is 8 spaces
   set expandtab                   "Always uses spaces instead of tabs
   set softtabstop=2               "Insert 4 spaces when tab is pressed
   set shiftwidth=2                "An indent is 4 spaces
   set shiftround                  "Round spaces to nearest shiftwidth multiple
   set nojoinspaces                "Don't convert spaces to tabs

   au FileType Makefile set noexpandtab
"}

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

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------

nmap <BACKSPACE> <C-o>
nmap <leader>/ :nohl<CR>
nmap <leader>p :set paste!<BAR>set paste?<CR>
nnoremap <expr> <Leader>e ":Grepper -tool rg -noopen -jump -query '" . expand('<cword>') . "\\s+::\|^" . expand('<cword>') . "$'<CR>"
nnoremap <expr> <Leader>f ":Rg! " . input("Search: ") . "<CR>"
nnoremap <expr> <Leader>u ":Rg! " . expand('<cword>') . "<CR>"
nnoremap <Leader>a :cc<CR>
nnoremap <leader>W :%s/\s\+$//<CR>:let @/=''<CR>``
noremap 9 $
noremap <C-H> :tabp<CR>
noremap <C-J> <C-D>zz
noremap <C-K> <C-U>zz
noremap <C-L> :tabn<CR>
noremap <Leader>M :LinediffReset<CR>
noremap <Leader>d :Buffers!<CR>
noremap <Leader>l :ListMethods<CR>
noremap <Leader>m :Linediff<CR>
noremap <Leader>t :Files!<CR>
noremap <Leader>z :source $MYVIMRC<CR>:echom "~/.vimrc reloaded"<CR>
noremap <S-Down> <C-D>zz
noremap <S-Up> <C-U>zz
noremap K :w<CR>
noremap Q ZQ
tnoremap <C-H> <C-\><C-n>:tabp<CR>
tnoremap <C-L> <C-\><C-n>:tabn<CR>
tnoremap <C-Space> <C-\><C-n>

" use easymotion to yank/paste a particular line
function! PullInLine()
    normal mu
    call EasyMotion#Sol(0,2)
    normal yy'up
endfunction

noremap <leader>q :bd<CR>
noremap <leader>y :call PullInLine()<CR>
inoremap <leader>4 <$>
inoremap <leader>8 <*>

function! OpenGhcidError()
  execute "normal! \<C-W>\<C-W>"
  execute "normal! ?error:\\|warning:\<CR>^"
  normal! "iyt:f:l
  normal! "uyt:f:l
  normal! "yyt:f:
  normal! G
  execute "normal! \<C-W>\<C-W>"
  execute "edit " . @i
  call cursor(@u,@y)
  normal! zz
endfunction

noremap <leader>o :call OpenGhcidError()<CR>

" --- move around splits {
set wmw=0                     " set the min width of a window to 0 so we can maximize others
set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

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

let g:ackprg = 'rg --vimgrep'

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

map - :TComment<Enter>

" --- EasyMotion
"let g:EasyMotion_leader_key = '<Space>'

map <Space> <Plug>(easymotion-jumptoanywhere)

let g:EasyMotion_re_anywhere = '\v' .
    \       '(<.|^)'

let g:haskell_conceal = 0

au BufRead * normal zR

map <Leader>1 :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

let g:prosession_dir = '~/.local/share/nvim/session/'

hi LineNr ctermfg=darkgray guifg=#555555 gui=none
hi TermCursor ctermfg=green guifg=green

" From the fzf.vim docs-- :Rg search command
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('up:60%'), <bang>0)
