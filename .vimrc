set number  " shows the line number

filetype on
set shiftwidth=4
set autoindent
set smartindent
set smarttab
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

" auto close brackets
" inoremap " ""<left>
" autocmd FileType vim iunmap "
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O
" autocmd FileType vim inoremap <lt> <lt>><left>

" line-brake and paste prototype
" autocmd FileType c,cpp nnoremap <silent> 0 o<ESC>]pA<BS>{}<Left><CR><esc>O
autocmd FileType c,cpp nnoremap <silent> 0 yyGo<ESC>]pA<BS>{}<Left><CR><esc>O

" move a line up/down
inoremap <c-up> <esc>dd<up>]Pi
inoremap <c-down> <esc>dd]pi
xnoremap <c-up> d<up>]P
xnoremap <c-down> d]p
nnoremap <c-up> Vd<up>]P
nnoremap <c-down> Vd]p

" highlight search
set hlsearch

:command WQ wq
:command Wq wq
:command W w
:command Q q

" no wrap
" set nowrap

" 佈景主題
syntax on
colorscheme monokai
set termguicolors
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" 預設的暗色佈景主題
" colorscheme ron
set encoding=utf-8
set hidden
set cmdheight=2
set updatetime=600

" 以摺疊移動
nnoremap z<up> zk
nnoremap z<down> zj

" block-wise visual mode
" Used for 多欄選取。Windows會變成貼上
nmap mv <c-v>

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" PowerLine
set rtp+=/usr/local/lib/python3.8/dist-packages/powerline_status-2.8.2-py3.8.egg/powerline/bindings/vim
set laststatus=2 " always show the statusline rendered by PowerLine
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
function! PowerlineSetup ()
	py3 from powerline.vim import setup as powerline_setup
	py3 powerline_setup()
	py3 del powerline_setup
endfunction
call PowerlineSetup()

" vim-plug
call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'mphe/grayout.vim'
Plug 'Konfekt/FastFold'
Plug 'preservim/tagbar'
Plug 'zhimsel/vim-stay'
" Plug 'crusoexia/vim-monokai' installed manually instead
" Plug 'pangloss/vim-javascript'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree' | 
	\ Plug 'Xuyuanp/nerdtree-git-plugin' |
	\ Plug 'ryanoasis/vim-devicons' " plugins uses it must load before it
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'puremourning/vimspector'
Plug '~/.fzf'
call plug#end()
" call ":PlugUpdate [name ...]" to update plugins
" call ":PlugInstall" to install plugins
" call ":PlugUpgrade" to upgrade vim-plug itself
" call ":PlugStatus" to check the status of plugins
" call ":PlugClean" to remove unlisted plugins


" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif


" junegunn/vim-easy-align
" vip代表選取整個paragraph
"	= Around the 1st occurrences
"	2= Around the 2nd occurrences
"	*= Around all occurrences
"	**= Left/Right alternating alignment around all occurrences
"	<Enter> Switching between left/right/center alignment modes
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" neoclide/coc.nvim
" Call ":CocList extensions" to check the status of coc plugins
"	? means invalid extension
"	* means extension is activated
"	+ means extension is loaded
"	- means extension is disabled
"	Use arrows to navigate. Hit <TAB> to activate action menu
let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-cmake', 'coc-highlight', 'coc-html', 'coc-sh', 'coc-vimlsp', 'coc-pairs']
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! EchoWarn(text)
	echohl WarningMsg
	echo a:text
	echohl None
	return ""
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
	inoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : EchoWarn("[coc] Scroll not supported")
	inoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : EchoWarn("[coc] Scroll not supported")
	nnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : EchoWarn("[coc] Scroll not supported")
	nnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : EchoWarn("[coc] Scroll not supported")
	vnoremap <silent><nowait><expr> <c-f> coc#float#has_scroll() ? coc#float#scroll(1) : EchoWarn("[coc] Scroll not supported")
	vnoremap <silent><nowait><expr> <c-b> coc#float#has_scroll() ? coc#float#scroll(0) : EchoWarn("[coc] Scroll not supported")
else
	inoremap <silent><nowait><expr> <c-f> EchoWarn("[coc] Scroll not supported")
	inoremap <silent><nowait><expr> <c-b> EchoWarn("[coc] Scroll not supported")
	nnoremap <silent><nowait><expr> <c-f> EchoWarn("[coc] Scroll not supported")
	nnoremap <silent><nowait><expr> <c-b> EchoWarn("[coc] Scroll not supported")
	vnoremap <silent><nowait><expr> <c-f> EchoWarn("[coc] Scroll not supported")
	vnoremap <silent><nowait><expr> <c-b> EchoWarn("[coc] Scroll not supported")
endif
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ Check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! Check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" function! Show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " elseif (coc#rpc#ready())
	" echo "doHover"
    " call CocActionAsync('doHover')
  " else
    " execute '!' . &keywordprg . " " . expand('<cword>')
  " endif
" endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('\<f1>', 'in')
  endif
endfunction

" GoTo code navigation.
" Use ctrl-o to go back
" Use ":verbose imap <KEY>" to check if it's mapped by others
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <f2> <Plug>(coc-rename)
imap <f2> <c-o><Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
nnoremap <silent> <f1> :call ShowDocumentation()<CR>
" inoremap <silent><expr> <f1> ShowDocumentation()

" Used for the format on type and improvement of brackets
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	" \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" preservim/nerdcommenter
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
autocmd FileType python let g:NERDSpaceDelims = 0  " 否則Python會變成兩個空格
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
let g:NERDAltDelims_java = 1


" mphe/grayout.vim
" Set libclang searchpath. This should point to the directory containing `libclang.so`.
let g:grayout_libclang_path = '/usr/lib/llvm-14/lib'
" Set default compile flags.
" These are used, when no `compile_commands.json` or `.grayout.conf` file was found.
autocmd BufNewFile,BufReadPost * if &ft == 'c' | let g:grayout_default_args = ['-x', 'c', '-std=c11'] | endif
autocmd BufNewFile,BufReadPost * if &ft == 'cpp' | let g:grayout_default_args = ['-x', "c++", '-std=c++14'] | endif
" Run GrayoutUpdate when cursor stands still. This can cause lag in more complex files.
autocmd CursorHold,CursorHoldI * if &ft == 'c' || &ft == 'cpp' || &ft == 'objc' | exec 'GrayoutUpdate' | endif
" Run GrayoutUpdate when opening and saving a buffer
autocmd BufReadPost,BufWritePost * if &ft == 'c' || &ft == 'cpp' || &ft == 'objc' | exec 'GrayoutUpdate' | endif
highlight PreprocessorGrayout ctermfg=DarkGray guifg=#6c6c6c


" Konfekt/FastFold
set foldlevel=99 " Open all folds. Close them using 0
autocmd BufReadPost * if line('$') > 65 | set foldlevel=0 | endif
let g:fastfold_savehook = 0
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','O','C']
let g:fastfold_fold_movement_commands = [']z','[z','zj','zk']
let g:fastfold_minlines = 6
autocmd FileType c,cpp,sh,json setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
" javascript在vim-javascript
autocmd FileType sh let g:sh_fold_enabled = 7
autocmd TextChanged <silent> <Plug>(FastFoldUpdate)


" preservim/tagbar
" visibility of a tag is shown as { 'public' : '+', 'protected' : '#', 'private' : '-' }
nmap <silent> <F8> :TagbarToggle<CR>
imap <silent> <F8> <C-O>:TagbarToggle<CR><esc>
" 視窗水平分割在上方
let g:tagbar_position = 'top'
let g:tagbar_height = 13
" automatically close when you jump to a tag (implies moving cursor to Tagbar window while opening)
let g:tagbar_autoclose = 1
" show tag's data-type right of the tag
let g:tagbar_show_data_type = 1
" print the tag line number next to the tag in the tagbar (print to the left of the tag)
" let g:tagbar_show_tag_linenumbers = 2
" single click to navigate
let g:tagbar_singleclick = 1
let g:tagbar_autoshowtag = 1
" let g:tagbar_autopreview = 1
let g:tagbar_sort = 0
let g:no_status_line = 1
autocmd FileType vim let b:tagbar_ignore = 1


" zhimsel/vim-stay
" type ":CleanViewdir[!] [days]" to remove saved view sessions older than
" [days]. The bang version will remove w/o confirmation
set viewoptions=cursor,slash,unix,folds
" autocmd FileType vim set viewoptions+=folds


" pangloss/vim-javascript
augroup javascript_folding
    autocmd!
    autocmd FileType javascript setlocal foldmethod=syntax
augroup END


" luochen1990/rainbow
let g:rainbow_active = 1
" rainbow is conflicting with NERDTree
let g:rainbow_conf = {
	\'guifgs': ['yellow', '#00FFFF', 'lightmagenta', '#B8FBA9'],
	\'ctermfgs': ['yellow', 'lightcyan','lightblue', 'lightmagenta'],
	\'separately': {
		\ 'nerdtree': 0,
	\ },
\}


" easymotion/vim-easymotion
let g:EasyMotion_use_migemo = 1  " match multibyte Japanese character with alphabetical input
" avoid annoying syntax errors while jumping
autocmd User EasyMotionPromptBegin silent! CocDisable
autocmd User EasyMotionPromptEnd   silent! CocEnable


" preservim/nerdtree
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


" terryma/vim-expand-region
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


" Xuyuanp/nerdtree-git-plugin
let g:NERDTreeGitStatusUseNerdFonts = 1


" puremourning/vimspector
" use ":VimspectorInstall <adapter> <args...>" to install adapters/gadgets. Add '!' to not close the
" output window right after successful installation
" use ":VimspectorUpdate <adapter> <args...>" to update adapters/gadgets. Add '!' to not close the
" output window right after successful installation
syntax enable
filetype indent on
let g:vimspector_install_gadgets = ['debugpy', 'CodeLLDB']
" required by debugpy
let g:vimspector_base_dir=expand('~/.vim/plugged/vimspector') " do NOT end with forward slash

" HUMAN-like mappings
nmap <F5>         <Plug>VimspectorContinue
" nmap <leader><F5> <Plug>VimspectorLaunch
nmap <F3>                 <Plug>VimspectorReset
nmap <F4>                 <Plug>VimspectorRestart
nmap <F6>                 <Plug>VimspectorPause
nmap <F9>                 <Plug>VimspectorToggleBreakpoint
nmap <s-F9>               <Plug>VimspectorToggleConditionalBreakpoint
nmap <F8>                 <Plug>VimspectorAddFunctionBreakpoint
nmap <leader><F8>         <Plug>VimspectorRunToCursor
nmap <F10>                <Plug>VimspectorStepOver
nmap <F11>                <Plug>VimspectorStepInto
nmap <F12>                <Plug>VimspectorStepOut
nmap <LocalLeader><F12>   <Plug>VimspectorUpFrame
nmap <LocalLeader><s-F12> <Plug>VimspectorDownFrame

function s:setupVimspectorConfig()
	if filereadable(expand('.vimspector.json')) || !exists('g:vimspector_config')
		nmap <c-f5> <Plug>VimspectorLaunch
	else
		" echo '[vimspector] Using default config for ' . &ft
		nmap <c-f5> :call vimspector#LaunchWithConfigurations(g:vimspector_config)<cr>
	endif
endfunction

autocmd BufEnter * call s:setupVimspectorConfig()

" toggle breakpoints window
nmap <leader>db <Plug>VimspectorBreakpoints
" See https://github.com/puremourning/vimspector#breakpoints-window

" Evaluate part of program
nmap <leader>di <Plug>VimspectorBalloonEval
xmap <leader>di <Plug>VimspectorBalloonEval

" Save/load session file
let s:vimspectorSessionPrefix = '~/.vim/view/'
let s:vimspectorSessionFileName = substitute(expand('%:p'), '/', '+', 'g') . '.vimspector.session.json'
autocmd VimEnter * silent! execute("VimspectorLoadSession " . s:vimspectorSessionPrefix . s:vimspectorSessionFileName)
autocmd BufWritePost * silent execute("VimspectorMkSession " . s:vimspectorSessionPrefix . s:vimspectorSessionFileName)


" fzf
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

" Customize fzf colors to match your color scheme
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

" Enable per-command history
" - History files will be stored in the specified directory
" - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
"   'previous-history' instead of 'down' and 'up'.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Use fzf to find files.
" Receives an optional param to specify the folder to search
" Saves historical searches of *LS* and *LA* in file *ls*
command -complete=dir -nargs=? LS
	\ call fzf#run(fzf#wrap('ls', {'source': 'ls', 'dir': <q-args>}))
command -complete=dir -nargs=? LA
	\ call fzf#run(fzf#wrap('ls', {'source': 'ls -A', 'dir': <q-args>}))
nmap <silent><c-n> :LA<cr>
