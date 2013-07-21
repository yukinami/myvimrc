" Platform
function! MySys()
  if has("win32")
    return "windows"
  else
    return "linux"
  endif
endfunction

function! SwitchToBuf(filename)
    "let fullfn = substitute(a:filename, "^\\~/", $HOME . "/", "")
    " find in current tab
    let bufwinnr = bufwinnr(a:filename)
    if bufwinnr != -1
        exec bufwinnr . "wincmd w"
        return
    else
        " find in each tab
        tabfirst
        let tab = 1
        while tab <= tabpagenr("$")
            let bufwinnr = bufwinnr(a:filename)
            if bufwinnr != -1
                exec "normal " . tab . "gt"
                exec bufwinnr . "wincmd w"
                return
            endif
            tabnext
            let tab = tab + 1
        endwhile
        " not exist, new tab
        exec "tabnew " . a:filename
    endif
endfunction

" global setting
set nocompatible   " be iMproved
filetype off       " required!

let mapleader = ","
set showcmd
set softtabstop=4
set shiftwidth=2
set hlsearch
nmap <leader>hh :nohlsearch<cr>
set incsearch
colorscheme desert

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let VUndle manage Vundle
" required!
Bundle 'gmarik/vundle'

""""""""""""""""""""""""""""""""""
" fuzzyfinder
" l9 libary is require
Bundle 'L9'
Bundle 'FuzzyFinder'

nmap <leader>fb :FufBuffer<cr>
nmap <leader>ff :FufFile<cr>
nmap <leader>fc :FufCoverageFile<cr>
nmap <leader>fd :FufDir<cr>
nmap <leader>bf :FufBookmarkFileAdd<cr>
nmap <leader>bd :FufBookmarkDirAdd<cr>
nmap <leader>fbf :FufBookmarkFile<cr>
nmap <leader>fbd :FufBookmarkDir<cr>
nmap <leader>ft :FufTag<cr>
nmap <leader>fbt :FufBufferTag<cr>
nmap <leader>fj :FufJumpList<cr>

""""""""""""""""""""""""""""""""""
" My Bundle here:
Bundle 'scrooloose/nerdtree'
" map key
nmap <leader>nt :NERDTreeToggle<cr>
" close vim if the only window left is a NERDTreeToggle
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary" ) | q | endif

""""""""""""""""""""""""""""""""""""
" Tag lists (ctags)
Bundle 'taglist.vim'

if MySys() == "windows"                "设定windows系统中ctags程序的位置
    let Tlist_Ctags_Cmd = 'ctags'
elseif MySys() == "linux"              "设定linux系统中ctags程序的位置
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 

""""""""""""""""""""""""""""""""""""
" ShowMarks
Bundle 'ShowMarks'
 
" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 

""""""""""""""""""""""""""""""""""""
" markbrowser
Bundle 'Marks-Browser'
nmap <silent> <leader>mk :MarksBrowser<cr>
 
""""""""""""""""""""""""""""""""""""
" matchit
Bundle 'tmhedberg/matchit'

""""""""""""""""""""""""""""""""""""
Bundle 'msanders/snipmate.vim'

"""""""""""""""""""""""""""""""""""
"Bundle 'javacomplete'
"autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo

"""""""""""""""""""""""""""""""""""
" supertab
Bundle 'ervandew/supertab'

let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-X><C-U>"

"""""""""""""""""""""""""""""""""""
Bundle 'Shougo/neocomplcache'
" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1
" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3
" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder 
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" popup compl
let g:NeoComplCache_DisableAutoComplete = 0

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

""""""""""""""""""""""""""""""""""""
"javacomplete"
Bundle 'javacomplete'

if has("autocmd")
  autocmd Filetype java setlocal omnifunc=javacomplete#Complete
endif

""""""""""""""""""""""""""""""""""""
Bundle 'fholgado/minibufexpl.vim'

""""""""""""""""""""""""""""""""""""
" eclim
autocmd Filetype java inoremap <C-o> <ESC>:JavaImport<CR>oo

""""""""""""""""""""""""""""""""""""
"Bundle 'sqlplus.vim'

""""""""""""""""""""""""""""""""""""
" rails vim
Bundle 'tpope/vim-rails'

""""""""""""""""""""""""""""""""""""
" surround
Bundle 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""
Bundle 'mileszs/ack.vim'

""""""""""""""""""""""""""""""""""""
"quickfix

nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>cw :cw<cr>
nmap <leader>ccl :ccl<cr>

""""""""""""""""""""""""""""""""""""
filetype plugin indent on


"Fast edit vimrc
if MySys() == 'linux'

    "Fast reloading of the .vimrc
    map <silent> <leader>ss :source ~/.vimrc<cr>
    "Fast editing of .vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/.vimrc")<cr>
    "When .vimrc is edited, reload it
    autocmd! bufwritepost .vimrc source ~/.vimrc
elseif MySys() == 'windows'
    " Set helplang
    set helplang=cn
    "Fast reloading of the _vimrc
    map <silent> <leader>ss :source ~/_vimrc<cr>
    "Fast editing of _vimrc
    map <silent> <leader>ee :call SwitchToBuf("~/_vimrc")<cr>
    "When _vimrc is edited, reload it
    autocmd! bufwritepost _vimrc source ~/_vimrc
endif

" For windows version
if MySys() == 'windows'
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif 


autocmd BufNewFile,BufRead afiedt.buf setf sql
autocmd BufNewFile,BufRead *.html.erb set filetype=html.eruby

set dict+=~/.vim/dict/**
set complete=.,k,w,b,t,i


