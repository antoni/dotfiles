" vim:set foldmethod=marker foldlevel=0 cursorcolumn cursorline:
" 1.  General settings {{{
let os = substitute(system('uname'), "\n", "", "")

" Suppress 'No write since last change'
set hidden
set confirm

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 
set complete+=k
set complete-=i

" Allow opening C++'s includes using 'gf'
set path+=/usr/include/c++/*

" Fix: http://stackoverflow.com/a/12487439/963881
" argdo set eventignore-=Syntax | tabedit

let mapleader=","
set nocompatible              " be iMproved, required
" set noesckeys
set timeoutlen=1000 ttimeoutlen=0

" Replace the current selection with buffer"{{{
"}}}
" Turn off vim recording for good
" map q <Nop>
" Disable Ex mode
map Q <Nop>
set ignorecase                " Ignore case when searching
syntax on                     " Syntax colouring
set pastetoggle=<F12>         " pastetoggle (sane indentation on pastes)
set ruler                     " Show ruler on the bottom
set virtualedit=onemore
set textwidth=80
set formatoptions+=w          " gggqG - format to break after 80 characters
set wrapmargin=2
set autoread " Set to auto read when a file is  changed from the outside
" UTF-8 encoding
set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
set title
" For regular expressions turn magic on
set magic
" Alias unnamed register to the + register, which is the X Window clipboard
" Use +p to paste from the X clipboard (or Ctrl-r-+/* in Insert mode)
set clipboard^=unnamed,unnamedplus
" Don't redraw while executing macros (good performance config)
set lazyredraw

set complete+=k
set complete-=i
" Clear terminal before executing the command
" Adding -i significantly slows down Vim's startup 
" (it's needed to run aliases though)
" set shell=/bin/bash\ -i
set shell=/bin/bash
" set shell=~/.vim/shell-wrapper.sh
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
" Disable swap file creation"{{{
set noswapfile 
"}}}
" Tabs"{{{
set expandtab
set tabstop=4
retab " change all the existing tab characters to match the current tab settings
set shiftwidth=4
"}}}
" Configure the cursor"{{{
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"}}}
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
set colorcolumn=80
set dictionary="/usr/dict/words"
set number                    " Line numbers
" set numberwidth=3
set history=700               " How many lines of history VIM has to remember 
set ttyfast
set ttymouse=xterm2
set mouse=a

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Enable filetype plugins
filetype plugin on
filetype indent on

" Auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
"Searching"{{{
set incsearch " find as you type search
set hlsearch                    " highlight search terms
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
"}}}
set wildmenu   " Turn on the WiLd menu
set mouse=a
" Remember to (settings outside the vimrc) "{{{
"  1. Swap Esc and Caps lock 
"  (http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_XWindows)
""}}}
" }}}
" 2.  Key mappings {{{
" Temporary mappings "{{{
au BufEnter,BufNew *.java noremap <F5> :wa \| !javac -verbose % && java %:r : <CR>
" C++ quick compilation
" noremap <F5> :wa \| !clang++ -g -Wall -pthread -std=c++11 % -o test && ./test : <CR>
noremap <F5> :wa \| !clang++ -g -Wall -Wno-missing-braces -pthread -std=c++1z % -o test && ./test : <CR>
noremap <F6> :wa \| !clang++ -g -Wall -include /usr/include/x86_64-linux-gnu/c++/4.8/bits/stdc++.h -pthread -std=c++11 % -o test && ./test : <CR>
" au BufEnter,BufNew *.c noremap <F5> :wa \| !clang -std=c99 -g % -o test && ./test : <CR>
au BufEnter,BufNew *.c noremap <F5> :wa \| !clang -Wall -std=c99 -lcmocka -g % -o test && ./test : <CR>
" different F5 keymap for CUDA development
au BufEnter,BufNew *.cu noremap <F5> :wa \| !nvcc -std=c++11 -g % -o test && ./test : <CR>
" Python
au BufEnter,BufNew *.py noremap <F5> :wa \| !python % : <CR>
" LaTeX
au BufEnter,BufNew *.tex noremap <F5> :wa \| Lt <CR>
" Go
au BufEnter,BufNew *.go noremap <F5> :wa \| :GoRun <CR>
imap <F5> <C-o><F5>
" Open file under cursor in vertical window
nnoremap <F3> :vertical wincmd f<CR>
"}}}
" Control+A is Select All.
noremap  <C-A>  gggH<C-O>G
inoremap <C-A>  <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A>  <C-C>gggH<C-O>G
onoremap <C-A>  <C-C>gggH<C-O>G
snoremap <C-A>  <C-C>gggH<C-O>G
xnoremap <C-A>  <C-C>ggVG

nnoremap <F3> :vertical wincmd f<CR>

" Ctrl-{X,C,V} under gvim
source $VIMRUNTIME/mswin.vim
behave mswin

" Reformat current file (:w) & save all (:wa; can't reformat all because of
" the way BufWritePre works
noremap  <C-S>  :w<CR> :wa<CR> 
vnoremap <C-S>  <C-C>:w<CR>
inoremap <C-S>  <C-O>:w<CR>

" Fix deleting without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
vnoremap <leader>p "_dP

" Vertical split with leader-w
nnoremap <leader>w <C-w>v<C-w>l  

" Control+W closes the current file
" noremap  <C-W>  :wq<CR>

" Control+Z is Undo, in Normal and Insert mode.
noremap  <C-Z>  u
inoremap <C-Z>  <C-O>u

" Common typos
command WQ wq
command Wq wq
command W w
command Q q

" Window resize via Alt + Shift + arrows
map <A-S-Left> <C-W>>
map <A-S-Right> <C-W><
map <A-S-Up> <C-W>+
map <A-S-Down> <C-W>-

" Tab switching/adding
map <C-Right> <ESC>:tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
map <C-t> <ESC>:tabnew<CR>

" F2 inserts the date and time at the cursor.
" inoremap <F2>   <C-R>=strftime("%c")<CR>
" nmap     <F2>   a<F2><Esc>
" Window splits (TODO: Learn) {{{
" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>
" }}}
" Scroll between open windows
map <F6> <C-W>w
" nnoremap <tab> :wincmd w<cr>
" inoremap <tab> <c-o>:wincmd w<cr>
" Execute current line in bash 
nmap <F9> :exec '!'.getline('.')<CR>
" Refactoring variable names "{{{
" Source: http://stackoverflow.com/a/597932/963881
function! Refactor()
    call inputsave()
    let @z=input("What do you want to rename '" . @z . "' to? ")
    call inputrestore()
endfunction

" Locally (local to block) rename a variable
nmap <Leader>rf "zyiw:call Refactor()<cr>mx:silent! norm gd<cr>[{V%:s/<C-R>//<c-r>z/g<cr>`x
"}}}
" Open .vimrc in a tab, on a 'Key mappings' section
command! Vr :tabe ~/.vimrc | execute "normal /Key mappings \<CR><Space>" | nohlsearch
" Alias for PluginInstall
command! I :PluginInstall
" Replace commands "{{{
command! SpacesToNewline :%s/ /\r/g
command! UnderscoreToNewline :%s/_/\r/g
command! DashesToNewline :%s/-/\r/g
command! ColonToNewline :%s/:/\r/g
command! SemicolonToNewline :%s/;/\r/g
""}}}
" Compile LaTeX and open corresponding LaTeX
" Use LaTeX rather than plain TeX.
let g:tex_flavor = "latex"
" command! Lt :!latexmk -pvc -silent -pdf %; xdg-open %:r.pdf
command! Lt :!pdflatex % && xpdf %:r.pdf <CR>
" Toggle small/normal tabs
" noremap <F8> :call <SID>ToggleTabs()<CR>
" Double-click to copy word 
nnoremap <silent> <2-LeftMouse> byw
" Go-related "{{{
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>b <Plug>(go-build)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap gd <Plug>(go-def-tab)

au Filetype go set makeprg=go\ build\ ./...

function! s:GoVet()
    cexpr system("go vet " . shellescape(expand('%')))
    copen
endfunction
command! GoVet :call s:GoVet()


function! s:GoLint()
    cexpr system("golint " . shellescape(expand('%')))
    copen
endfunction
command! GoLint :call s:GoLint()

" vim-go settings
" let g:go_disable_autoinstall = 0  
" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"
" disable fmt on save
let g:go_fmt_autosave = 1

"}}}
" Change behavior of <Space> when there is '"' under the cursor"{{{
" http://stackoverflow.com/a/27669139/963881
" Currently doesn't go along with mapping <Space> to toggle folds
" nnoremap <expr> <space> '"'==matchstr(getline('.'), '\%' . col('.') . 'c.')?"i <ESC>":"<space>"
"}}}
" Arrow keys {{{
" Disable Arrow keys in Escape mode
" map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" Disable Arrow keys in Insert mode
"imap <up> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>
" }}}
" Avoid 'Press ENTER to continue' in Vim when entering man pages (using K) "{{{
nnoremap K K<CR>
vnoremap K K<CR>
"}}}

" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>', '<C-Space>']
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_min_num_of_chars_for_completion = 1
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:ycm_global_ycm_extra_conf = "~/dotfiles/ycm_extra_conf.py" 

" let g:ycm_server_use_vim_stdout = 1
" let g:ycm_server_log_level = 'debug'
" let g:ycm_path_to_python_interpreter = '/usr/bin/python'
" Space to toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
augroup vim
    au!
    " Help for word under the cursor (.vimrc only)
    au FileType vim setlocal keywordprg=:help
augroup END
" Remap code completion to Ctrl+Space {{{
" inoremap <Nul> <C-x><C-o> 
" In your case you want:
" inoremap <Nul> <C-n>
" }}} 
" Leader key bindings"{{{
" Move back to current position after doing gg=G (code reformat)
map <Leader>f mzgg=G`z<CR>
" TODO Open ranger
" nnoremap <leader>r :<C-U>RangerChooser<CR>
" Substitute all occurrences of the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
"Astyle (http://astyle.sourceforge.net/) config {{{
" Format C code (Linux Kernel style)
map <leader>fl :! astyle --style=linux %<CR> :redraw!<CR>
" Format C++ code (Google style)
map <leader>fg :! astyle --style=google %<CR>
" }}}
" }}}
" }}}
" 3.  Vundle config & plugins {{{
filetype off                  " required by Vundle
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin() 
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Must-haves "{{{
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
"}}}
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'tpope/vim-vinegar'
" Plugin 'wikitopian/hardmode'
"Plugin 'Yggdroot/indentLine'
" Plugin 'nathanaelkane/vim-indent-guides'
" A Git wrapper so awesome, it should be illegal
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-unimpaired' " For jumping to errors shortcuts
" Bundle 'tpope/vim-fugitive'
" Plugin 'vim-scripts/gtags.vim'
" Plugin 'thinca/vim-quickrun'
" Plugin 'vim-scripts/netrw.vim'
" Learn HOW TO USE those (https://www.youtube.com/watch?v=aHm36-na4-4)
" Bundle 'jondkinney/dragvisuals.vim'
" Bundle 'nixon/vim-vmath' 
" Bundle 'taku-o/vim-vis'
" Bundle 'rking/ag.vim'
Bundle 'Raimondi/delimitMate'
" *LEARN*
" Bundle 'terryma/vim-multiple-cursors'
" Bundle 'rking/ag.vim'
" Assembly
" Bundle 'vim-scripts/asmx86'
" JavaScript (temporary - for Node.js) {{{
Bundle 'lukaszb/vim-web-indent'
Bundle 'digitaltoad/vim-jade'
Bundle 'Chiel92/vim-autoformat'
" }}}

" Color themes "{{{
Bundle 'sjl/badwolf'
Bundle 'altercation/vim-colors-solarized'
" Bundle 'Lokaltog/vim-distinguished'
" Bundle 'jnurmine/Zenburn'
" Bundle 'vim-scripts/Wombat'
Bundle 'tpope/vim-vividchalk'
Bundle 'croaker/mustang-vim'
" "}}}
" Language-specific
" C++ {{{
Plugin 'rhysd/vim-clang-format'
Bundle 'Mizuchi/STL-Syntax'
Bundle 'rmartinho/vim-cpp11'
" C++ IDE-related {{{
Bundle 'vim-scripts/a.vim'
" Bundle 'DoxygenToolkit.vim'
" Bundle 'godlygeek/tabular'
" Bundle 'tpope/vim-sensible'
" Bundle 'tpope/vim-unimpaired'
" Bundle 'tpope/vim-endwise'
" Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup'
" }}}
" }}}
" Python {{{
" Bundle 'nvie/vim-flake8'
" Bundle 'klen/python-mode'
" }}}
" Haskell (http://haskelllive.com/environment.html) {{{
" Bundle 'lukerandall/haskellmode-vim'
" Bundle 'eagletmt/ghcmod-vim'
" Bundle 'bitc/lushtags'
" Bundle 'raichoo/haskell-vim'
" Bundle 'eagletmt/neco-ghc'
" }}}
" Smalltalk {{{
" Bundle 'vim-scripts/st.vim' 
" }}}
" Prolog {{{
" Bundle 'adimit/prolog.vim'  
" }}}
" Go {{{
Plugin 'fatih/vim-go'
" }}}
" Plugin 'stefandtw/quickfix-reflector.vim'
" Plugin 'vim-scripts/linuxsty.vim'
Plugin 'bling/vim-airline'
Plugin 'kana/vim-operator-user'     " Recommended by clang-format
" Plugin 'vim-scripts/vim-auto-save'
Plugin 'kien/ctrlp.vim'             " For tag creation
Plugin 'tacahiroy/ctrlp-funky'
" Bundle 'christoomey/vim-tmux-navigator'

" Bundle 'https://bitbucket.org/ns9tks/vim-l9' " Bundle throws: repo not found
" Bundle 'https://bitbucket.org/ns9tks/vim-fuzzyfinder' " Bundle throws: repo not found

" Latex
" Bundle 'gerw/vim-latex-suite'
" Bundle 'lervag/vim-latex'
" Plugin 'jamis/fuzzy_file_finder'
" Plugin 'jamis/fuzzyfinder_textmate'
" Snippets {{{
Bundle 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
" }}}
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
" 4.  UI {{{
" GVim "{{{
if os == "Darwin"
set guifont=Monaco:h18
endif
set guioptions=a
""}}}
" Search"{{{
hi Search ctermfg=Yellow ctermbg=NONE cterm=bold,underline
"}}}
" Status line {{{
if has('statusline')
    set laststatus=2
    set statusline+=col:\ %c,

    " Broken down into easily includeable segments
    " set statusline=%<%f\\   " Filename
    " set statusline+=%w%h%m%r " Options
    " set statusline+=%{fugitive\#statusline()}         " Git Hotness
    " set statusline+=\\ [%{&ff}/%Y]                    " filetype
    " set statusline+=\\ [%{getcwd()}]                  " current dir
    " set statusline+=\\ [A=\\%03.3b/H=\\%02.2B]       " ASCII/hex value of char
    " set statusline+=%=%-14.(%l,%c%V%)\\ %p%%          " Right aligned file nav info
endif
" }}}
" Solarized theme configuration {{{
set t_Co=256
let g:solarized_termcolors=256
" let    g:solarized_termtrans =   1
let  g:solarized_degrade   =   1
" let    g:solarized_bold      =   1
" let g:solarized_underline =   1       |   0
" let g:solarized_italic    =   1       |   0
let    g:solarized_contrast  =   "high"
let  g:solarized_visibility=     "high"

try
    " colorscheme solarized
    " colorscheme vividchalk
    " colorscheme mustang
    colorscheme badwolf
    " colorscheme distinguished
    " TODO: Check those
    " vim-scripts/summerfruit256.vim
    " jonathanfilip/lucius
    " vim-scripts/256-jungle
    " set background=light
    set background=dark
    " execute "set background=" . $BACKGROUND
catch /^Vim\%((\a\+)\)\=:E185/
    " Don't load a color scheme.
endtry
" g:solarized_termcolors=16
"}}}
" Cursorline {{{
" set cursorline
" hi CursorLine ctermbg=236
" hi CursorLine term=bold cterm=bold ctermbg=LightCyan guibg=LightCyan
"}}}
" Vim indent guides setup to work with solarized theme"{{{
" let g:indent_guides_enable_on_vim_startup=1
"set ts=4 sw=4 et
"let g:indent_guides_start_level=2
"let g:indent_guides_start_size=1
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
let g:indent_guides_auto_colors = 0
au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
" Vim Indent Guides ""{{{
"let g:indent_guides_auto_colors = 1
"augroup indent_guides
"au!
"au BufRead,BufNewFile * IndentGuidesEnable
"augroup END
au VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
" au VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
"}}}
"}}}
" Highlight text that goes over 80 characters"{{{
" http://stackoverflow.com/a/235970/963881
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/"}}}
" CtrlP"{{{
hi CtrlPMatch ctermbg=235 ctermfg=250 guibg=#262626 guifg=#bcbcbc cterm=NONE gui=NONE
"}}}
" Popup menu"{{{
highlight Pmenu ctermfg=3 ctermbg=0 guifg=#ffffff guibg=#0000ff
" make menu selections visible
highlight PmenuSel ctermfg=black ctermbg=gray
"}}}
" Fold colors"{{{
" hi Folded term=standout ctermfg=White ctermbg=233 guifg=241 guibg=233
" hi Folded term=NONE cterm=NONE gui=NONE ctermbg=None 
hi Folded term=NONE cterm=bold gui=NONE ctermbg=NONE ctermfg=red
" hi LineNr ctermfg=white ctermbg=none
" set foldtext=""
" Get rid of the dashes
set fillchars="fold: "
hi FoldColumn guibg=darkgrey guifg=white
""}}}
" Function and identifiers colors"{{{
hi Function guifg=red
hi Identifier guifg=red
""}}}
"}}}
" 6.  Tags {{{
" Tag dirs "{{{
" This will look in the current directory for "tags", and work up the tree towards 
" root until one is found. IOW, you can be anywhere in your source tree instead of 
" just the root of it.
set tags=./tags;/

" Going up to root is excessive. I suggest only going up to home instead:
" tags+=tags;$HOME 
"}}}
" build tags of your own project with Ctrl-F12"{{{
map <C-F12> :!ctags -R --sort=yes --langmap=C++:+.cu --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
"}}}
" OCaml support {{{
" au BufRead,BufNewFile *.ml,*.mli compiler ocaml
set sb
" map <F5> :split /tmp/ocaml \| %d \|setlocal ft=omlet \| setlocal autowrite \| r!ocaml < # <CR>
" map <F6> :dr /tmp/ocaml \| %d \|setlocal ft=omlet \|setlocal autowrite \| r!ocaml < # <CR>
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let no_ocaml_comments = 1
"}}}
" 7.  Autocommands {{{
" Binary files "{{{
augroup Binary
    au!
    au BufReadPre *.bin,*.evm let &bin=1
    au BufReadPost *.bin,*.evm if &bin | %!xxd
    au BufReadPost *.bin,*.evm set ft=xxd | endif
    au BufWritePre *.bin,*.evm if &bin | %!xxd -r
    au BufWritePre *.bin,*.evm endif
    au BufWritePost *.bin,*.evm if &bin | %!xxd
    au BufWritePost *.bin,*.evm set nomod | endif
augroup END
""}}}
" Git commits "{{{
" Cut commit messsages
autocmd Filetype gitcommit setlocal spell textwidth=72
""}}}
" Haskell "{{{
autocmd BufEnter *.hs set formatprg=pointfree
" au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
" au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
" au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsInfo<CR>
" autocmd BufEnter *.hs set formatprg=pointfree
"}}}
" Tab by default "{{{
au VimEnter * set tabpagemax=9999|sil tab ball|set tabpagemax&vim
""}}}
" Specific files"{{{
" au BufRead ~/Documents/Q.txt normal Goi
au BufRead ~/Documents/Q.txt execute "normal Go"|startinsert!
au BufRead ~/.remember execute "normal Go"|startinsert!
"}}}
if has("au")
    " Haskell"{{{
    " au BufWritePost *.hs GhcModCheckAndLintAsync
    "}}}
    " .md files as Markdown"{{{
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    "}}}
    " C 
    au FileType c set makeprg=gcc\ %\ &&\ ./a.out
    " Turn on C++ autocompletion"{{{
    " au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
    "}}}
    " Open all files in tabs after entering Vim (though power users prefer buffers)"{{{
    au VimEnter * tab all
    "}}}
    " }}}
endif
" }}}
" 8.  Folds {{{
" set foldmethod=indent   " Fold based on indent
set foldmethod=syntax     " Fold based on syntax
set foldnestmax=3         " Deepest fold is 3 levels
set foldlevelstart=5
let javaScript_fold=1         " JavaScript
let sh_fold_enabled=1         " sh
let xml_syntax_folding=1      " XML
"}}}
" 9.  Helper functions {{{
" Get info for specific key mapping (show grep output in a dialog) {{{
function! MappingInfo(mapping)
    execute "silent !grep -iB 1 " . a:mapping . " ~/.vimrc > minfo.tmp && dialog --textbox minfo.tmp 22 70 && rm minfo.tmp && clear"
    redraw!
endfunction
command! -nargs=1 Minfo call MappingInfo(<f-args>)
" "}}}
" Add ranger as a file chooser in vim {{{
" If you add this code to the .vimrc, ranger can be started using the command
" ":RagerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
"}}}
" Toogle line number display {{{
" nmap <silent> <F10> :exec &nu==&rnu ? "se nu" : "se rnu"<CR>
" nnoremap <F10> :set nonumber!<CR>

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        " set number
    else
        set relativenumber
    endif
endfunc

au FocusLost * :set number
au FocusGained * :set relativenumber
au InsertEnter * :set number
au InsertLeave * :set relativenumber

" Toogle line number display
nnoremap <F10> :call NumberToggle()<cr>
"}}}
" Restore cursor position, window pos., and last search after running a cmd {{{
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
"}}}
" Re-indent the whole buffer {{{
function! Indent()
    call Preserve('normal gg=G')
endfunction

" Indent on save hook
" au BufWritePre <buffer> call Indent()
" ClangFormat on save hook
" autocmd BufWritePre *.h  :ClangFormat
" autocmd BufWritePre *.c* :ClangFormat
"}}}
" Modernize C++ code {{{
function! ClangModernize()
    :!clang-modernize -style=Google -format -loop-convert -pass-by-value -replace-auto_ptr -use-nullptr -use-auto -add-override -override-macros %
endfunction
command ClangModernize :call ClangModernize()
" }}}
" Toggles tab size between the default width and 1 character width {{{
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
"}}}
" Use TAB to complete when typing words, else inserts TABs as usual {{{
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
" function! Tab_Or_Complete()
" if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
" return "\<C-N>"
" else
" return "\<Tab>"
" endif
" endfunction
"inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
"}}}
" Automatic insertion of C/C++ header gates/guards {{{
" Creates guards when header file is created
function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
endfunction
au BufNewFile *.{h,hpp} call <SID>insert_gates()
"}}}
" Jumping through error list {{{
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
nmap <silent> ,,    <Plug>LocationPrevious              
nmap <silent> ..    <Plug>LocationNext
"}}}"}}}
" 10. Filetypes {{{
au filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
au filetype c      nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
au filetype cpp    nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
au BufRead,BufNewFile *.asm set filetype=nasm
" CUDA
au BufNewFile,BufRead *.cu set filetype=cuda
au BufNewFile,BufRead *.cuh set filetype=cuda
"}}}
" 11. Plugin-specific configuration {{{
" Clang-format {{{
let g:clang_format#command= os == "Darwin" ? '/usr/local/bin/clang-format' : '/usr/bin/clang-format'
let g:clang_format#code_style='google'
" let g:clang_format#style_options = {
            " \ "BasedOnStyle": "LLVM",
            " \"IndentWidth": 8,
            " \"UseTab": "Always",
            " \"BreakBeforeBraces": "Linux",
            " \"AllowShortIfStatementsOnASingleLine": "false",
            " \"IndentCaseLabels": "false"}
" }}}
" CtrlP {{{
map <leader>gh :CtrlP ~<CR>
map <leader>gv :CtrlPMRU<CR>
map <leader>gb :CtrlPBuffer<CR>
" }}}
" ctrlp-funky "{{{
let g:ctrlp_funky_matchtype = 'path'
nnoremap <C-O> :CtrlPFunky<Cr>
let g:ctrlp_funky_syntax_highlight = 1
"}}}
" Man pages using ConqueTerm {{{
let g:ConqueTerm_StartMessages = 0
function! ConqueMan()
    let cmd = &keywordprg . ' '
    if cmd ==# 'man ' || cmd ==# 'man -s '
        if v:count > 0
            let cmd .= v:count . ' '
        else
            let cmd = 'man '
        endif
    endif
    let cmd .= expand('<cword>')
    execute 'ConqueTermSplit' cmd
endfunction
map K :<C-U>call ConqueMan()<CR>
ounmap K
" }}}
" NERDCommenter {{{
" Pad comment delimeters with spaces {{{
let NERDSpaceDelims = 1
" }}}
" Map Ctrl+/ to toggle comments "{{{
map <C-\> <Plug>NERDCommenterToggle<CR>
imap <C-\> <Esc><Plug>NERDCommenterToggle<CR>
map <C-_> <Plug>NERDCommenterToggle<CR>
imap <C-_> <Esc><Plug>NERDCommenterToggle<CR>
"}}}
" }}}
" NERDTree "{{{
" Open a NERDTree automatically when vim starts up if no files were specified
" au StdinReadPre * let s:std_in=1
" au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Key mappings
silent! nmap <C-i> :NERDTreeToggle<CR>
silent! map <F2> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F2>"
let g:NERDTreeMapPreview="<F3>"

au FileType nerdtree nmap <buffer> <left> u
au FileType nerdtree nmap <buffer> <right> u

" Set the working directory to the current file's directory
au BufEnter * lcd %:p:h

map <leader>ff :NERDTreeFind<cr>
"}}}
" neco-ghc {{{
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
let g:ycm_semantic_triggers = {'haskell' : ['.']}
" }}}
" Tagbar toggle "{{{
nmap <F7> :TagbarToggle<CR>
"}}}
"}}}
" 12. Vim/GUI Vim {{{
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
"}}}
" 13. Competitive programming {{{
" Runs the code by taking input from the 'in' text file"{{{
" map <F6> :w<CR>:!g++ % -g && (ulimit -c unlimited; ./a.out < in) <CR>
""}}}
"}}}
" 14. Tagbar {{{
let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
 "}}}
