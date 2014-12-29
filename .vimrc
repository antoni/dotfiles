"  vim:set foldmethod=marker foldlevel=0 cursorcolumn cursorline:
" 0.  General settings {{{
" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv 
let mapleader=","
set nocompatible              " be iMproved, required
filetype off                  " required
" Replace the current selection with buffer"{{{
"}}}
" Turn off vim recording for good
map q <Nop>
set ignorecase                " Ignore case when searching
syntax on                     " Syntax colouring
set pastetoggle=<F12>         " pastetoggle (sane indentation on pastes)
set ruler                     " Show ruler on the bottom
set virtualedit=onemore
set textwidth=80
set formatoptions+=w          " gggqG - format to break after 80 characters
set wrapmargin=2
set expandtab
set tabstop=4
set shiftwidth=4

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
" 1.  Key mappings {{{
" Control+A is Select All.
noremap  <C-A>  gggH<C-O>G
inoremap <C-A>  <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A>  <C-C>gggH<C-O>G
onoremap <C-A>  <C-C>gggH<C-O>G
snoremap <C-A>  <C-C>gggH<C-O>G
xnoremap <C-A>  <C-C>ggVG

" Control+S saves the current file (if it's been changed).
noremap  <C-S>  :update<CR>
vnoremap <C-S>  <C-C>:update<CR>
inoremap <C-S>  <C-O>:update<CR>

" Control+W closes the current file
noremap  <C-W>  :wq<CR>

" Control+Z is Undo, in Normal and Insert mode.
noremap  <C-Z>  u
inoremap <C-Z>  <C-O>u

" F2 inserts the date and time at the cursor.
inoremap <F2>   <C-R>=strftime("%c")<CR>
nmap     <F2>   a<F2><Esc>

" Execute current line in bash 
nmap <F9> :exec '!'.getline('.')<CR>

" Toggle small/normal tabs
noremap <F8> :call <SID>ToggleTabs()<CR>
"

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

" Avoid 'Press ENTER to continue' in Vim when entering man pages (using K)
nnoremap K K<CR>
vnoremap K K<CR>

set autoread " Set to auto read when a file is changed from the outside

" Space to toggle folding
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
augroup vim
    autocmd!
    " Help for word under the cursor (.vimrc only)
    autocmd FileType vim setlocal keywordprg=:help
augroup END
" Remap code completion to Ctrl+Space {{{
"inoremap <Nul> <C-x><C-o> 
" In your case you want:
" "inoremap <Nul> <C-n>
" }}} 
" TEST: http://nerd-hacking.blogspot.com/2006/05/vim-folding-tips.html
" nmap <F6> /}<CR>zf%<ESC>:nohlsearch<CR>
" Leader key bindings"{{{
" Move back to current position after doing gg=G (code reformat)
map <Leader>f mzgg=G`z<CR>
" Open ranger
nnoremap <leader>r :<C-U>RangerChooser<CR>
" Substitute all occurrences of the word under the cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
"Astyle config {{{
" Use Astyle (http://astyle.sourceforge.net/) to format C code (Linux Kernel style)
map <leader>fl :! astyle --style=linux %<CR>

" Use Astyle (http://astyle.sourceforge.net/) to format C++ code (Google style)
map <leader>fg :! astyle --style=google %<CR>
" }}}
" }}}
" }}}
" 2.  Vundle config & plugins {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin() 

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'wincent/command-t'
" Plugin 'spolu/dwm.vim'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'tpope/vim-vinegar'
" Plugin 'wikitopian/hardmode'
"Plugin 'Yggdroot/indentLine'
Plugin 'nathanaelkane/vim-indent-guides'
" A Git wrapper so awesome, it should be illegal
Bundle 'tpope/vim-fugitive'
Plugin 'vim-scripts/gtags.vim'
Plugin 'vim-scripts/netrw.vim'
Plugin 'nelstrom/vim-markdown-folding'
" Color themes
Bundle 'sjl/badwolf'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/gnuplot.vim'
Plugin 'stefandtw/quickfix-reflector.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/OmniCppComplete'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
" Plugin 'vim-scripts/linuxsty.vim'
" Plugin 'jpalardy/vim-slime'
" Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'chrisbra/csv.vim'
Plugin 'kana/vim-operator-user' " Recommended by clang-format
Plugin 'vim-scripts/vim-auto-save'
Bundle 'christoomey/vim-tmux-navigator'
" Bundle "MarcWeber/vim-addon-mw-utils"
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" Plugin 'jamis/fuzzy_file_finder'
" Plugin 'jamis/fuzzyfinder_textmate'
" Bundle "tomtom/tlib_vim"
" Snippets {{{
" Plugin 'SirVer/ultisnips'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
" }}}
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help {{{
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
" }}}
" }}}
" 3.  UI {{{
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
set background=dark
" colorscheme solarized
colorscheme badwolf
" g:solarized_termcolors=16
"}}}
" Cursorline {{{
set cursorline
hi CursorLine ctermbg=236
"hi CursorLine term=bold cterm=bold ctermbg=LightCyan guibg=LightCyan
"}}}
" Vim indent guides setup to work with solarized theme"{{{
" let g:indent_guides_enable_on_vim_startup=1
"set ts=4 sw=4 et
"let g:indent_guides_start_level=2
"let g:indent_guides_start_size=1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
" Vim Indent Guides ""{{{
"let g:indent_guides_auto_colors = 1
"augroup indent_guides
"autocmd!
"au BufRead,BufNewFile * IndentGuidesEnable
"augroup END
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
"}}}
"}}}
" Highlight text that goes over 80 characters"{{{
" http://stackoverflow.com/a/235970/963881
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/"}}}
" Fold colors"{{{
hi Folded term=standout ctermfg=White ctermbg=233 guifg=241 guibg=233
hi FoldColumn guibg=darkgrey guifg=white
""}}}
"}}}
" 5.  Tags "{{{
" Tag dirs "{{{
"http://stackoverflow.com/a/741486/963881
set tags=./tags;/
set tags+=/Users/antoni/.vim/tags/cpp
"}}}
" build tags of your own project with Ctrl-F12"{{{
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
"}}}
" OmniCppComplete configuration{{{
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
" }}}
" OCaml support {{{
" au BufRead,BufNewFile *.ml,*.mli compiler ocaml
set sb
map <F5> :split /tmp/ocaml \| %d \|setlocal ft=omlet \| setlocal autowrite \| r!ocaml < # <CR>
map <F6> :dr /tmp/ocaml \| %d \|setlocal ft=omlet \|setlocal autowrite \| r!ocaml < # <CR>
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let no_ocaml_comments = 1
set makeprg=ocamlbuild\ ${BUILDFLAGS}\ -use-ocamlfind\ all.otarget
set makeprg=omake\ -j\ 8
" }}}
"}}}
" 6.  Autocommands {{{
if has("autocmd")
    " Turn on C++ autocompletion"{{{
    au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
    "}}}
    " Open all files in tabs after entering Vim (though power users prefer buffers)"{{{
    autocmd VimEnter * tab all
    "}}}
    " Compiler settings for C/C++ files {{{
    "au BufEnter *.cc compiler g++
    "au BufEnter *.cpp compiler g++
    "au BufEnter *.c compiler gcc
    " }}}
endif
" }}}
" 7.  Folds {{{
" set foldmethod=indent   " Fold based on indent
set foldmethod=syntax     " Fold based on syntax
set foldnestmax=3         " Deepest fold is 3 levels
set foldlevelstart=0      " Fold everyting by default
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
"}}}
" 8.  Helper functions "{{{
" Get info for specific key mapping (show grep output in a dialog) "{{{
function! MappingInfo(mapping)
    execute "silent !grep -iB 1 " . a:mapping . " ~/.vimrc > minfo.tmp && dialog --textbox minfo.tmp 22 70 && rm minfo.tmp && clear"
    redraw!
endfunction
command! -nargs=1 Minfo call MappingInfo(<f-args>)
" "}}}
" Add ranger as a file chooser in vim"{{{
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
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Toogle line number display
nnoremap <F10> :call NumberToggle()<cr>
"}}}
" Restore cursor position, window position, and last search after running a"{{{
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
"}}}
" Re-indent the whole buffer."{{{
function! Indent()
    call Preserve('normal gg=G')
endfunction

" Indent on save hook
autocmd BufWritePre <buffer> call Indent()
"}}}
"Toggles tab size between the default width and 1 character width"{{{
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
"Use TAB to complete when typing words, else inserts TABs as usual."{{{
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
"}}}
" Automatic insertion of C/C++ header gates/guards "{{{
" Creates guards when header file is created
function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef " . gatename
    execute "normal! o#define " . gatename . " "
    execute "normal! Go#endif /* " . gatename . " */"
    normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
"}}}
" Show online docummentation for word under cursor "{{{
function! OnlineDoc()
    let s:browser = "firefox"
    let s:wordUnderCursor = expand("<cword>")

    if &ft == "cpp" || &ft == "c" || &ft == "ruby" || &ft == "php" || &ft == "python"
        let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor."+lang:".&ft elseif &ft == "vim"
        let s:url = "http://www.google.com/codesearch?q=".s:wordUnderCursor
    else
        return
    endif

    let s:cmd = "silent !" . s:browser . " " . s:url
    execute  s:cmd
    redraw!
endfunction
" Online doc search.
map <silent> <M-d> :call OnlineDoc()<CR>
map <leader>s :call OnlineDoc()<CR>
map <LocalLeader>k :call OnlineDoc()<CR>
"}}}
"}}}
" 9.  Filetypes "{{{
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && ./'.shellescape('%:r')<CR>
" CUDA
au BufNewFile,BufRead *.cu set filetype=cuda
au BufNewFile,BufRead *.cuh set filetype=cuda
"}}}
" 10. Plugin-specific configuration "{{{
" Tagbar toggle "{{{
nmap <F7> :TagbarToggle<CR>
"}}}
" Autosave plugin"{{{
" set autosave=5            " currently not implemented in Vim
let g:auto_save = 1         " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
"}}}
" Syntastic"{{{
" let g:syntastic_ocaml_use_ocamlc = 1
let g:syntastic_ocaml_use_ocamlbuild = 1
let g:syntastic_ocaml_checkers = ['merlin']
"}}}
" Vim slime {{{
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_python_ipython = 1
" tmux target pane
":" means current window, current pane (a reasonable default)
"":i" means the ith window, current pane
":i.j" means the ith window, jth pane
""h:i.j" means the tmux session where h is the session identifier (either 
" session name or number), the ith window and the jth pane
" }}}
" NERDCommenter {{{
" Pad comment delimeters with spaces {{{
let NERDSpaceDelims = 1
" }}}
" Map Ctrl+/ to toggle comments "{{{
map <C-_> <Plug>NERDCommenterToggle<CR>
imap <C-_> <Esc><Plug>NERDCommenterToggle<CR>
"}}}
" }}}
" clang-format to format C++ according to Google Styleguide "{{{ 
" need to have .clang-format file in ~ directory
map <C-I> :pyf ~/.vim/clang-format.py<CR>
imap <C-I> <ESC>:pyf ~/.vim/clang-format.py<CR>i
"}}}
"}}}
" 11. Vim/GUI Vim "{{{
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
