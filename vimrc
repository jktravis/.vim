set nocompatible

"Pathogen plugin settings
execute pathogen#infect()

" Powerline
" set rtp+=~/.vim/bundles/powerline/bindings/vim

filetype plugin indent on
syntax on

set autowrite

" set ruler

let mapleader = ","
let maplocalleader = ","

set timeoutlen=500

set hidden

" colorscheme solarized
" set background=dark

" set cursorline

set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" set showcmd

set splitbelow

set number

set smartindent
set autoindent
set laststatus=2

set linespace=3

set wrap

set formatoptions=qrn1

set linebreak

set incsearch

set hlsearch

set ignorecase

set foldenable

set mousehide

set wildmenu

set wildmode=longest:full,list:full

let g:Powerline_symbols = 'compatible'

set encoding=utf-8

set nolist

"======================================
" MAPPINGS
"======================================
" Format BPM Log Timestamp
nnoremap <leader>ts :%s/\(ExecuteThrea\d\d\d\d\)\(\d\d\d\d\)\(\d\d\)\(\d\d\)T\(\d\d\)\(\d\d\)\(\d\d\)/\1 \2-\3-\4 T \5:\6:\7/g<cr>

" Open new empty buffer
nnoremap <leader>nb :enew<cr>
" Prepare to import windows directory list
nnoremap <leader>di :r!dir /o:-d /b 
nnoremap <leader>rl :%s/retirement/issaic/g<cr>:%s/.com\//.com\/retirement\/?postURL=\//<cr>
" link to pdf
vmap <silent> <leader>la s<a href="<c-r><c-w>.pdf" target="_blank"><esc>`]a&nbsp;<span class="pdfdownload">(0k)</span><esc>
nnoremap <leader>cs :s/ /_/g<cr>:noh<cr>
" Delete host name after "surrounding"
nnoremap <leader>dh f/;;dFh
" Replace special quote, apostrophe, and bullet character
nnoremap <silent> <leader>rs :%s/[\u201C-\u201D]/"/g<CR>:%s/[\u2019]/'/g<cr>:%s/[\u2022]/*/g<cr>
"Titlecase; replace spaces with underscores; selects and yanks line
nnoremap <leader>ss :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<cr>:s/ /_/g<cr>:nohlsearch<cr>0vg_y
"Title case the current line
nnoremap <silent> <leader>tc :s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g<cr>:nohlsearch<cr>


nnoremap <leader>es :UltiSnipsEdit

"Toggle case sensitivity
nnoremap <silent> <leader>ti :set ignorecase!<cr>
"Hard-wrap paragraphs of text
nnoremap <leader>q gqip
"Disable F1
nnoremap <F1> <nop>
"Opens a vertical split and switches over (\v)
nnoremap <leader>v <C-w>v<C-w>l
"Map a change directory to the desktop - Mac specific
nnoremap <leader>d :cd ~/Desktop<cr>:e.<cr>
"Shortcut for editing  vimrc file in a new buffer
nnoremap <leader>ev :edit $MYVIMRC<cr>
" Read in the files from downloads
if has('win32')
	nnoremap <leader>dl :r! dir /B Downloads\<cr>
else
	nnoremap <leader>dl :r! ls ~/Downloads/<cr>
endif
" Select just pasted text
nnoremap <leader>gv `[v`]

"Faster shortcut for commenting. Requires T-Comment plugin
nnoremap <silent> <leader>c :TComment<cr>
vnoremap <silent> <leader>c :TComment<cr>
"Map escape key to jj in order to escape more quickly
"or incase you forget and start moving down the file
inoremap jj <esc>
" maps %% to the filepath of the current file
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'\' : '%%'
cnoremap <expr> pof getcmdtype() == ':' ? 'r! C:\App\pof.py Downloads\' : 'pof'
"Delete all buffers (via Derek Wyatt)
nnoremap <silent> <leader>da :execute "1," . bufnr('$') . "bd"<cr>
" make a table out of data that is tab separated
noremap <leader>tb :set ft=html<cr>:%s_\t_</td><td>_g<cr>:%s_^_<tr><td>_<cr>:%s_$_</td></tr>_<cr>:%s_><_>\r<_g<cr>Vgg=

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

" Jump to the end of the line, add a semi-colon, then new line
noremap <C-Enter> mzA;<esc>`z

" format xml / html
noremap <leader>h :%!c:\tidy\tidy.exe -q -i --wrap 0 --show-warnings 0 %<cr>

" Wrap <li></li> around multiple visual lines
" requires surround plugin
cabbrev wrapli :normal yss<li><cr>

" Wrap <p></p> around multiple visual lines
" requires surround plugin
cabbrev wrapp :normal yss<p><cr>

"Load the current buffer in Firefox - Mac specific.
" abbrev ff :! open -a firefox.app %:p<cr>
" abbrev saf :! open -a safari.app %:p<cr>

abbrev xf :silent !start rundll32 url.dll,FileProtocolHandler %:p

" eXecute File being edited
nnoremap <leader>ff :call ExecuteSelected(visualmode())
function! ExecuteSelected(type)
	let saved_unnamed_register = @@
	" get currently selected text and clear selected text in editor
	if a:type ==? 'v'
	  execute "normal! `<v`>y"
	else
	  return
	endif
	echo @@

	if has('mac')
		execute 'silent !open ' . %:p . ' <cr>'
	elseif has('win32') || has('win64')
		execute 'silent !start rundll32 url.dll,FileProtocolHandler ' . %:p . '<CR>'
	endif
	let @@ = saved_unnamed_register
endfunction

" compile the current file with javac
abbrev javac :!javac %<cr>
abbrev javadir :!javac *.java<cr>

if has("autocmd")
	augroup python_commands
		autocmd BufNewFile,BufRead *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79 shiftround autoindent
	augroup END
	augroup markdown_commands
		autocmd BufNewFile,BufRead *.md,*.markdown setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab textwidth=79 shiftround autoindent
	augroup END
	augroup disable_autowrite
		autocmd BufNewFile,BufRead * setlocal noautowrite
	augroup END

	augroup asp_stuff
		" Was using this to switch to html until I found that Solarized does
		" a much better job than Xoria256
		autocmd BufNewFile,BufRead *.asp setlocal filetype=html
	augroup END

	augroup md_stuff
		autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
	augroup END

	augroup java
		autocmd BufNewFile,BufRead *.jspf setlocal filetype=jsp
	augroup END
	augroup ISSAIC
		" use homesite snippets as html
		autocmd! BufNewFile,BufRead *.hss setlocal filetype=html
		autocmd! BufNewFile,BufRead training.html loadview | setlocal foldclose=all | set foldcolumn=4
		autocmd! BufWrite training.html mkview
	augroup END

" Source the vimrc file after saving it. This way, you don't have to reload
" Vim to see the changes.
	augroup myvimrchooks
		autocmd!
		if has("win32")
			autocmd bufwritepost .vimrc source $MYVIMRC
			"default starting directory
			cd ~/
		else
			autocmd bufwritepost .vimrc source $MYVIMRC 
		endif
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

"autopen NERDTree and focus cursor in new document
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

"Helpeful abbreviations
iabbrev lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
iabbrev llorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 

"Spelling corrects. Just for example. Add yours below.
iabbrev teh the
iabbrev Teh The
iabbrev &nbps; &nbsp;


"======================================
" CtrlP Settings for ISSAIC
" =====================================
" default CtrlP to buffer
nnoremap <c-p> :CtrlPBuffer<cr>
nnoremap <leader>b :CtrlPBuffer<CR>
" Open snippet directory with cmd/alt p
nnoremap <m-p> :CtrlP C:\Users\travisjk\Documents\SAIC\<cr>
" Put current snippet into alternate (#) buffer and delete the 
" snippet buffer
nnoremap <leader>sp :buffer #<cr>:read #<cr>:bdelete #<cr>
"Hide hse files and the misc directory
set wildignore+=*.hse,misc\*
"======================================
" END CtrlP Settings for ISSAIC
" =====================================
" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"   F8                next scheme
"   Shift-F8          previous scheme
"   Alt-F8            random scheme
" Set the list of color schemes used by the above (default is 'all'):
"   :SetColors all              (all $VIMRUNTIME/colors/*.vim)
"   :SetColors my               (names built into script)
"   :SetColors blue slate ron   (these schemes)
"   :SetColors                  (display current scheme names)
" Set the current color scheme based on time of day:
"   :SetColors now
if v:version < 700 || exists('loaded_setcolors') || &cp
  finish
endif

let loaded_setcolors = 1
let s:mycolors = ['zmrok', 'zenburn', 'xoria256', 'xemacs', 'wuye',
					\'wood', 'wombat256', 'wombat', 'winter', 'vylight',
					\'vividchalk', 'vibrantink', 'vc', 'two2tango', 'twilight',
					\'torte', 'tolerable', 'tir_black', 'tcsoft', 'taqua',
					\'tango2', 'tango', 'tabula', 'synic', 'summerfruit256',
					\'spring', 'soso', 'softblue', 'simpleandfriendly', 'silent',
					\'sienna', 'settlemyer', 'sea', 'satori', 'rootwater',
					\'robinhood', 'relaxedgreen', 'rdark', 'railscasts2', 'railscasts',
					\'pyte', 'print_bw', 'peaksea', 'papayawhip', 'olive',
					\'oceanlight', 'oceandeep', 'oceanblack', 'nuvola', 'northland',
					\'no_quarter', 'nightshimmer', 'night', 'neverness', 'neon',
					\'navajo-night', 'navajo', 'mustang', 'motus', 'moss',
					\'moria', 'monokai', 'molokai', 'matrix', 'martin_krischik',
					\'maroloccio', 'marklar', 'manxome', 'lucius', 'lettuce',
					\'leo', 'kellys', 'jellybeans', 'jammy', 'ironman',
					\'inkpot', 'impact', 'herald', 'habilight', 'guardian',
					\'golden', 'fruity', 'fruit', 'freya', 'fog',
					\'fnaqevan', 'fine_blue2', 'fine_blue', 'ekvoli', 'eclipse',
					\'earendel', 'dw_yellow', 'dw_red', 'dw_purple', 'dw_orange',
					\'dw_green', 'dw_cyan', 'dw_blue', 'dusk', 'desertEx',
					\'desert256', 'denim', 'dawn', 'darkspectrum', 'darkslategray',
					\'darkbone', 'darkblue2', 'darkZ', 'dante', 'colorer',
					\'cleanphp', 'clarity', 'chocolateliquor', 'chela_light', 'candycode',
					\'candy', 'camo', 'calmar256-light', 'calmar256-dark', 'buttercream',
					\'brookstream', 'breeze', 'borland', 'bluegreen', 'blacksea', 'biogoo',
					\'bclear', 'baycomb', 'badwolf', 'autumnleaf', 'autumn2',
					\'autumn', 'asu1dark', 'astronaut', 'aqua', 'anotherdark',
					\'aiseered', 'adrian', 'adaryn']
" Set list of color scheme names that we will use, except
" argument 'now' actually changes the current color scheme.
function! s:SetColors(args)
  if len(a:args) == 0
    echo 'Current color scheme names:'
    let i = 0
    while i < len(s:mycolors)
      echo '  '.join(map(s:mycolors[i : i+4], 'printf("%-14s", v:val)'))
      let i += 5
    endwhile
  elseif a:args == 'all'
    let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
    let s:mycolors = map(paths, 'fnamemodify(v:val, ":t:r")')
    echo 'List of colors set from all installed color schemes'
  elseif a:args == 'my'
    let c1 = 'default elflord peachpuff desert256 breeze morning'
    let c2 = 'darkblue gothic aqua earth black_angus relaxedgreen'
    let c3 = 'darkblack freya motus impact less chocolateliquor'
    let s:mycolors = split(c1.' '.c2.' '.c3)
    echo 'List of colors set from built-in names'
  elseif a:args == 'now'
    call s:HourColor()
  else
    let s:mycolors = split(a:args)
    echo 'List of colors set from argument (space-separated names)'
  endif
endfunction

command! -nargs=* SetColors call s:SetColors('<args>')

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if len(s:mycolors) == 0
    call s:SetColors('all')
  endif
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap <F8> :call NextColor(1)<CR>
nnoremap <S-F8> :call NextColor(-1)<CR>
nnoremap <A-F8> :call NextColor(0)<CR>

