"SETTINGS AND VARIABLES
"======================
"
"Load Pathogen
filetype off
call pathogen#runtime_append_all_bundles() 
call pathogen#helptags() 
filetype plugin indent on

"No vi compatible mode.
set nocompatible

" iPAD-SPECIFIC
" =============

if &term != "xterm-ipad"
	let g:session_autosave = 1  " session.vim: save session on exit.
	let g:session_autoload = 1  " session.vim: load session on open.
else
	set t_Co=256				" sets terminal colors to 256 (vim reports 8 for some reason.)
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set spelllang=en_us

set backupdir=~/.vimbackup " By default, vim creates backups for every file edited, so you get your project littered w/ filename.ext~ files.  This puts them all in a hidden .backup directory.
set directory=/tmp " Ditto filename.ext.swp files; necessary for vim to work right, but you don't want them cluttering up your project directory.

set history=100		" command history = 100
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set ignorecase		" ignore case in searching, unless
set smartcase		" search string includes uppercase characters
set hidden			" allows for hidden buttons

set tabstop=4		" with of tab char = 4
set softtabstop=4
set shiftwidth=4	" width of indent w/ >: 4
set expandtab		
set showmatch		" highlight matching bracket/parent/etc

set number
set textwidth=79
set colorcolumn=-1

"  STATUSLINE
"  ==========

set statusline=%{StatuslineMagicFlags()}
set statusline+=%f       "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag

" display current git branch
set statusline+=%{fugitive#statusline()}

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%-4{StatuslineCurrentHighlight()}
set statusline+=%c\|     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ (%P)    "percent through file
set laststatus=2        " Always show status line

" return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

function! StatuslineMagicFlags()
    if &mod == 1
       return '[+] '
    else
       return '     '
    endif
endfunction

autocmd! BufNew * setlocal cursorline
autocmd BufNew * setlocal cursorcolumn
autocmd! WinEnter * setlocal cursorline
autocmd WinEnter * setlocal cursorcolumn
autocmd! WinLeave * setlocal nocursorline
autocmd WinLeave * setlocal nocursorcolumn

let mapleader = ","  "Leader key mapped to , .  (Leader is basically a custom meta key, so you can define commands to <Leader><Whatever>
imap jj <Esc>
nmap oo :put =''<CR> 
nmap OO :put! =''<CR>
nmap // :noh<CR>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h
nmap <CR> <C-]>

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap <tab> %
vnoremap <tab> %
nnoremap j gj
nnoremap k gk
map <Leader>r :RainbowParenthesesToggle<CR>
map <Leader>n :NERDTree<CR>
map <Leader>t :TagbarToggle<CR>
map <Leader><CR> i<CR><ESC>

set wmh=0			" allows one-line window height
set noea			" doesn't resize all windows on split.

set autoread		" reload files that have changed in filesystem but not in vim

if (hostname() == "mysphyt-ihac")
	set gfn=Inconsolata:h17
else
	set gfn=Inconsolata:h13
endif

set shell=/bin/bash
let g:tagbar_left = 1
let g:tagbar_autoshowtag = 1
let g:lucius_style='dark'
let g:liquidcarbon_high_contrast = 1
colorscheme liquidcarbon
set anti			" font antialiasing
set guioptions-=T	" disable toolbar in gui

set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
set clipboard+=unnamed

" Spacebar opens folds.
map <Space> za
map <Space><Space> zA
set foldenable " Turn on folding
set foldmarker={,} " Fold C style code (only use this as default 
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still 
set foldopen=block,hor,mark,percent,quickfix,tag " what movements
function! SimpleFoldText() " 
	return getline(v:foldstart).' '
endfunction " }
set foldtext=SimpleFoldText() " Custom fold text function 

set wrapmargin=2
set linebreak
let &showbreak='└─► '

map <leader>p  <Esc>:%!json_xs -f json -t json-pretty<CR>

" PLUGIN SETTINGS
" ===============
map <Leader><Tab> :LustyJuggler<CR>
map <Leader>l :TlistToggle<CR>

let VIMPRESS = [{'username':'jngeist',
                 \ 'blog_url':'http://jnicholasgeist.wordpress.com'
                 \},
                 \{'username':'jngeist',
                 \ 'blog_url':'http://www.coswritingcenter.org'
                 \}]
let g:indent_guides_enable_on_vim_startup = 1

set enc=utf-8

" CONDITIONAL SETTINGS
" ====================

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
if &t_Co > 2
    let &t_Co = 256
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

endif " has("autocmd")

" FUNCTIONS AND MISCELLANEOUS
" ===========================

" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap <Leader>i :set list!<CR> " Toggle invisible chars

" Omni Completion *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" au FocusLost * :wa  " Doesn't work well, bc tries to save buffers wo filenames.

if !exists(":Push")
	command -nargs=1 Push call Push(<args>)
endif

function! Push(message)
	exec "!git commit -a -m \"" . a:message . "\""
	!git push
endfunction

if !exists(":Color")
	command Color colorscheme liquidcarbon
endif

if !exists(":Invis")
	command Invis colorscheme invis
endif

if !exists(":Focus")
	command Focus colorscheme focus
endif

if !exists(":Wcdb")
	command Wcdb lcd ~/Documents/wcdb_hub/
endif

command! Prose call ProseMode()
command! NoProse call ProseModeOff()

function! ProseMode()
	map <buffer> iii :Invis<CR>
	map <buffer> fff :Focus<CR>
	map <buffer> ccc :Color<CR>
	imap <buffer> iii <ESC>:Invis<CR>
	imap <buffer> fff <ESC>:Focus<CR>
	imap <buffer> ccc <ESC>:Color<CR>
	setl textwidth=78
	setl formatoptions+=w
	:normal gggqG
endfunction

function! ProseModeOff()
	:Color
	unmap <buffer> iii
	unmap <buffer> fff
	unmap <buffer> ccc
	iunmap <buffer> iii
	iunmap <buffer> fff
	iunmap <buffer> ccc
	setl formatoptions-=w
	setl textwidth=0
endfunction

noh " I don’t know why, but sourcing this highlights the last search. This should undo.
