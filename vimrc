set nocompatible

"Pathogen plugin settings
execute pathogen#infect()

"Hide the toolbar
set guioptions=egmLt

filetype plugin indent on
" Set spelling language
set spelllang=en_us
syntax on

"Sane settings for backspace
set backspace=indent,eol,start

"Display current cursor position in lower right corner.
set ruler

"Want a different map leader than \
let mapleader = ","
let maplocalleader = ","

"Ever notice a slight lag after typing the leader key + command? This lowers
"the timeout.
set timeoutlen=500

"Switch between buffers without saving
set hidden

"Set the color scheme.
if !has("win32unix")
    colorscheme solarized
    set background=dark
    "Change invisible characters
    set listchars=tab:➞\ ,eol:↵
endif

"give me about 5 lines at the top or bottom
set scrolloff=5

"Set font type and size. Depends on the resolution. Larger screens, prefer h15
set guifont=Monaco:h12

"Tab stuff;
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

"Show lines numbers
set number

"Indent stuff
set smartindent
set autoindent

"Always show the status line
set laststatus=2

"Prefer a slightly higher line height
set linespace=3

"Better line wrapping
set wrap
set formatoptions=qrn1
set linebreak

set incsearch

"Highlight searching
set hlsearch

"Case insensitive searching
set ignorecase

"Enable code folding
set foldenable

"Hide mouse when typing
set mousehide

set wildmenu

set wildmode=longest:full,list:full
set completeopt=longest,menuone

set encoding=utf-8

"======================================
" MAPPINGS
"======================================
" Remove trailing whitespace
nnoremap <leader>ws :%s/\s\+$//g<cr>:noh<cr>
if has("win32")
    " Prepare to import windows directory list
    nnoremap <leader>di :r!dir /o:-d /b
endif
" Edit Ultisnips
nnoremap <leader>es :UltiSnipsEdit<cr>
" CtrlP
set wildignore+=*.class,*/.git/*,*/.hg/*,*/.svn/*,*/__pycache__/*
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|swp|class)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
nnoremap <leader>b :CtrlPBuffer<cr>
let g:ctrlp_show_hidden=0
let g:ctrlp_prompt_mappings = {
            \ 'PrtClearCache()':      ['<c-s-r>'],
            \ }
" Select just pasted text
nnoremap <leader>gv `[v`]
" For the purposes of writing vim sytnac files, show syntax highlighting groups for word under cursor
nmap _sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
"Disable F1
nnoremap <F1> <nop>
"Shortcut for editing  vimrc file in a new buffer
nnoremap <leader>ev :edit $MYVIMRC<cr>
" Edit another file in the directory of the current file
nnoremap <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
" Select just pasted text
nnoremap <leader>gv `[v`]
"Faster shortcut for commenting. Requires T-Comment plugin
nnoremap <silent> <leader>c :TComment<cr>
vnoremap <silent> <leader>c :TComment<cr>
"Map escape key to jj in order to escape more quickly
"or incase you forget and start moving down the file
inoremap jj <esc>
" maps %% to the filepath of the current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"Delete all buffers (via Derek Wyatt)
nnoremap <silent> <leader>da :execute "1," . bufnr('$') . "bd"<cr>

" Search for selected text, forwards or backwards.
" Use * to search forwards and # to search backwards
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy/<C-R><C-R>=substitute(
            \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
            \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
            \gvy?<C-R><C-R>=substitute(
            \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
            \gV:call setreg('"', old_reg, old_regtype)<CR>

" Make it so that a curly brace automatically inserts an indented line
inoremap {<CR> {<CR>}<Esc>O<BS><Tab>

" Jump to the end of the line, add a semi-colon, then new line
inoremap <C-Enter> <esc>mzA;<esc>`z


" Source the vimrc file after saving it. This way, you don't have to reload
" Vim to see the changes.
if has("autocmd")
    augroup python_commands
        autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79 shiftround autoindent
    augroup END
    augroup ruby_stuff
        autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab textwidth=79 shiftround autoindent
    augroup END
    augroup markdown_commands
        autocmd BufNewFile,BufRead *.md,*.markdown setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79 shiftround autoindent
    augroup END
    augroup java
        autocmd BufNewFile,BufRead *.jspf setlocal filetype=jsp
    augroup END

    " Source the vimrc file after saving it. This way, you don't have to reload
    " Vim to see the changes.
    augroup myvimrchooks
        autocmd!
        autocmd bufwritepost .vimrc source $MYVIMRC | AirlineRefresh
        autocmd filetype vim setlocal foldmethod=marker foldcolumn=4
    augroup END
endif

"------------------------"
"NERDTREE PLUGIN SETTINGS
"------------------------"
"Shortcut for NERDTreeToggle
nnoremap <leader>nt :NERDTreeToggle<cr>

"Show hidden files in NerdTree
let NERDTreeShowHidden=1

"Helpeful abbreviations
iabbrev lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iabbrev llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

"Spelling corrects.
iabbrev teh the
iabbrev Teh The

"Title case the current line
nnoremap <silent> <leader>tc :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<cr>:nohlsearch<cr>

function! NextYear()
    return strftime("%Y") + 1 . strftime("-%m-%d")
endfunction
