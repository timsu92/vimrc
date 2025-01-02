set number  " shows the line number

" source ~/.vim/log-autocmds.vim
" silent execute('LogAutocmds')
filetype on
set shiftwidth=4
set autoindent
set smartindent
set smarttab
autocmd FileType markdown setlocal expandtab
set tabstop=4
set softtabstop=4
set nocompatible
set scrolloff=2  " keep at least 2 lines above/below
set sidescrolloff=5  " keep at least 5 characters left/right
set incsearch  " incremental search
" set cindent  " 自動縮排
set wildmenu  " 按下tab時，顯示候選清單，而非直接覆蓋原本的指令
set mouse=nvi

" auto completion ignoring case
set ignorecase
set noinfercase

set cursorline  " highlighting of the current line

" line-brake and paste prototype
autocmd FileType c,cpp nnoremap <silent> 0 yyGo<ESC>]pA<BS><CR>{}<Left><CR><c-o>O

" move a line up/down {{{
inoremap <c-up>   <esc>dd<up>]Pi
inoremap <c-down> <esc>dd]pi
xnoremap <c-up>   d<up>]P
xnoremap <c-down> d]p
nnoremap <c-up>   Vd<up>]P
nnoremap <c-down> Vd]p
"}}}

" highlight search
set hlsearch

:command WQ wq
:command Wq wq
:command W w
:command Q q
:command -nargs=? -complete=file -bar Tabe tabe <args>
:command -nargs=* -complete=buffer -bang Bd bd<bang> <args>

" 佈景主題 {{{
syntax on
set termguicolors
colorscheme monokai
" fix undercurl not showing. https://github.com/vim/vim/issues/12744 https://vimhelp.org/term.txt.html#t_Ce
let &t_Cs="\<Esc>[4:3m"
let &t_Ce="\<Esc>[4:0m"
" 預設的暗色佈景主題
" colorscheme ron
"}}}

set encoding=utf-8
set cmdheight=2
set updatetime=600

" 以摺疊移動 {{{
nnoremap z<up>   zk
nnoremap z<down> zj
"}}}

" block-wise visual mode {{{
" Used for 多欄選取。Windows會變成貼上
nmap mv <c-v>
"}}}

" Load matchit.vim, but only if the user hasn't installed a newer version. {{{
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
	filetype plugin on
	runtime! macros/matchit.vim
endif
"}}}

" " PowerLine {{{
" set laststatus=2 " always show the statusline rendered by PowerLine
" set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" function! PowerlineSetup ()
	" py3 from powerline.vim import setup as powerline_setup
	" py3 powerline_setup()
	" py3 del powerline_setup
" endfunction
" call PowerlineSetup()
" "}}}

" vim-plug
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'Konfekt/FastFold'
Plug 'zhimsel/vim-stay'
" Plug 'crusoexia/vim-monokai' installed manually instead
Plug 'pangloss/vim-javascript'
Plug 'luochen1990/rainbow'
Plug 'timsu92/vim-easymotion'
Plug 'preservim/nerdtree' | 
	\ Plug 'Xuyuanp/nerdtree-git-plugin' |
	\ Plug 'ryanoasis/vim-devicons' " plugins uses it must load before it
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'puremourning/vimspector'
Plug '~/.fzf'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-endwise'
Plug 'tmhedberg/SimpylFold', {'for': 'python,cython'}
Plug 'iamcco/mathjax-support-for-mkdp', {'for': 'markdown'}
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sleuth'
Plug 'untitled-ai/jupyter_ascending.vim'
call plug#end()
" call ":PlugUpdate [name ...]" to update plugins
" call ":PlugInstall" to install plugins
" call ":PlugUpgrade" to upgrade vim-plug itself
" call ":PlugStatus" to check the status of plugins
" call ":PlugClean" to remove unlisted plugins

" yank to clipboards {{{
let s:clip = []
if executable('/mnt/c/Windows/System32/clip.exe')
	if executable('iconv')
		let s:clip += ['iconv -t UTF16LE | /mnt/c/Windows/System32/clip.exe']
	else
		let s:clip += ['/mnt/c/Windows/System32/clip.exe']
	endif
endif

if executable('snap') && system('snap list clipboard') !~? '^error'
	let s:clip += ['snap run clipboard']
endif

augroup WSLYank
	autocmd!
	for clip in s:clip
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(clip, @0) | endif
	endfor
augroup END
"}}}


" junegunn/vim-easy-align {{{
" vip代表選取整個paragraph
"	= Around the 1st occurrences
"	2= Around the 2nd occurrences
"	*= Around all occurrences
"	**= Left/Right alternating alignment around all occurrences
"	<Enter> Switching between left/right/center alignment modes
"		Use before =
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}


" neoclide/coc.nvim {{{
" Call ":CocList extensions" to check the status of coc plugins
"	? means invalid extension
"	* means extension is activated
"	+ means extension is loaded
"	- means extension is disabled
"	Use arrows to navigate. Hit <TAB> to activate action menu
let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-cmake', 'coc-highlight', 'coc-html', 'coc-sh', 'coc-vimlsp', 'coc-pairs', 'coc-omni', 'coc-word', 'coc-snippets', 'coc-markdownlint', 'coc-spell-checker', 'coc-lightbulb', 'coc-pyright', '@yaegassy/coc-volar', '@yaegassy/coc-volar-tools', '@yaegassy/coc-tailwindcss3',
			\ 'coc-pydocstring', 'coc-toml', 'coc-rust-analyzer', 'coc-lists', 'coc-yaml', 'coc-docker']
set hidden

" Some servers have issues with backup files, see #649. {{{
set nobackup
set nowritebackup "}}}

" Always show the signcolumn, otherwise it would shift the text each time {{{
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif "}}}

function! EchoWarn(text) "{{{
	echohl WarningMsg
	echo a:text
	echohl None
	return ""
endfunction "}}}

" Map <C-f> and <C-b> for scroll float windows/popups. {{{
if has('nvim-0.4.0') || has('patch-8.2.0750')
	inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : EchoWarn("[coc] Scroll not exist")
	inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : EchoWarn("[coc] Scroll not exist")
	nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : EchoWarn("[coc] Scroll not exist")
	nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : EchoWarn("[coc] Scroll not exist")
	vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : EchoWarn("[coc] Scroll not exist")
	vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : EchoWarn("[coc] Scroll not exist")
else
	inoremap <silent><nowait><expr> <c-f> EchoWarn("[coc] Scroll not supported")
	inoremap <silent><nowait><expr> <c-b> EchoWarn("[coc] Scroll not supported")
	nnoremap <silent><nowait><expr> <c-f> EchoWarn("[coc] Scroll not supported")
	nnoremap <silent><nowait><expr> <c-b> EchoWarn("[coc] Scroll not supported")
	vnoremap <silent><nowait><expr> <c-f> EchoWarn("[coc] Scroll not supported")
	vnoremap <silent><nowait><expr> <c-b> EchoWarn("[coc] Scroll not supported")
endif "}}}

" Tab for navigate, snippet jump, show pum. S-Tab for navigate, snippet jump. {{{
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#jumpable() ? "\<C-r>=coc#snippet#next()\<CR>" :
      \ <sid>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <S-TAB>
      \ coc#pum#visible() ? coc#pum#prev(1) :
      \ coc#jumpable() ? "\<C-r>=coc#snippet#prev()\<CR>" :
      \ ""
"}}}

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

function! ShowDocumentation() "{{{
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys("\<f1>", 'in')
  endif
endfunction "}}}

" GoTo code navigation
" Use ctrl-o to go back
" Use ":verbose imap <KEY>" to check if it's mapped by others
nmap <silent> gd  <Plug>(coc-definition)
nmap <silent> gy  <Plug>(coc-type-definition)
nmap <silent> gi  <Plug>(coc-implementation)
nmap <silent> gr  <Plug>(coc-references)
nmap <f2>         <Plug>(coc-rename)
imap <f2>         <c-o><Plug>(coc-rename)
" code action for the whole file
nmap <leader>cA   <Plug>(coc-codeaction-source)
vmap <leader>ca   <Plug>(coc-codeaction-selected)
nmap <leader>ca   <Plug>(coc-codeaction-cursor)
" Formatting selected code.
xmap <leader>f    <Plug>(coc-format-selected)
nmap <leader>f    <Plug>(coc-format)
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
inoremap <expr> <c-p> CocActionAsync('showSignatureHelp')
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
nnoremap <silent> <f1> :call ShowDocumentation()<CR>

" Map function and class text objects {{{
" Use like vif, vaf...
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
"}}}

inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() :
			\ coc#pum#visible() && coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :
			\ "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold,CursorHoldI * call CocActionAsync('highlight')

" Use <c-w>w to close most recent float window {{{
nmap <expr> <c-w>w
	\ <sid>coc_float_close_last() ? '' : ''

function! s:coc_float_close_last() abort
	if(get(g:, 'coc_last_float_win', v:null) is v:null || index(popup_list(), g:coc_last_float_win) == -1)
		" no such float
		return v:false
	endif
	if(!has_key(getwininfo(g:coc_last_float_win)[0]['variables'], 'float') || getwininfo(g:coc_last_float_win)[0]['variables']['float'] == 0)
		" not a float
		return v:false
	endif
	call coc#float#close(g:coc_last_float_win)
	redraw
	return v:true
endfunction
"}}}

autocmd BufAdd * let b:coc_trim_trailing_whitespace = 1
autocmd BufAdd * let b:coc_trim_final_newlines = 0
"}}}


" coc-snippets {{{
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
"}}}


" coc-pyright {{{
augroup Python
	autocmd BufWritePre *.py execute("CocCommand pyright.organizeimports") | call CocAction('format')
augroup END
" }}}


" preservim/nerdcommenter {{{
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
autocmd FileType python let g:NERDSpaceDelims = 0  " 否則Python會變成兩個空格
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
let g:NERDAltDelims_java = 1
let g:NERDCreateDefaultMappings = 0
nmap <leader>cc <Plug>NERDCommenterComment
nmap <leader>cu <Plug>NERDCommenterUncomment
nmap <leader>cs <Plug>NERDCommenterSexy
nmap <leader>cm <Plug>NERDCommenterMinimal
vmap <leader>cc <Plug>NERDCommenterComment
vmap <leader>cu <Plug>NERDCommenterUncomment
vmap <leader>cs <Plug>NERDCommenterSexy
vmap <leader>cm <Plug>NERDCommenterMinimal
"}}}


" zhimsel/vim-stay {{{
" type ":CleanViewdir[!] [days]" to remove saved view sessions older than
" [days]. The bang version will remove w/o confirmation
set viewoptions=cursor,slash,unix
autocmd FileType diff,gitcommit,vim-plug setlocal viewoptions=
"}}}


" luochen1990/rainbow {{{
let g:rainbow_active = 1
" rainbow is conflicting with NERDTree
let g:rainbow_conf = {
	\'guifgs': ['yellow', '#00FFFF', 'lightmagenta', '#B8FBA9'],
	\'ctermfgs': ['yellow', 'lightcyan','lightblue', 'lightmagenta'],
	\'separately': {
		\ 'nerdtree': 0,
	\ },
\}
"}}}


" easymotion/vim-easymotion {{{
let g:EasyMotion_use_migemo = 1  " match multibyte Japanese character with alphabetical input
let g:EasyMotion_smartcase = 1  " lower case will match both lower and upper; upper case will match upper only
let g:EasyMotion_use_smartsign_us = 1  " make 1 match 1 and !; ! will match ! only
" avoid annoying syntax errors while jumping
autocmd User EasyMotionPromptBegin :let b:coc_diagnostic_disable = 1
autocmd User EasyMotionPromptEnd   :let b:coc_diagnostic_disable = 0
"}}}


" preservim/nerdtree {{{
autocmd StdinReadPre * let s:std_in=1
" Start NERDTree when Vim is started without file arguments.
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
nnoremap <silent><c-t> :NERDTreeToggle<cr>
"}}}


" terryma/vim-expand-region {{{
map <silent>+ <Plug>(expand_region_expand)
map <silent>- <Plug>(expand_region_shrink)
"{{{
let g:expand_region_text_objects = {
      \ 'i"'  :1,
      \ 'a"'  :1,
      \ 'i''' :1,
      \ 'a''' :1,
      \ 'i]'  :1,
      \ 'a]'  :1,
      \ 'ib'  :1,
      \ 'ab'  :1,
      \ 'iB'  :1,
      \ 'aB'  :1,
      \ 'il'  :1,
      \ 'ip'  :1,
      \ }
"}}}
"}}}


" Xuyuanp/nerdtree-git-plugin {{{
let g:NERDTreeGitStatusUseNerdFonts = 1
"}}}


" ryanoasis/vim-devicons {{{
set encoding=UTF-8
"}}}


" puremourning/vimspector {{{
" use ":VimspectorInstall <adapter> <args...>" to install adapters/gadgets. Add '!' to not close the
" output window right after successful installation
" use ":VimspectorUpdate <adapter> <args...>" to update adapters/gadgets. Add '!' to not close the
" output window right after successful installation
" Document for config file: https://puremourning.github.io/vimspector/configuration.html
" Config file '.vimspector.json' can be put under ~/.vim/plugged/vimspector/configurations/linux/_all/
syntax enable
filetype indent on
let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools', 'CodeLLDB']
" required by debugpy
let g:vimspector_base_dir=expand('~/.vim/plugged/vimspector') " do NOT end with forward slash

let s:vimspectorOriginalWinid = v:null
function s:setVimspectorOriginalWinid()
	if s:vimspectorOriginalWinid == v:null || len(g:vimspector_session_windows) == 0
		let s:vimspectorOriginalWinid = win_getid()
	endif
endfunction

" HUMAN-like mappings {{{
" nmap <F3>            <Plug>VimspectorStop
" nmap <leader><F3>    :VimspectorReset<cr>
" nmap <F4>            <Plug>VimspectorRestart
nmap <silent> <F5>           :call <SID>setVimspectorOriginalWinid()<cr><Plug>VimspectorContinue
nmap <silent> <leader><F5>   :call <SID>setVimspectorOriginalWinid()<cr><Plug>VimspectorLaunch
nmap <silent> <leader><s-F5> :call <SID>setVimspectorOriginalWinid()<cr><Plug>VimspectorRunToCursor
" nmap <F6>            <Plug>VimspectorPause
" nmap <F7>            <Plug>VimspectorStepOver
" nmap <F8>            <Plug>VimspectorStepInto
" nmap <F9>            <Plug>VimspectorStepOut
nmap <F10>           <Plug>VimspectorToggleBreakpoint
nmap <leader><F10>   <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader><s-F10> <Plug>VimspectorAddFunctionBreakpoint
" nmap <Leader><s-F12> <Plug>VimspectorUpFrame
" nmap <Leader><F12>   <Plug>VimspectorDownFrame
"}}}

" toggle breakpoints window {{{
" See https://github.com/puremourning/vimspector#breakpoints-window
nmap <silent><expr> <leader>db "\<Plug>VimspectorBreakpoints:if len(g:vimspector_session_windows) > 1 \| call \<sid>VimspectorInitBuf()<cr> \| endif<cr>"
"}}}

let s:vimspectorMappedBufnr = []
" ⁰¹²³⁴⁵⁶⁷⁸⁹
" ['stack_trace', 'output', 'watches', 'terminal', 'variables', 'code', 'eval', 'mode', 'breakpoints', 'tabpage']
" 'terminal' isn't created when VimspectorUICreated
function s:VimspectorUIoutputPre() abort "{{{
	set nonumber
	set relativenumber
endfunction "}}}

function s:VimspectorUIcodePost() abort "{{{
	" Clear the existing WinBar created by Vimspector
	nunmenu WinBar
	nmenu WinBar.▶Cont⁵     <Plug>VimspectorContinue
	nmenu WinBar.\|\|Pause⁶ <Plug>VimspectorPause
	nmenu WinBar.■Stop³     <Plug>VimspectorStop
	nmenu WinBar.✕Closeˢ³   :VimspectorReset<cr>
	nmenu WinBar.⟲Reload⁴  <Plug>VimspectorRestart
	nmenu WinBar.↷Over⁷     <Plug>VimspectorStepOver
	nmenu WinBar.↓Into⁸     <Plug>VimspectorStepInto
	nmenu WinBar.↑Out⁹      <Plug>VimspectorStepOut
endfunction "}}}

function s:VimspectorUIbreakpointsPost() abort "{{{
	nunmap <buffer> <leader><F3>
	nmap   <buffer> <leader><F3> :call win_gotoid(g:vimspector_session_windows['code'])<cr>:VimspectorReset<cr>
endfunction "}}}

function s:VimspectorCreateUI() abort "{{{
	for l:winName in keys(g:vimspector_session_windows)
		if g:vimspector_session_windows[l:winName] != v:none && l:winName != 'tabpage' && l:winName != 'mode'
			call win_gotoid(g:vimspector_session_windows[l:winName])
			if(exists("*<sid>VimspectorUI" . l:winName . "Pre"))
				execute "call <sid>VimspectorUI" . l:winName . 'Pre()'
			endif
			call <sid>VimspectorInitBuf()
			if(exists("*<sid>VimspectorUI" . l:winName . "Post"))
				execute "call <sid>VimspectorUI" . l:winName . 'Post()'
			endif
		endif
	endfor
endfunction "}}}

function s:VimspectorInitBuf() abort "{{{
	if(index(s:vimspectorMappedBufnr, bufnr()) != -1)
		return
	endif

	" HUMAN-like mappings {{{
	if(win_getid() == g:vimspector_session_windows['code'])
		" Evaluate part of program
		nmap <buffer> <f1> <Plug>VimspectorBalloonEval
		xmap <buffer> <f1> <Plug>VimspectorBalloonEval
	endif

	nmap <buffer> <F3>             <Plug>VimspectorStop
	if(g:vimspector_session_windows['breakpoints'] == win_getid())
		nmap <buffer><expr> <leader><F3> ":call win_gotoid(g:vimspector_session_windows['code'])<cr>:VimspectorReset<cr>"
	else
		nmap <buffer>       <leader><F3> :VimspectorReset<cr>
	endif
	nmap <buffer> <F4>            <Plug>VimspectorRestart
	nmap <buffer> <F6>            <Plug>VimspectorPause
	nmap <buffer> <F7>            <Plug>VimspectorStepOver
	nmap <buffer> <F8>            <Plug>VimspectorStepInto
	nmap <buffer> <F9>            <Plug>VimspectorStepOut
	nmap <buffer> <Leader><s-F12> <Plug>VimspectorUpFrame
	nmap <buffer> <Leader><F12>   <Plug>VimspectorDownFrame
	"}}}
	nnoremap <buffer> <leader><TAB> :VimspectorShowOutput 

	if win_getid() == g:vimspector_session_windows['code']
		call add(s:vimspectorMappedBufnr, bufnr())
	endif
endfunction "}}}

function s:VimspectorInitTerm() abort "{{{
	if(index(s:vimspectorMappedBufnr, g:vimspector_session_windows['terminal']) != -1)
		return
	endif

	call win_gotoid(g:vimspector_session_windows['terminal'])
	call s:VimspectorInitBuf()

	set nonumber
	set relativenumber
	" HUMAN-like mappings {{{
	tmap     <F3>             <c-\><c-n><Plug>VimspectorStop
	tnoremap <leader><F3>     <c-\><c-n>:VimspectorReset<cr>
	tmap     <F4>             <c-\><c-n><Plug>VimspectorRestart
	tmap     <F6>             <c-\><c-n><Plug>VimspectorPause
	tmap     <F7>             <c-\><c-n><Plug>VimspectorStepOver
	tmap     <F8>             <c-\><c-n><Plug>VimspectorStepInto
	tmap     <F9>             <c-\><c-n><Plug>VimspectorStepOut
	tmap     <Leader><s-F12>  <c-\><c-n><Plug>VimspectorUpFrame
	tmap     <Leader><F12>    <c-\><c-n><Plug>VimspectorDownFrame
	"}}}
	tnoremap <leader><TAB>    <c-\><c-n>:VimspectorShowOutput
	tnoremap <leader><leader> <leader>

endfunction "}}}

function s:VimspectorOnDebugEnd() abort "{{{
	let l:originalBufnr = bufnr()
	let l:hidden = &hidden
	augroup VimspectorSwapExists
		autocmd!
		autocmd SwapExists * let v:swapchoice='o'
	augroup END

	try
		set hidden
		for l:bufnr in s:vimspectorMappedBufnr "{{{
			try
				execute "buffer " . l:bufnr
				silent! nunmap <buffer> <F3>
				silent! nunmap <buffer> <leader><F3>
				silent! nunmap <buffer> <F4>
				silent! nunmap <buffer> <F6>
				silent! nunmap <buffer> <F7>
				silent! nunmap <buffer> <F8>
				silent! nunmap <buffer> <F9>
				silent! nunmap <buffer> <leader><s-F12>
				silent! nunmap <buffer> <Leader><F12>
				silent! nunmap <buffer> <f1>
				silent! xunmap <buffer> <f1>
				silent! nunmap <buffer> <leader><TAB>
			endtry
		endfor "}}}
	finally
		execute 'noautocmd buffer ' . l:originalBufnr
		let &hidden = hidden
	endtry

	autocmd! VimspectorSwapExists
	let s:vimspectorMappedBufnr = []

	" Unmap terminal {{{
	silent! tunmap <f3>
	silent! tunmap <leader><f3>
	silent! tunmap <f4>
	silent! tunmap <f6>
	silent! tunmap <f7>
	silent! tunmap <f8>
	silent! tunmap <f9>
	silent! tunmap <Leader><s-F12>
	silent! tunmap <Leader><F12>
	silent! tunmap <leader><TAB>
	silent! tunmap <leader><leader>
	"}}}

	call win_gotoid(s:vimspectorOriginalWinid)
	let s:vimspectorOriginalWinid = v:null
endfunction "}}}

autocmd User VimspectorUICreated           call <sid>VimspectorCreateUI()
autocmd User VimspectorJumpedToFrame       call <sid>VimspectorInitBuf()
autocmd User VimspectorTerminalOpened      call <sid>VimspectorInitTerm()
autocmd User VimspectorDebugEnded ++nested call <sid>VimspectorOnDebugEnd()

" Save/load session file {{{
let s:vimspectorSessionPrefix = '~/.vim/view/'
let s:vimspectorSessionFileName = substitute(expand('%:p'), '/', '+', 'g') . '.vimspector.session.json'
augroup VIMSPECTOR_SESSION
	autocmd BufReadPost * silent! execute("VimspectorLoadSession " . s:vimspectorSessionPrefix . s:vimspectorSessionFileName)
	autocmd BufWritePost * silent execute("VimspectorMkSession " . s:vimspectorSessionPrefix . s:vimspectorSessionFileName)
augroup end
autocmd FileType diff,gitcommit,json,vim,sh,zsh,log,vim-plug,gitconfig au! VIMSPECTOR_SESSION
"}}}
"}}}


" fzf {{{
" An action can be a reference to a function that processes selected lines
" function! s:build_quickfix_list(lines)
  " call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  " copen
  " cc
" endfunction

" key bindings
" 'ctrl-q': function('s:build_quickfix_list'),
let g:fzf_action = {
		\ 'ctrl-t': 'tab split',
		\ 'ctrl-h': 'split',
		\ 'ctrl-v': 'vsplit'
	  \ }

" Popup window (anchored to the bottom of the current window)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }

" Customize fzf colors to match your color scheme {{{
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors = {
        \  'fg':      ['fg', 'Normal'],
        \  'bg':      ['bg', 'Normal'],
        \  'hl':      ['fg', 'Comment'],
        \  'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \  'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \  'hl+':     ['fg', 'Statement'],
        \  'info':    ['fg', 'PreProc'],
        \  'border':  ['fg', 'Ignore'],
        \  'prompt':  ['fg', 'Conditional'],
        \  'pointer': ['fg', 'Exception'],
        \  'marker':  ['fg', 'Keyword'],
        \  'spinner': ['fg', 'Label'],
        \  'header':  ['fg', 'Comment']
		\ }
"}}}

" Enable per-command history {{{
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'
"}}}

" Use fzf to find files. {{{
" Receives an optional param to specify the folder to search
" Saves historical searches of *LS* and *LA* in file *ls*
command -complete=dir -nargs=? LS
	\ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}))
command -complete=dir -nargs=? LA
	\ call fzf#run(fzf#wrap('ls', {'source': 'ls -A', 'dir': <q-args>}))
nmap <silent> <c-n> :LA<cr>
"}}}
"}}}


" tmhedberg/SimpylFold {{{
let g:SimpylFold_docstring_preview = 1
"}}}


" iamcco/markdown-preview.nvim {{{
function! MdpOpenPreview(url) abort
	let l:mdp_browser = '/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe'
	let l:mdp_browser_opts = '--profile-directory=default --new-window'
	if !filereadable(substitute(l:mdp_browser, '\\ ', ' ', 'g'))
		let l:mdp_browser = '/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
		let l:mdp_browser_opts = '--new-window'
	endif
	execute join(['silent! !', l:mdp_browser, l:mdp_browser_opts, a:url])
	redraw!
endfunction

let g:mkdp_browserfunc = 'MdpOpenPreview'
let g:mkdp_preview_options = {
		\ 'disable_filename': 1
	  \ }
let g:mkdp_echo_preview_url = 1
let g:mkdp_page_title = expand('%:p:h:t') . '/${name}'
" disable vimspector and use markdown-preview instead
autocmd FileType markdown {
		nmap <buffer> <leader><F5>    <esc>
		nmap <buffer> <leader><s-F5>  <esc>
		nmap <buffer> <F10>           <esc>
		nmap <buffer> <leader><F10>   <esc>
		nmap <buffer> <leader><s-F10> <esc>
		nmap <buffer> <leader>db      <esc>
		nmap <buffer> <f5>            <Plug>MarkdownPreview
		nmap <buffer> <leader><f3>    <Plug>MarkdownPreviewStop:echo 'Markdown preview stopped'<cr>
		imap <buffer> <f5>            <Plug>MarkdownPreview
		imap <buffer> <leader><f3>    <Plug>MarkdownPreviewStop<c-o>:echo 'Markdown preview stopped'<cr>
	}
" }}}


" Konfekt/FastFold {{{
nmap zuz <Plug>(FastFoldUpdate)
" Open all folds. Close them using 0
autocmd BufReadPost * if line('$') > 65 | setlocal foldlevel=0 | else | setlocal foldlevel=99 | endif
let g:fastfold_savehook = 0
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','O','C']
let g:fastfold_fold_movement_commands = [']z','[z','zj','zk']
let g:fastfold_minlines = 6
let g:fastfold_skip_filetypes = ['diff', 'list', 'gitcommit', 'vim-plug']
let g:markdown_folding = 1
filetype on
autocmd FileType c,cpp,sh,zsh,json,typescript,javascript setlocal foldmethod=syntax
" javascript在vim-javascript
let g:sh_fold_enabled = 7
let g:zsh_fold_enable = 1
xnoremap <silent> iz :<c-u>FastFoldUpdate<cr>]z<up>$v[z<down>^
xnoremap <silent> az :<c-u>FastFoldUpdate<cr>]zV[z

function FoldWhenCocProviderExist() abort
	if get(g:, 'coc_service_initialized', 0) == 1 && exists('*CocHasProvider') && call('CocHasProvider', ['foldingRange']) == v:true
		call CocActionAsync('fold')
		setl foldlevel=1
	else
		call timer_start(100, {-> FoldWhenCocProviderExist()})
	endif
endfunction

autocmd FileType vue call FoldWhenCocProviderExist()
"}}}


" yaegassy/coc-volar {{{
autocmd FileType css,vue,typescriptreact,javascriptreact setl iskeyword+=-
autocmd FileType scss    setl iskeyword+=@-@
autocmd FileType vue call coc#config('coc.preferences', {'formatOnType': v:true})
autocmd FileType javascript,typescript let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'vite.config.js', 'vue.config.js', 'nuxt.config.ts', 'node_modules']
autocmd FileType vue let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'vite.config.js', 'vue.config.js', 'nuxt.config.ts', 'node_modules']
" }}}


" neoclide/coc-json {{{
" Avoid chaos because of comments in json
autocmd FileType json setl filetype=jsonc
" }}}


" fannheyward/coc-rust-analyzer {{{
function! s:rustSetupDebug() "{{{
	function! s:rustDebugUnmap() abort
		silent! nunmap <buffer> <F5>
		silent! nunmap <buffer> <leader><F5>
		silent! nunmap <buffer> <leader><s-F5>
	endfunction

	function! s:rustDebugMap() abort
		nmap <buffer><silent> <F5>           :call <SID>setVimspectorOriginalWinid()<CR>:CocCommand rust-analyzer.debug<CR>
		nmap <buffer><silent> <leader><F5>   :call <SID>setVimspectorOriginalWinid()<CR>:CocCommand rust-analyzer.debug<CR>
		nmap <buffer><silent> <leader><s-F5> <esc>
	endfunction

	" override default function
	function! s:VimspectorOnDebugEnd() abort
		let l:originalBufnr = bufnr()
		let l:hidden = &hidden
		augroup VimspectorSwapExists
			autocmd!
			autocmd SwapExists * let v:swapchoice='o'
		augroup END

		try
			set hidden
			for l:bufnr in s:vimspectorMappedBufnr "{{{
				try
					execute "buffer " . l:bufnr
					silent! nunmap <buffer> <F3>
					silent! nunmap <buffer> <leader><F3>
					silent! nunmap <buffer> <F4>
					silent! nunmap <buffer> <F6>
					silent! nunmap <buffer> <F7>
					silent! nunmap <buffer> <F8>
					silent! nunmap <buffer> <F9>
					silent! nunmap <buffer> <leader><s-F12>
					silent! nunmap <buffer> <Leader><F12>
					silent! nunmap <buffer> <f1>
					silent! xunmap <buffer> <f1>
					silent! nunmap <buffer> <leader><TAB>
					call s:rustDebugUnmap()
					call s:rustDebugMap()
				endtry
			endfor "}}}
		finally
			execute 'noautocmd buffer ' . l:originalBufnr
			let &hidden = hidden
		endtry

		autocmd! VimspectorSwapExists
		let s:vimspectorMappedBufnr = []

		" Unmap terminal {{{
		silent! tunmap <f3>
		silent! tunmap <leader><f3>
		silent! tunmap <f4>
		silent! tunmap <f6>
		silent! tunmap <f7>
		silent! tunmap <f8>
		silent! tunmap <f9>
		silent! tunmap <Leader><s-F12>
		silent! tunmap <Leader><F12>
		silent! tunmap <leader><TAB>
		silent! tunmap <leader><leader>
		"}}}

		call win_gotoid(s:vimspectorOriginalWinid)
		let s:vimspectorOriginalWinid = v:null
	endfunction

	" if there's a function with the same name, don't just override!
	function s:VimspectorUIcodePre() abort
		call win_gotoid(g:vimspector_session_windows['code'])
		call s:rustDebugUnmap()
	endfunction
endfunction "}}}

autocmd FileType rust {
	call s:rustSetupDebug()
	call s:rustDebugMap()
	autocmd User VimspectorJumpedToFrame call s:rustDebugUnmap()
	call coc#config('coc.preferences', {'formatOnType': v:true})
}
" }}}


" vim-airline/vim-airline {{{
set laststatus=2
set noshowmode
" show buffers when there's only one tab
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#coc#show_coc_status = 1
" }}}


" untitled-ai/jupyter_ascending.vim {{{
let g:jupyter_ascending_default_mappings = v:false
augroup Jupyter
	au!
	if match(expand('%'), '.sync.py$') != -1
		au! Python BufWritePre
		call coc#config("python.formatting", {
				\ "provider": v:null
			  \ })
		nmap <buffer> <F4>            <Plug>JupyterRestart
		nmap <buffer> <F5>            <Plug>JupyterExecute
		nmap <buffer> <leader><F5>    <Plug>JupyterExecuteAll
		nmap <buffer> <leader><s-F5>  <esc>
		nmap <buffer> <F10>           <esc>
		nmap <buffer> <leader><F10>   <esc>
		nmap <buffer> <leader><s-F10> <esc>
	endif
augroup END
" }}}

" vim: foldmethod=marker:tabstop=4
