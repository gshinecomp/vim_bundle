
" when started as "evim", evim.vim will already have done these setting
if v:progname =~? "evim"
    finish
endif

"====================================================================
" New Hotkey:
" 1. grep keyword in file
"    current word:
"      K: grep current word for whole current file
"    search pattern:  
"      F: grep one current search pattern for whole current file from 1st line
"     nF: grep n   current search pattern for whole current file from 1st line
"    nFF: grep n   current search pattern for whole current file from current line
"    quickfix window
"    <F3> open quickfix
" 2. <F2> :NERDTreeToggle
" 3. <F5> vim align to right (for selection)
"    <F10> count number of occurances of current word
" 4. <F12> syntax sync fromstart
" 5. vim gui operation
"      switch vim tabs with Ctrl + left|right
"      move vim tabs with Ctrl + left|right
"
"      provide hjkl movements in Insert mode via the <Alt> modifier key
" 6. <F9> folding switch (toggle)
"    <Space> visual select and <Space> to fold a region
"            <Space> is fold open/close key
" 7. <C-Up> <C-Down> gvim font size change
" 8. <C-W>c cursorcolumn toggle
" 9. Improve undo in insert mode
"    Ctrl-u deletes text you've typed in the current line
"    Ctrl-w deletes the word before the cursor. 
" 9. \do diff current edit file
"    \dc close diff window for current orig file(left window)
"10. \zj and \zk to find next/previous folding block (binding)
"    or plugin FastFold
"     zj/zk find next/previous folding block
"     ]z/[z find bonding (boundary?)
"     zuz   update folding changes
"11. buffer explorer:
"    \be  start buffer explorer
"    \bs  start buffer explorer in a newly split horizontal window
"    \bv  start buffer explorer in a newly split vertical   window
"
" New Command Or Function:
" 1. define search include slash command :Ss [some/thing]
" 2. folding/command auto save/restore: by mkview and loadview
"    set fdc=2 to show folding mark
" 3. ~/bin/scripts/vim_reduce_backup.sh can clean ~/.vim_backups to 5 backup files for each file. 
" 4. for large files(> 10MB), set to nobackup, noswap, and readonly for faster loading.
"
" New Setting:
" 1. set formatoptions - disable auto-wrap comments on some filetype
"
" Plugin:
" 1. set fdm=syntax  enable verilog_systemverilog.vim syntax folding
" 2. tohtml
"    the command is :TOhtml
"    or vim +"run! syntax/2html.vim" +"wq" +"q" rtl.v
" 3. tabular
"    align the keyword  :Tab/\/\/
" 4. markdown	:MarkdownPreview
"
" Useful Shortcut Hint:
" 1. C-w = : make all split screens have the same width
" 2. gf    : open file at the cursor
"    C-w gf: open file at the cursor to new tab
"    C-o   : back from gf (or last move/jump)
" 3. ''    : jump to last position
"    g; and g, : move to back and forward in the list of ":ju[mps]"
" 4. in the insert mode, C-x C-f to autocomplete the filename at the cursor.
"
" Useful Hint:
" 1. modeline magic example at the file EOF:
"    # vim: fdm=marker fdl=10
" 2. sort the 6th column:
"    :%!sort -k6nr
" 3. column the lines:
"    :%!column -t
" 4. snapshot/session - store all the tabs in gvim
"    save session
"      :mksession session.vim
"      :mks session.vim
"    restore session
"      vim -S session.vim
"      :source session.vim
"
"====================================================================

" basic vim setting
set autoindent
set laststatus=2
"set history=50		" keep 50 lines of command line history
"set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
"set cmdheight=1	" control the cmdline height
set incsearch		" do incremental searching

" use vim settings, rather then Vi settings (much better!).
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set cursorline
" binding the cursorcolumn toggle
nnoremap <silent> <C-W>c :set cursorcolumn!<CR>
inoremap <silent> <C-W>c <C-O>:set cursorcolumn!<CR>

" default max tabpagemax is 10. Will crash in vim-airline
set tabpagemax=99

" GUI gvim setting
"   for win32gui, remove 't' flag from guioptions, norearoff menu entries
"   m:menubar T:toolbar r:right scrollbar e:tab
set go=aegimrLtT
set go-=m
"set go-=T

set guifont=Hack\ 13

" syntax improve for bash
let g:is_bash=1

" eliminate esc delay for tmux
"set ttimeoutlen=100

"=================
" vim color setting
"=================
" gvim color setting
"highlight Normal term=none cterm=none ctermfg=white ctermbg=black guifg=white guibg=black

if &t_Co == 256 || &t_Co == ""
  colorscheme koehler
endif

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if has('mouse')
    set mouse=a
    " smooth mouse selection
    "set ttymouse=xterm2
endif

"=================
" vim indent setting - :set ci pi ts=8 sts=0 sw=4 tw=0
"=================
set copyindent
set preserveindent
set tabstop=8
set softtabstop=0
set shiftwidth=4
set textwidth=0

set smarttab
"set expandtab
"set noexpandtab

" stop indentexpr= at filetype tcsh/csh/sh
autocmd BufRead * if (&ft=='tcsh' || &ft=='csh' || &ft=='sh') | setlocal indentexpr= | endif

" disable auto-wrap comments using textwidth, inserting the current comment leader
"autocmd FileType vim,verilog setlocal formatoptions-=c

" Don't use Ex mode(orignal Q map to Ex mode), use Q for formatting
" gq: reformatting by textwidth, wrap the text
map Q gq

"=================
" vim backup setting
"=================
set backup        " keep a backup file (restore to previous version)
if has('persistent_undo')
    set undofile    " keep an undo file (undo changes after closing)
endif

"Incremental backups, will copy the backup file to a specific backup
"directory and follow the tree structure of the file's directory
"This allows for backup up from multiple drives (on Windows) and easy
"navigation through the backups afterwards.
let g:this_root_backup_dir = '~/.vim_backups'
"let g:this_backup_dir = g:this_root_backup_dir . '/' . strpart(expand('%:p:h'), 1)
" expand - p:full path , h: head, t: tail, r: root(file), e: extension, :p:h : dirname
let g:this_backup_dir = g:this_root_backup_dir . '/' . expand('%:p:h:t')
" install mkdirhier in ubuntu: sudo apt install xutils-dev
"--make directory under DRIVE if it doesn't exist
if !filewritable(g:this_backup_dir)
  silent execute expand('!mkdirhier ' . g:this_backup_dir)
endif
"--set new backup dir
execute expand('set backupdir=' . g:this_backup_dir)

augroup backup
    autocmd!
    "autocmd BufWritePre,FileWritePre * let &l:backupext = '~' . strftime('%F') . '~'
    autocmd BufWritePre,FileWritePre * let &l:backupext = '~' . strftime('%y%m%d_%H:%M:%S') . '~'
augroup END

"	let g:this_root_backup_dir = 'f:\vim_backups'
"	let g:this_dir = expand('%:p:h')
"	let g:this_filename = expand('%')
"	let g:this_drive = strpart(g:this_dir, 0, 1)
"	let g:this_backup_dir_drive = g:this_root_backup_dir . '\' . g:this_drive
"	let g:this_backup_dir = g:this_backup_dir_drive . '\' . strpart(g:this_dir, 3)

"=================
" vim faster loading of large files
"=================
" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  " Large files are > 10M
  " Set options:
  " x eventignore+=FileType (no syntax highlighting etc " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowrite (file is read-only)
  " x undolevels=-1 (no undo possible)
  " a nobackup nowritebackup
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    "autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | setlocal noswapfile bufhidden=unload buftype=nowrite nobackup nowritebackup | endif
    augroup END
endif

"===================================================================
" Vundle setting Begin
"===================================================================
" 1. Install
"    sudo apt-get install git curl
"    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" lean & mean status/tabline for vim that's light as air
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" $ mkdir .font/
" $ cd .font/
" $ git clone https://github.com/Lokaltog/powerline-fonts.git 
" $ cd powerline-fonts/
" $ ./install.sh

" The following are all installed plugin.
Plugin 'scrooloose/nerdtree'

" Plugin to integrate Grep search tools with Vim 
" old version 1.1 https://github.com/vim-scripts/grep.vim
" new version 2.2 https://github.com/yegappan/grep
" new version 2.2 https://www.vim.org/scripts/script.php?script_id=311
Plugin 'yegappan/grep'

" Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'kien/ctrlp.vim'

" Speed up Vim by updating folds only when called-for.
Plugin 'Konfekt/FastFold'

" Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
" neweset URL: https://www.vim.org/scripts/script.php?script_id=273
"Plugin 'vim-scripts/taglist.vim'
"Plugin 'taglist.vim'
Plugin 'taglist.vim', {'pinned': 1}

" Plugin to manage Most Recently Used (MRU) files
"Plugin 'vim-scripts/mru.vim'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'mru.vim'

" Highlight lines or patterns of interest in different colors 
"Plugin 'vim-scripts/highlight.vim'
Plugin 'highlight.vim'

" Vim plugin to diff two directories
Plugin 'will133/vim-dirdiff'

" BufExplorer Plugin for Vim
Plugin 'jlanzarotta/bufexplorer'
" Elegant buffer explorer - takes very little screen space
""Plugin 'fholgado/minibufexpl.vim'

" 'delview' command to delete mkview/loadview files
"Plugin 'vim-scripts/delview'
Plugin 'delview'

" Vim script internal debugger (output in separate window, tab, or remote vim)
"Plugin 'vim-scripts/Decho'
Plugin 'Decho'

" Verilog/SystemVerilog Syntax and Omni-completion
Plugin 'vhda/verilog_systemverilog.vim'

" verilog filetype plugin to enable emacs verilog-mode autos
"Plugin 'vim-scripts/verilog_emacsauto.vim'

" " extended % matching for HTML, LaTeX, and many other languages
" Plugin 'vim-scripts/matchit.zip'

"	" The following are examples of different formats supported.
"	" Keep Plugin commands between vundle#begin/end.
"	" plugin on GitHub repo
"	Plugin 'tpope/vim-fugitive'
"	" plugin from http://vim-scripts.org/vim/scripts.html
"	" Plugin 'L9'
"	" Git plugin not hosted on GitHub
"	Plugin 'git://git.wincent.com/command-t.git'
"	" git repos on your local machine (i.e. when working on your own plugin)
"	Plugin 'file:///home/gmarik/path/to/plugin'
"	" The sparkup vim script is in a subdirectory of this repo called vim.
"	" Pass the path to set the runtimepath properly.
"	Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"	" Install L9 and avoid a Naming conflict if you've already installed a
"	" different version somewhere else.
"	" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"	" To ignore plugin indent changes, instead use:
"	"filetype plugin on
"	"
"	" Brief help
"	" :PluginList       - lists configured plugins
"	" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"	" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"	" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"	"
"	" see :h vundle for more details or wiki for FAQ
"	" Put your non-Plugin stuff after this line

"=======================
" nerdtree
"=======================
map <F2> :NERDTreeToggle<CR>

"=======================
" ctrlp
"=======================
" C-P: run the ctrlp
" C-Q: exit the ctrlp
" <c-f> and <c-b> to cycle between modes.
" <c-r> to switch to regexp mode.
" <c-z> to mark/unmark multiple files and <c-o> to open them.

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_regexp = 1
let g:ctrlp_extensions = ['tag', 'line']
let g:ctrlp_match_window = 'botton,order:btt,min:1,max:10,results:25'

let g:ctrlp_max_files = 10000
let g:ctrlp_max_depth = 40

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|trash)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_open_multiple_files = 't'

"=======================
" Taglist, Tagbar, ctags
"=======================
"set tags=./tags,tags;

let Tlist_Show_Menu = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
nnoremap <silent> tl :TlistToggle<CR>

let g:tagbar_left = 1 " open tagbar at left
nnoremap <silent> tb :TagbarToggle<CR>

"=======================
" FastFold
"=======================
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']

"=======================
" vim-dirdiff
"=======================
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.*.swo,.svn"
let g:DirDiffIgnore = "Id:,Revision:,Date:"
let g:DirDiffWindowSize = 5 " Sets the diff window (bottom window) height (rows)
" let g:DirDiffSort = 1
" let g:DirDiffIgnoreCase = 1
" let g:DirDiffAddArgs = "-w"

" stop autoswap plugin when diff
if &diff | let loaded_autoswap = 1 | endif

"=======================
" systemverilog fold config
"=======================
" Note1: The commands |:VerilogFoldingAdd| and |:VerilogFoldingRemove| are provided to allow an easier management of this variable.
" Note2: To enable syntax folding set the following option: set foldmethod=syntax or set fdm=syntax
let g:verilog_syntax_fold_lst = "instance,block,function,task"

"=======================
" vim-airline
"=======================
" use theme - :AirlineTheme {theme-name}
let g:airline_theme = "badwolf"
"let g:airline_theme = "murmur"
"let g:airline_theme = "molokai"
" enable powerline-fonts
let g:airline_powerline_fonts = 1

let g:airline#extensions#whitespace#checks = [ ]

" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
"
" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" "let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" "let g:airline_symbols.linenr = '☰'
" "let g:airline_symbols.maxlinenr = ''
"
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.linenr = '⭡'
" let g:airline_symbols.maxlinenr = '㏑'


"===================================================================
" Vundle setting End
"===================================================================

"=================
" vim search
"=================
" define search include slash command :Ss [some/thing]
command! -nargs=1 Ss let @/ = escape(<q-args>, '/')|normal! /<C-R>/<CR>

"=================
" vim+grep
"=================
nnoremap <silent> K :silent grep "\b<C-R><C-W>\b" %<CR>:call QFixToggle()<CR>
"nnoremap <silent> F :<C-U>silent exe "grep -m" . v:count1 . ' "<C-R>/" %'<CR>:call QFixToggle()<CR>
nnoremap <silent> F :exe "grep -m" . v:count1 . ' "<C-R>/" %'<CR>:call QFixToggle()<CR>
nnoremap <silent> FF :<C-U>silent cexpr system('grep_cnt.sh "<C-R>/" ' . expand('%') . ' ' . v:count1 . ' ' . line('.'))<CR>:call QFixToggle()<CR>

map <silent> <F3> :call QFixToggle()<CR>
function! QFixToggle()
  if exists("g:qfix_win")
    cclose
    unlet g:qfix_win
  else
    copen 5
    "or - cwindow 5
    let g:qfix_win = 1
  endif
endfunction

"=================
" syntax related
"=================
" syntax redraw method
" min command: syntax sync minlines=200
noremap <F12> :syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

"=================
" vim GUI
"=================
" switch vim tabs with Ctrl + left|right
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
" move vim tabs with Ctrl + left|right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-h> <left>
inoremap <A-j> <down>
inoremap <A-k> <up>
inoremap <A-l> <right>

"=================
" vim align to right
"=================
" vim align to right
map <F5> :s/^/@ / \| '<,'>s/$/=/ \| '<,'>! rev \|column -ts= \|column -t \| rev \|column -ts=@ <CR>

"=================
" gvim font size change
"=================
if has('gui_running')
    nnoremap <silent> <C-Up> :silent! let &guifont = substitute(
     \ &guifont,
     \ '\zs\d\+',
     \ '\=eval(submatch(0)+1)',
     \ 'g')<CR>
    nnoremap <silent> <C-Down> :silent! let &guifont = substitute(
     \ &guifont,
     \ '\zs\d\+',
     \ '\=eval(submatch(0)-1)',
     \ 'g')<CR>
endif

"=================
" add pair of parentheses, braces, etc...
"=================
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap [[     [
inoremap []     []

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap ((     (
inoremap ()     ()

inoremap "      ""<Left>
inoremap "<CR>  "<CR>"<Esc>O
inoremap ""     "

inoremap '      ''<Left>
inoremap '<CR>  '<CR>'<Esc>O
inoremap ''     '

"=================
" improve undo in insert mode
"=================
" https://github.com/tpope/vim-sensible/issues/28
" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U without undoing what you typed before it.

" In insert mode, pressing Ctrl-u deletes text you've typed in the current line,
inoremap <C-U> <C-G>u<C-U>
" and Ctrl-w deletes the word before the cursor. 
inoremap <C-W> <C-G>u<C-W>

"=================
" set newtype on some extension
"=================
au BufRead,BufNewFile *.task setfiletype verilog
"au BufNewFile,BufRead *.md set filetype=markdown

"=================
" Folding operation
"=================
" <F9> to toggle folder
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf
" visual selection then <space> to fold a region
nnoremap <silent> <Space> :exe 'silent! normal! za'.(foldlevel('.')? '':'\<Space>')<CR>
" space to toggle folder
vnoremap <Space> zf

" show folding mark
"set foldcolumn=2
"set fdc=2

" detect next fold block (someone says this is not a good code???)
" <Leader> default is "\"
nnoremap <silent> <leader>zj :call NextClosedFold('j')<CR>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<CR>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

"=================
" diff with current buffer and the original file
"=================
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
" <Leader> default is "\"
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <Leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

"=================
" word, count current word match number
"=================
function! Count(word)
    let count_word = "%s/\\<" . a:word . "\\>//gn"
    let save_cursor = getpos(".")
    execute count_word
    call setpos('.', save_cursor)
endfunction

" count number of occurances of a word
nmap <F10> <Esc>:call Count(expand("<cword>"))<CR>

"=================
" view and makeview, loadview
"=================
let g:skipview_files = [
	    \ 'svn-commit.tmp'
    	    \ ]
function! MakeViewCheck()
    " File is in skip list
    if index(g:skipview_files, expand('%')) >= 0
    	return 0
    endif
    " Buffer is marked as not a file
    if has('quickfix') && &buftype =~ 'nofile'
    	return 0
    endif
    " File does not exist on disk
    if empty(glob(expand('%:p')))
    	return 0
    endif
    " we're in a temp dir
    if len($TEMP) && expand('%:p:h') == $TEMP
    	return 0
    endif
    " no makeview in /tmp
    if expand('%:p:h') =~ "/tmp"
    	return 0
    endif
    " when delview executed
    if (exists('g:Delview_executed'))
    	let g:Delview_executed = ""
    	"call histdel('/')
    	call cursor(1,1)
    	return 0
    endif
    " else
    return 1
endfunction

augroup vimrcAutoView
    autocmd!
    " Autosave & Load Views.
    " not active mkview/loadview when in diff program
    autocmd BufWinLeave,BufWritePost,BufLeave,WinLeave ?* if MakeViewCheck() | mkview | endif
    autocmd BufWinEnter ?* if &diff || (v:progname =~ "diff") | call cursor(1,1) | elseif MakeViewCheck() | silent! loadview | endif
augroup end

" "=================
" " toggle transparent
" "=================
" let t:is_transparent = 0
" function! Toggle_transparent()
"     if t:is_transparent == 0
"         hi Normal guibg=NONE ctermbg=NONE
"         let t:is_transparent = 1
"     else
"         set background=dark
"         let t:is_tranparent = 0
"     endif
" endfunction
" nnoremap <C-t> : call Toggle_transparent()<CR>
" 
