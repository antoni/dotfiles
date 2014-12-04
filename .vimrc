" vim:fdm=marker " Treat comments as folds
let mapleader=","

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin() 

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"Plugin 'scrooloose/nerdcommenter' " Comments (1)
Plugin 'wincent/Command-T'
Plugin 'spolu/dwm.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-vinegar'
Plugin 'wikitopian/hardmode'
"Plugin 'Yggdroot/indentLine'
Plugin 'nathanaelkane/vim-indent-guides'
" A Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
Plugin 'tomtom/tcomment_vim' " Comments (2)
Plugin 'vim-scripts/gtags.vim'
Plugin 'nelstrom/vim-markdown-folding'
Bundle 'altercation/vim-colors-solarized'
Plugin 'stefandtw/quickfix-reflector.vim'
"Plugin 'Valloric/YouCompleteMe'
" BEGIN snipmate
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/linuxsty.vim'
Plugin 'jpalardy/vim-slime'
Plugin 'SirVer/ultisnips'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'chrisbra/csv.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"

" Optional:
Bundle "honza/vim-snippets"
" END snipmate

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Sets how many lines of history VIM has to remember 
set history=700

set ttyfast
set ttymouse=xterm2
set mouse=a

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

set mouse=a

" Disable Arrow keys in Escape mode
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
" Disable Arrow keys in Insert mode
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

" solarized configuration
set background=dark
colorscheme solarized
" g:solarized_termcolors=16

set cursorline
hi CursorLine term=bold cterm=bold ctermbg=LightCyan guibg=LightCyan

"map <F2> <Plug>NERDCommenterSexy
"imap <F1> <Plug>NERDCommenterToggle
"map <F1> <Plug>NERDCommenterToggle

":set list lcs=tab:\|\

" Vim indent guides setup to work with solarized theme
" let g:indent_guides_enable_on_vim_startup=1
"set ts=4 sw=4 et
"let g:indent_guides_start_level=2
"let g:indent_guides_start_size=1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
"
"
" Vim Indent Guides "
" """""""""""""""""""""
"let g:indent_guides_auto_colors = 1
"augroup indent_guides
"autocmd!
"au BufRead,BufNewFile * IndentGuidesEnable
"augroup END
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

" To turn off vim recording for good
map q <Nop>
" Syntax
syntax on

" ================ Folds ============================

"set foldmethod=indent   "fold based on indent
"set foldnestmax=3       "deepest fold is 3 levels
"set nofoldenable        "dont fold by default

"set foldmethod=syntax
"set foldlevelstart=1

"let javaScript_fold=1         " JavaScript
"let perl_fold=1               " Perl
"let php_folding=1             " PHP
"let r_syntax_folding=1        " R
"let ruby_fold=1               " Ruby
"let sh_fold_enabled=1         " sh
"let vimsyn_folding='af'       " Vim script
"let xml_syntax_folding=1      " XML

":set number
":nmap <C-N><C-N> :set invnumber<CR>
":set numberwidth=3

":set relativenumber
" toggle {off,number,relativenumber}
"for mapmode in ["n", "x", "o"]
"exe mapmode . "noremap <expr> <Leader>0 ToggleNumberDisplay()"
"endfor


"https://gist.github.com/juanpabloaj/1239808
"nmap ª: call ToggleNumberDisplay()
nmap <leader>4 :call ToggleNumberDisplay()<cr>

function! ToggleNumberDisplay()
    if exists('+relativenumber')
        exe "setl" &l:nu ? "rnu" : &l:rnu ? "nornu" : "nu"
    else
        setl nu!
    endif
endfunction

" Line numbers
set number

" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
    " Save the last search.
    let search = @/

    " Save the current cursor position.
    let cursor_position = getpos('.')

    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)

    " Execute the command.
    execute a:command

    " Restore the last search.
    let @/ = search

    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt

    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
    call Preserve('normal gg=G')
endfunction

" Indent on save hook
autocmd BufWritePre <buffer> call Indent()

" clang-format to format C++ according to Google Styleguide
"map <C-I> :pyf /Users/antoni/Developer/clang-format.py<CR>
"imap <C-I> <ESC>:pyf /Users/antoni/Developer/clang-format.py<CR>i

map <C-I> :pyf /Users/antoni/Developer/clang+llvm-3.5.0-macosx-apple-darwin/clang-format.py<cr>
imap <C-I> <c-o>:pyf /Users/antoni/Developer/clang+llvm-3.5.0-macosx-apple-darwin/clang-format.py<cr>


" Configure the cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" Use Astyle (http://astyle.sourceforge.net/) to format C code (Linux Kernel style)
map <leader>fl :! astyle --style=linux %<CR>

" Use Astyle (http://astyle.sourceforge.net/) to format C++ code (Google style)
map <leader>fg :! astyle --style=google %<CR>

"map <F8> to toggle small/normal tabs
noremap <F8> :call <SID>ToggleTabs()<CR>

"Toggles tab size between the default width and 1 character width
"b: buffer-local variables
"&l: buffer-local options
"see :help internal-variables
function! s:ToggleTabs  ()
    if !exists("b:tab_toggler_large")
        let b:tab_toggler_large = 1
    endif
    if b:tab_toggler_large == 0 
        let b:tab_toggler_large = 1 
        let &l:ts = b:tab_toggler_ts
        let &l:sw = b:tab_toggler_sw
        let &l:sts = b:tab_toggler_sts
    else
        "save the previous tab settings
        let b:tab_toggler_large = 0
        let b:tab_toggler_ts = &ts
        let b:tab_toggler_sw = &sw
        let b:tab_toggler_sts = &sts
        let &l:ts = 1
        let &l:sw = 1
        let &l:sts = 1
    endif
endfunction

"set colorcolumn=80
"highlight ColorColumn ctermbg=DarkGray " Standard Vim
"highlight ColorColumn guibg=LightYellow " MacVim

" Highlight text that goes over 80 characters
" http://stackoverflow.com/a/235970/963881
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

set textwidth=80
set formatoptions+=w " gggqG - format to break after 80 characters

set wrapmargin=2

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

" OCaml stuff
let no_ocaml_comments = 1
set makeprg=ocamlbuild\ ${BUILDFLAGS}\ -use-ocamlfind\ all.otarget
set makeprg=omake\ -j\ 8
"
" Syntastic
" let g:syntastic_ocaml_use_ocamlc = 1
let g:syntastic_ocaml_use_ocamlbuild = 1
let g:syntastic_ocaml_checkers = ['merlin']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => OCaml support (Merlin, no ocp-ident configured at the moment)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" http://stackoverflow.com/a/741486/963881
set tags=./tags;/

set virtualedit=onemore

" Cursor color & shape
if &term =~ "xterm\\|rxvt"
    " use an orange cursor in insert mode
    let &t_SI = "\<Esc>]12;orange\x7"
    " use a red cursor otherwise
    let &t_EI = "\<Esc>]12;red\x7"
    silent !echo -ne "\033]12;red\007"
    " reset cursor when vim exits
    autocmd VimLeave * silent !echo -ne "\033]112\007"
    " use \003]12;gray\007 for gnome-terminal
endif

if &term =~ '^xterm'
    " solid underscore
    let &t_SI .= "\<Esc>[4 q"
    " solid vertical bar
    let &t_EI .= "\<Esc>[1 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
endif

" map <C-I> :pyf /Users/antoni/Developer/clang+llvm-3.5.0-macosx-apple-darwin/clang-format.py<cr>
"imap <C-I> <c-o>:pyf /Users/antoni/Developer/clang+llvm-3.5.0-macosx-apple-darwin/clang-format.py<cr>

" Compiler settings for C/C++ files
"au BufEnter *.cc compiler g++
"au BufEnter *.cpp compiler g++
"au BufEnter *.c compiler gcc

autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
    if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
    else
        return "\<Tab>"
    endif
endfunction
":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Remap code completion to Ctrl+Space {{{2
"inoremap <Nul> <C-x><C-o> 
" In your case you want:
"
"inoremap <Nul> <C-n>

if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
    if has("unix")
        inoremap <Nul> <C-n>
    else
        " I have no idea of the name of Ctrl-Space elsewhere
    endif
endif

:set dictionary="/usr/dict/words"

set tags+=/Users/antoni/.vim/tags/cpp

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


" OCaml
" au BufRead,BufNewFile *.ml,*.mli compiler ocaml
set sb
map <F5> :split /tmp/ocaml \| %d \|setlocal ft=omlet \| setlocal autowrite \| r!ocaml < # <CR>
map <F6> :dr /tmp/ocaml \| %d \|setlocal ft=omlet \|setlocal autowrite \| r!ocaml < # <CR>



" TODO:
" source: http://stackoverflow.com/a/2506955/963881
":%!astyle (simple case - astyle default mode is C/C++)
":%!astyle --mode=c --style=ansi -s2 (ansi C++ style, use two spaces per indent level)
"or
":1,40!astyle --mode=c --style=ansi

" Tagbar configuration
nmap <F7> :TagbarToggle<CR>


" Tabs
set expandtab
set tabstop=4
retab " change all the existing tab characters to match the current tab settings
set shiftwidth=4

" Show ruler on the bottom
set ruler

" vim=slime config
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_python_ipython = 1
" tmux target pane
":" means current window, current pane (a reasonable default)
"":i" means the ith window, current pane
":i.j" means the ith window, jth pane
""h:i.j" means the tmux session where h is the session identifier (either 
" session name or number), the ith window and the jth pane


set noswapfile " Disable swap file creation
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
set colorcolumn=80

" VIM airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

