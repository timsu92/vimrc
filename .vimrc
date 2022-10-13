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

" auto completion ignoring case
set ignorecase
set noinfercase

set cursorline  " highlighting of the current line

" line-brake and paste prototype
" autocmd FileType c,cpp nnoremap <silent> 0 o<ESC>]pA<BS>{}<Left><CR><esc>O
autocmd FileType c,cpp nnoremap <silent> 0 yyGo<ESC>]pA<BS>{}<Left><CR><esc>O

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

" 佈景主題 {{{
syntax on
colorscheme monokai
set termguicolors
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
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

" PowerLine {{{
set laststatus=2 " always show the statusline rendered by PowerLine
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
function! PowerlineSetup ()
	py3 from powerline.vim import setup as powerline_setup
	py3 powerline_setup()
	py3 del powerline_setup
endfunction
call PowerlineSetup()
"}}}

" vim-plug
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
" Plug 'mphe/grayout.vim', {'for': "c,cpp"}
Plug 'Konfekt/FastFold'
" Plug 'preservim/tagbar'
Plug 'zhimsel/vim-stay'
" Plug 'crusoexia/vim-monokai' installed manually instead
" Plug 'pangloss/vim-javascript'
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
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install', 'for': 'markdown'} " If you have nodejs and yarn
call plug#end()
" call ":PlugUpdate [name ...]" to update plugins
" call ":PlugInstall" to install plugins
" call ":PlugUpgrade" to upgrade vim-plug itself
" call ":PlugStatus" to check the status of plugins
" call ":PlugClean" to remove unlisted plugins


" WSL yank support {{{
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
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
let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-cmake', 'coc-highlight', 'coc-html', 'coc-sh', 'coc-vimlsp', 'coc-pairs', 'coc-omni', 'coc-word', 'coc-snippets', 'coc-markdownlint', 'coc-spell-checker', 'coc-lightbulb', 'coc-pyright']

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

" Tab for navigate, snippet jump. {{{
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ coc#jumpable() ? "\<C-r>=coc#snippet#next()\<CR>" :
      \ <sid>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
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
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gi  <Plug>(coc-implementation)
nmap <silent> gr  <Plug>(coc-references)
nmap <f2>         <Plug>(coc-rename)
imap <f2>         <c-o><Plug>(coc-rename)
nmap <leader>ca   <Plug>(coc-codeaction)
vmap <leader>ca   <Plug>(coc-codeaction-selected)
" Formatting selected code.
xmap <leader>f    <Plug>(coc-format-selected)
nmap <leader>f    <Plug>(coc-format-selected)
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
			\ coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :
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
"}}}


" coc-snippets {{{
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
"}}}


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
nmap <leader>cc       <Plug>NERDCommenterComment
nmap <leader>cu       <Plug>NERDCommenterUncomment
nmap <leader>c<space> <Plug>NERDCommenterToggle
vmap <leader>cc       <Plug>NERDCommenterComment
vmap <leader>cu       <Plug>NERDCommenterUncomment
vmap <leader>c<space> <Plug>NERDCommenterToggle
"}}}


" " mphe/grayout.vim {{{
" " Set libclang searchpath. This should point to the directory containing `libclang.so`.
" let g:grayout_libclang_path = '/usr/lib/llvm-14/lib'
" " Set default compile flags.
" " These are used, when no `compile_commands.json` or `.grayout.conf` file was found.
" autocmd BufNewFile,BufReadPost * if &ft == 'c' | let g:grayout_default_args = ['-x', 'c', '-std=c11'] | endif
" autocmd BufNewFile,BufReadPost * if &ft == 'cpp' | let g:grayout_default_args = ['-x', "c++", '-std=c++14'] | endif
" " Run GrayoutUpdate when cursor stands still. This can cause lag in more complex files.
" autocmd CursorHold,CursorHoldI * if &ft == 'c' || &ft == 'cpp' || &ft == 'objc' | exec 'GrayoutUpdate' | endif
" " Run GrayoutUpdate when opening and saving a buffer
" autocmd BufReadPost,BufWritePost * if &ft == 'c' || &ft == 'cpp' || &ft == 'objc' | exec 'GrayoutUpdate' | endif
" highlight PreprocessorGrayout ctermfg=DarkGray guifg=#6c6c6c
" "}}}


" " preservim/tagbar {{{
" " visibility of a tag is shown as { 'public' : '+', 'protected' : '#', 'private' : '-' }
" " nmap <silent> <F8> :TagbarToggle<CR>
" " imap <silent> <F8> <C-O>:TagbarToggle<CR><esc>
" " 視窗水平分割在上方
" let g:tagbar_position = 'top'
" let g:tagbar_height = 13
" " automatically close when you jump to a tag (implies moving cursor to Tagbar window while opening)
" let g:tagbar_autoclose = 1
" " show tag's data-type right of the tag
" let g:tagbar_show_data_type = 1
" " print the tag line number next to the tag in the tagbar (print to the left of the tag)
" " let g:tagbar_show_tag_linenumbers = 2
" " single click to navigate
" let g:tagbar_singleclick = 1
" let g:tagbar_autoshowtag = 1
" " let g:tagbar_autopreview = 1
" let g:tagbar_sort = 0
" let g:no_status_line = 1
" autocmd FileType vim,diff let b:tagbar_ignore = 1
" "}}}


" zhimsel/vim-stay {{{
" type ":CleanViewdir[!] [days]" to remove saved view sessions older than
" [days]. The bang version will remove w/o confirmation
set viewoptions=cursor,slash,unix,folds
autocmd FileType diff,gitcommit,vim-plug setlocal viewoptions=
autocmd FileType c,cpp,sh,zsh,json setlocal viewoptions-=folds
autocmd User BufStayLoadPre if expand('%:p')==expand('~/.vimrc') | setlocal viewoptions-=folds | endif
"}}}


" pangloss/vim-javascript {{{
augroup javascript_folding
    autocmd!
    autocmd FileType javascript setlocal foldmethod=syntax
augroup END
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
let g:vimspector_install_gadgets = ['debugpy', 'vscode-cpptools']
" required by debugpy
let g:vimspector_base_dir=expand('~/.vim/plugged/vimspector') " do NOT end with forward slash

" HUMAN-like mappings {{{
" nmap <F3>            <Plug>VimspectorStop
" nmap <leader><F3>    :VimspectorReset<cr>
" nmap <F4>            <Plug>VimspectorRestart
nmap <F5>            <Plug>VimspectorContinue
nmap <leader><F5>    <Plug>VimspectorLaunch
nmap <leader><s-F5>  <Plug>VimspectorRunToCursor
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

function s:VimspectorUIwatchesPre() abort "{{{
	nnoremap <buffer> <up>   <up><up>
	nnoremap <buffer> <down> <down><down>
endfunction "}}}

function s:VimspectorUIcodePost() abort "{{{
	" Evaluate part of program
	nmap <buffer> <f1> <Plug>VimspectorBalloonEval
	xmap <buffer> <f1> <Plug>VimspectorBalloonEval

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
	nmap <buffer> <F3>             <Plug>VimspectorStop
	if(g:vimspector_session_windows['breakpoints'] == bufnr())
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

	call add(s:vimspectorMappedBufnr, bufnr())
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
	for l:bufnr in s:vimspectorMappedBufnr "{{{
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
	endfor "}}}
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

	let s:vimspectorMappedBufnr = []
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
	let l:mdp_browser_opts = '--profile-directory="Default" --new-window'
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
autocmd FileType c,cpp,sh,zsh,json setlocal foldmethod=syntax
" javascript在vim-javascript
let g:sh_fold_enabled = 7
let g:zsh_fold_enable = 1
autocmd TextChanged <silent> <Plug>(FastFoldUpdate)
xnoremap <silent> iz :<c-u>FastFoldUpdate<cr>]z<up>$v[z<down>^
xnoremap <silent> az :<c-u>FastFoldUpdate<cr>]zV[z
"}}}

" vim: foldmethod=marker
