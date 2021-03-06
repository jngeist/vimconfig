" vim:fdm=indent

"SETTINGS AND VARIABLES
"======================
"
"Plugin Variables
    let g:NERDTreeShowBookmarks = 1
    let g:tagbar_left = 1
    let g:tagbar_autoshowtag = 1
    let g:lucius_style='blue'
    let g:liquidcarbon_high_contrast = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:LustyJugglerSuppressRubyWarning = 1
    let g:pyflakes_use_quickfix = 0

python << EOF
import os.path, vim
paths = {
    "/home/jngeist": "a2ssh",
    "/home/joshuag": "cossh",
    "/Users/jngeist": "laptop",
    "/Users/joshuag": "cos",
    "/Users/mysphyt": "home",
}
home = vim.eval("$HOME")
if home in paths:
    vim.command("let g:NERDTreeBookmarksFile = '" + home + "/.vim/bookmarks/" + paths[home] + "_bookmarks'")
EOF

" Clear Autocommands
    au!

"Load Pathogen
    filetype off
    call pathogen#runtime_append_all_bundles() 
    call pathogen#helptags() 
    filetype plugin indent on

"Basic vim settings
    "Enable syntax highlighting
	syntax on
    set background=dark
    set nocompatible "No vi compatible mode.
    set backupdir=~/.vim/backup " By default, vim creates backups for every file
        " edited, so you get your project littered w/ filename.ext~ files.  This puts
        " them all in a hidden .backup directory.
    set directory=/tmp " Ditto filename.ext.swp files; necessary for vim to
        " work right, but you don't want them cluttering up your project directory.
    set history=100		" command history = 100
    set showcmd			" display incomplete commands
    set hidden			" allows for hidden buffers
    set number
    set textwidth=80
    set wrapmargin=2
    set linebreak
    let &showbreak='└─'
    set enc=utf-8
    set listchars=trail:.,tab:>-,eol:$
    set nolist
    set anti			" font antialiasing
    set guioptions=egmLt
    set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
    set clipboard+=unnamed
    set wmh=0			" allows one-line window height
    set noea			" doesn't resize all windows on split.
    set autoread		" reload files that have changed in filesystem but not in vim
    set gfn=DejaVuSansMono:h10
    set modeline

    set shell=/bin/bash

"Editing Settings
    set backspace=indent,eol,start "allow backspacing over everything in insert mode
    set spelllang=en_us "spelling in English
    " Tabs
    set tabstop=4		" with of tab char = 4
    set softtabstop=4
    set shiftwidth=4	" width of indent w/ >: 4
    set expandtab		
    set showmatch		" highlight matching bracket/parent/etc
    set incsearch		" do incremental searching
    set ignorecase		" ignore case in searching, unless
    set smartcase		" search string includes uppercase characters

" Statusline
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
    set statusline+=\ L:%l/%L   "cursor line/total lines
    set statusline+=\ (%P)    "percent through file
    set laststatus=2        " Always show status line

    " Statusline Function: Display Highlight Group
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

" Folding

    " Spacebar opens folds.
    map <Space> za
    map <Space><Space> zA

    set foldenable " Turn on folding
    set foldmarker={,} " Fold C style code (only use this as default 
    set foldmethod=marker " Fold on the marker
    set foldlevel=100 " Don't autofold anything (but I can still 
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements
    set foldcolumn=4
    "Folding function: text for fold headers
    function! SimpleFoldText() " 
    	return getline(v:foldstart).' '
    endfunction " }
    set foldtext=SimpleFoldText() " Custom fold text function 

" Mappings
    let mapleader = ","  "Leader key mapped to , .  (Leader is basically a custom meta key, so you can define commands to <Leader><Whatever>
    " Toggle invisible chars
    noremap <Leader>i :set list!<CR> 
    imap jj <Esc>
    nmap oo :put =''<CR> 
    nmap OO :put! =''<CR>
    nmap // :noh<CR>
    map <C-J> <C-W>j
    map <C-K> <C-W>k
    map <C-L> <C-W>l
    map <C-H> <C-W>h
    map H ^
    map L $
    map Y y$

    nmap <Leader>yf :let @* = expand("%:p")<CR>
    nmap <CR> <C-]>

    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>

    nnoremap <tab> %
    vnoremap <tab> %
    nnoremap j gj
    nnoremap k gk
    map Q gq
    map <Leader><CR> i<CR><ESC>k$

    map <Leader>rp :RainbowParenthesesToggle<CR>
    map <Leader>nt :NERDTreeToggle<CR>
    map <Leader>l :TagbarToggle<CR>
    map <Leader>. :call AddNote()<CR>
    map <Leader><tab> :LustyJuggler<CR>
    noremap <Leader>t :CommandT<CR>
    map <Leader>cd :lcd `dirname '%:p'`<CR>
    map <Leader>gd :set ft=htmldjango<CR>
    map <Leader>gm :set ft=mmd<CR>
    map <Leader>gi :call InvisModeToggle()<CR>
    map <Leader>gf :call FocusModeToggle()<CR>


" Terminal Settings
" ====================
    " Use mouse
    if has('mouse')
    	set mouse=a
    endif

    " Up colors for teminal emulators
    if &t_Co > 2
        let &t_Co = 256
        colors molokai
    else
        let g:solarized_hitrail=1
        colorscheme solarized
    endif

    " Turn off cursor marking for non-gui clients
    if has("gui_running") == 0
        set nocursorline
        set nocursorcolumn
    endif

    syntax on

" Autocommands
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    au FileType mmd map <leader>mp :silent ! open -a Marked.app "%:p"<CR>
    au FileType mmd map <leader>op :silent ! mmd.sh -p "%:p"<CR>
    au FileType mmd map <leader>ob :silent ! mmd.sh -b "%:p"<CR>
    au FileType mmd nmap <Leader>yh :silent redir @*><CR>:silent! !/usr/local/bin/multimarkdown "%:p"<CR>:silent redir END<CR>:echo "HTML yanked."<CR>
    au FileType mmd nmap <Leader>gh :%!/usr/local/bin/multimarkdown<CR>
    au FileType mmd setlocal linespace=8
    au FileType mmd setlocal spell

    au BufWritePre *.mmd call UpdateWordCount()
    au BufWritePost *.mmd let v:statusmsg = WordCount()
    au InsertLeave *.mmd exe "colors " . g:colors_name

    au BufWritePost *.scss call SassDump()

    au FileType python set fdm=indent

    " Omni Completion
        autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
        autocmd FileType python set omnifunc=pythoncomplete#Complete
        autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType css set omnifunc=csscomplete#CompleteCSS
        autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        autocmd FileType c set omnifunc=ccomplete#Complete

" Various functions
    function! WordCount()
        normal mcgg
        let firstblank = search('^$')
        if firstblank
            if search('[^ ]\+',  "nW")
                exe "silent " . firstblank . ",$s/[^ ]\\+//gn"
                let wordcount = str2nr(split(v:statusmsg)[0])
            else
                let wordcount = 0
            endif
        else
            let wordcount = 0
        endif
        normal `c
        return wordcount
    endfunction

    function! UpdateWordCount()
        let wordcount = WordCount()
        normal mcgg
        let countline = search('^Word Count\s*:', 'w')
        if countline
            exe countline . "," . countline . "s/\\d\\+ *$/" . wordcount . "/"
        endif
        normal `c
    endfunction

    function! SassDump()
        "silent call StripSassConstants()
        if strpart(expand("%:t"), 0, 1) != "_"
            silent! !sass --update "%:p"       
            echo expand("%<") . ".scss updated."
        endif
    endfunction

    function! StripSassConstants()
        normal mcgg
        let firstnonvar = search("^[^$]", "wn")
        while line(".") < firstnonvar
            let line = getline(line('.'))
            let varname = substitute(line, "^\\(\\$\\w*\\):.*", "\\1", "")
            let varval = substitute(line, "^.*:\\s*\\(.*\\);", "\\1", "")
            exec firstnonvar . ",$s/" . varval . "/" . varname . "/ge"
            normal j
        endwhile
        normal `c
    endfunction

    function! Push(message)
    	exec "!git commit -a -m \"" . a:message . "\""
    	!git push
    endfunction

    command! -nargs=1 Push call Push(<args>)

    function! AddNote()
        silent normal ma"byi]
        if search("^[" . getreg("b") . "\\]:\\s\\+" . getreg("*"), "n")
            echo "Marker " . getreg("b") . " already exists for " . getreg("*")
        elseif search("^[" . getreg("b") . "\\]:", "n")
            echo "Marker " . getreg("b") . " is a duplicate.  Please choose another."
        else
            let action = "\<C-R>*\<ESC>`a"
            let startchar = strpart(getreg("b"), 0, 1)
            if startchar == "^"
                let tag = "FOOTNOTES"
                let action = ''
            elseif startchar == "#"
                let tag = "SOURCES"
            else
                let tag = "LINKS"
            endif
            if ! search("<!--" . tag . "-->")
                exe "silent normal Go\<CR><!--" . tag . "-->\<ESC>"
                exe "silent normal A\<CR>\<CR><!--END" . tag . "-->\<ESC>kk"
            endif
            exe "silent normal A\<CR>\<CR>[\<C-R>b]: " . action
            if action == ''
                echo "`a to return to marker."
            else
                echo getreg("*") . " added to " . tag . " as [" . getreg("b") . "]."
            endif
        endif
    endfunction

    function! GetColors()
        redir => hiline
        silent hi normal
        redir END
        let bgcolor = substitute(hiline, ".*guibg=\\(\\S*\\).*", "\\1", "")
        let fgcolor = substitute(hiline, ".*guifg=\\(\\S*\\).*", "\\1", "")
        let cbgcolor = substitute(hiline, ".*ctermbg=\\(\\S*\\).*", "\\1", "")
        let cfgcolor = substitute(hiline, ".*ctermfg=\\(\\S*\\).*", "\\1", "")
        redir => cline
        silent hi CursorLine
        redir END
        let clcolor = substitute(cline, ".*guibg=\\(\\S*\\).*", "\\1", "")
        let cclcolor = substitute(cline, ".*ctermbg=\\(\\S*\\).*", "\\1", "")


        return {'bgcolor': bgcolor, 'fgcolor': fgcolor, 'cbgcolor': cbgcolor, 'cfgcolor': cfgcolor, 'clcolor': clcolor, 'cclcolor': cclcolor}
    endfunction

    function! FocusModeToggle()
        silent exe "colorscheme " . g:colors_name
        if exists("b:prosemode") && b:prosemode == "focus"
            let b:prosemode = "none"
        else
            let b:prosemode = "focus"
            let colors = GetColors()
            if has("gui_running") == 0
                exe "hi Normal ctermfg=" . colors["cbgcolor"]
                exe "hi CursorLine ctermfg=" . colors["cfgcolor"] . " ctermbg=" . colors["cclcolor"]
                setlocal cursorline
            else
                exe "hi Normal guifg=" .  colors["bgcolor"]
                exe "hi CursorLine guibg=" . colors["clcolor"] . " guifg=" . colors["fgcolor"]
                setlocal cursorline
            endif
        endif
    endfunction

    function! InvisModeToggle()
        silent exe "colorscheme " . g:colors_name
        if exists("b:prosemode") && b:prosemode == "invis"
            let b:prosemode = "none"
        else
            let colors = GetColors()
            if has("gui_running") == 0
                " Hack - black bc I can't get this working right.
                exe "hi Normal ctermfg=" .  colors["cclcolor"]
                exe "hi CursorLine ctermfg=" . colors["cfgcolor"] . " ctermbg=" . colors["cfgcolor"]

                setlocal cursorline
            else
                exe "hi Normal guifg=" .  colors["bgcolor"]
                exe "hi CursorLine guifg=" . colors["clcolor"] . " guibg=" .  colors["clcolor"]
                setlocal cursorline
            endif
            let b:prosemode = "invis"
        endif
    endfunction

" Stuff to sort through:
    "map <leader>p  <Esc>:%!json_xs -f json -t json-pretty<CR>
