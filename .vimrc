" Configuration file for vim

" Normally we use vim-extensions. If you want true vi-compatibility
" change the following statement
set nocompatible	" Use Vim defaults (much better!)
set backspace=2		" allow backspacing over everything in insert mode
" Now we set some defaults for the editor
set autoindent		" always set autoindenting on
set textwidth=0		" Don't wrap words by default
"set colorcolumn=81	" but display a vertical line to indicate 80 columns
set viminfo='20,\"50	" read/write a .viminfo file, don't store more than
			" 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
"set expandtab		" have tabs actually be spaces
set noexpandtab		" have tabs actually be tabs
set title		" set xterm title
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" override 'ignorecase' when patterh has upper chars
"set incsearch		" Incremental search
"set autowrite		" Automatically save before things like :next and :make
set tag=./tags,tags,TAGS,$SRCTOP/tags
			" list of file names to search for tags
set laststatus=2	" always have status line
set hlsearch		" highlight search terms - ok, changed colors
set dictionary=/usr/dict/words " use ctrl-x ctrl-k
set nodigraph		" don't use {char1}<BS>{char2} instead use
			" CTRL-K {char1} {char2} eg: <c-k>a' = á ; <c-k>Ye = ¥
set noequalalways	" don't balance windows on a split
set helpheight=0	" don't have a minimum height for the help window
set path+=~		" gf should search for files in $HOME too

set wildmode=longest,list	" like tcsh completion
set wildmenu		" display a menu when you hit tab completion
set lazyredraw		" makes macros faster
set modeline		" follow modelines in the last few lines of a file


" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" Don't keep a backup file unless root
if $USER == "root"
  set backup
else
  set nobackup
endif

" ****** When is this needed?? ****** - doesn't help rxvt
" We know xterm-debian is a color terminal
"if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm-color" || &term =~ "rxvt"
"  set t_Co=16
"  set t_Sf=[3%dm
"  set t_Sb=[4%dm
"endif

" setup encodings
"set fileencodings=usc-bom,euc-jp,iso-2022-jp,sjis,utf-8,latin1

" Vim5 comes with syntaxhighlighting.  Enable by default.
if has("syntax")
  set background=light " i like these colors better
  syntax on

  hi clear SpellBad
  hi SpellBad term=underline ctermbg=red guibg=red

  if &term != "linux"
    " 256-color required
    colorscheme spacegray
  endif
endif

if has("folding")
  set foldlevelstart=20		" by default don't fold
  set foldmethod=syntax		" use syntax folding if available -- SLOW
  let g:xml_syntax_folding=1	" enable XML folding -- slow
  inoremap <F9> <C-O>za
  nnoremap <F9> za
  onoremap <F9> <C-C>za
  vnoremap <F9> zf
endif


if has("autocmd") && !exists("autocommands_loaded")

  " prevent autocmds being included more than once
  let autocommands_loaded = 1

  " Enabled file type detection
  " Use the default filetype settings. Also load indent files to automatically
  " do language-dependent indenting (vim 6.0)
  if version >= 600
    filetype plugin indent on
  else
    filetype on
  endif

  augroup xmlfile
    autocmd BufRead,BufNewFile *.xml set sts=2 sta sw=2 ts=8 noexpandtab
  augroup END

  augroup javaprog
    autocmd BufRead,BufNewFile *.java set sts=4 sta sw=4 ts=4 noexpandtab
  augroup END

  augroup cprog
    autocmd BufRead,BufNewFile *.C,*.c,*.h,*.cc,*.H,*.cpp set sts=4 sta sw=4 ts=4 noexpandtab
  augroup END

  autocmd BufRead,BufNewFile *.tex set sts=2 sta sw=2 ts=8 noexpandtab
  autocmd BufRead,BufNewFile *.tex setlocal spell spelllang=en_us

  autocmd BufRead,BufNewFile mutt-*-\d\+,mutt\w\{6\} set tw=76
  autocmd BufRead,BufNewFile mutt-*-\d\+,mutt\w\{6\} setlocal spell spelllang=en_us
  autocmd BufRead,BufNewFile */.mutt* set ft=muttrc
  autocmd BufRead,BufNewFile *Dockerfile set ft=dockerfile
endif

if filereadable( "build.xml" )
  set makeprg=ant\ -emacs
  "command make ant
endif
if filereadable( "pom.xml" )
  set makeprg=mvn
  set errorformat=[ERROR]\ %f:[%l\\,%v]\ %m
endif

" keymappings

" F11 to toggle paste mode
map <F11>	:set invpaste<CR>
set pastetoggle=<F11>

" screenshot (html syntax highlighted) in new buffer
map <F12>	:set bg=dark<CR>:source $VIMRUNTIME/syntax/2html.vim<CR>:set bg=light<CR>

" ctrl-n, ctrl-p for quickfix mode
map <C-N>	:cn<CR>
map <C-P>	:cp<CR>

" changedir to the dir of the current file
map ,cd		:cd %:p:h<CR>
" edit a file relative to the current file
map ,e		:e <C-R>=expand("%:p:h")<CR>/
" edit a file relative to the current file in a new window
map ,n		:new <C-R>=expand("%:p:h")<CR>/
" quote current paragraph with '> '
map ,>		mc{jma}k$mb:'a,'b:s/^/> /<CR>`c
" unquote current paragraph
map ,<		mc{jma}k$mb:'a,'b:s/^> //<CR>`c
" delete blank lines
map ,db		:g/^$/d 1<CR>
" delete whitespace-only lines
map ,dw		:g/^\s\+$/d 1<CR>
" remove trailing whitespace
map ,dt		:1,$:s/\s\+$//<CR>
" remove leading whitespace
map ,dl		:1,$:s/^\s\+//<CR>
" remove cvs/svn/git annotation window (memomic: delete annotation)
map ,da         <c-w>lmz:set noscrollbind wrap<CR><c-w>h:q<CR>`z

" if we are editing in subversion
if isdirectory(finddir(".svn", ".;/"))
  " svn diff in new window
  map ,di	:new<CR>!!svn diff <c-r>#<CR><CR>:set syntax=diff filetype=diff buftype=nowrite<CR>
  " svn diff for the whole dir in new window
  map ,ddi	:new<CR>!!svn diff <CR><CR>:set syntax=diff filetype=diff buftype=nowrite<CR>
  " svn log in new window
  map ,sl	:new<CR>!!svn log -v <c-r>#<CR><CR>:set buftype=nowrite<CR>:setf svnlog<CR>
  " svn annotate in new vertical split (only useful on unmodified files)
  map ,sa	mzgg:set winwidth=10 scrollbind nowrap<CR>:10vnew<CR>:set nowrap buftype=nowrite<CR>!!svn annotate <c-r>#<CR><CR>:%:s/^ *\([0-9\.]\+\) \+\([a-zA-Z]\+\) .*/\1 \2/<CR>gg:set scrollbind<CR>:syncbind<CR><c-w>l`z
endif

" if we are editing in CVS
if isdirectory("CVS")
  " cvs log in new window
  map ,cl	:new<CR>!!cvs log <c-r>#<CR><CR>:set syntax=rcslog filetype=rcslog buftype=nowrite<CR>/^-<CR><c-d>
  " cvs annotate in new vertical split (only useful on unmodified files)
  map ,ca	mzgg:set winwidth=10 scrollbind nowrap<CR>:10vnew<CR>:set nowrap buftype=nowrite<CR>!!cvs annotate <c-r>#<CR><CR>:1,2:delete<CR>:%:s/^\([0-9\.]\+\) \+(\([a-zA-Z]\+\) \+[0-9a-zA-Z-]\+):.*/\1 \2/<CR>gg:set scrollbind<CR>:syncbind<CR><c-w>l`z
  " cvs diff in new window
  map ,di	:new<CR>!!cvs diff -u <c-r>#<CR><CR>:set syntax=diff filetype=diff<CR>
endif

" if we are editing in git
if isdirectory(finddir(".git", ".;/"))
  " git log in new window
  map ,gl	:new<CR>!!git log --decorate <c-r>#<CR><CR>:set syntax=git filetype=git buftype=nowrite<CR>
  " git graph in new window
  map ,gg	:new<CR>!!git log --decorate --all --oneline --graph <c-r>#<CR><CR>:set nowrap syntax=git filetype=git buftype=nowrite<CR>
  " git diff in new window
  map ,di	:new<CR>!!git diff <c-r># ; git diff --staged <c-r>#<CR><CR>:set syntax=diff filetype=diff buftype=nowrite<CR>
  " git diff for the whole dir in new window
  map ,ddi	:new<CR>!!git diff ; git diff --staged<CR><CR>:set syntax=diff filetype=diff buftype=nowrite<CR>
  " git annotate in new vertical split
  map ,ga	mzgg:set winwidth=20 scrollbind nowrap<CR>:20vnew<CR>:set nowrap buftype=nowrite<CR>!!git blame --date short -e <c-r>#<CR><CR>:%:s/^\s*\(\S\+\)\s\+(<\([^@]\+\)@\?[^@]\+>\s\+\([0-9-]\+\).*$/\2 \3 \1/<CR><space>gg:set scrollbind<CR>:syncbind<CR><c-w>l`z
endif


" GNU readline style key bindings for command lines
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <ESC>b <S-Left>
cnoremap <ESC>f <S-Right>
cnoremap <C-U> <C-E><C-U>

" correct for typos when I hold down shift too long
command! Q q
command! W w
command! Wq wq
command! WQ wq

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" in case we start up the gui
if has("gui_running")
  set guifont=Inconsolata\ Medium\ 13.5
  highlight Normal guibg=black
  highlight Normal guifg=grey90
endif

" so hlsearch is tolerable
highlight Search term=reverse ctermbg=3 ctermfg=0 guifg=Black

" setup local directory if it doesn't exist
if !isdirectory( $HOME . "/.vim/" )
    system("mkdir " . $HOME . "/.vim");
endif

" execute local setup
if filereadable( $HOME . "/.vim/local.vim" )
    source $HOME/.vim/local.vim
else
    system("touch " . $HOME . "/.vim/local.vim");
endif
