" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" The following things are added by me.
set nu
set smartindent
set autoread
set autowrite
set wildmenu
set magic
set backupdir=~/.vim/backup

set lines=1000 columns=1000
set guifontwide=WenQuanYi\ Zen\ Hei
set fileencodings=GBK,GB18030,GB2312,utf-8,usc-bot,latin1,default

"===============Compile & Run the C Program With Input File==========
map <F9> : call Compile_run_gcc_with_input_file()<CR>
func! Compile_run_gcc_with_input_file()
	make "%:p:r"
	exec "!%:p:r < %:p:r.in"
endfunc 

"===============Compile & Run the C Program==========
map <F6> : call Compile_run_gcc()<CR>
func! Compile_run_gcc()
	make "%:p:r"
	exec "! %:p:r"
endfunc 

"===============Compile the C Program==========
map <C-F6> : call Compile_gcc()<CR>
func! Compile_gcc()
	make "%:p:r"
endfunc 

" WordComplete.vim
": call DoWordComplete()

"Taglist.vim
: let Tlist_Auto_Highlighting_Tag = 1
: let Tlist_Auto_Update = 1
: let Tlist_Exit_OnlyWindow = 1
: let Tlist_File_Fold_Auto_Close = 1
: let Tlist_Process_File_Always = 0
: let Tlist_Show_One_File = 1
: let Tlist_Use_Right_Window = 1
": TlistOpen
: nnoremap <silent> <F8> : TlistToggle<CR>

"Scheme
colorscheme pablo
:cd /home/wade/acm
