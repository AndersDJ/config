
"    __  __       _   ___     ___
"   |  \/  |_   _| \ | \ \   / (_)_ __ ___  _ __ ___
"   | |\/| | | | |  \| |\ \ / /| | '_ ` _ \| '__/ __|
"   | |  | | |_| | |\  | \ V / | | | | | | | | | (__
"   |_|  |_|\__, |_| \_|  \_/  |_|_| |_| |_|_|  \___|
"           |___/

set shell=bash

let mapleader=" "

syntax on



set number
set relativenumber
set cursorline


set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set mouse=a
set encoding=utf-8


let &t_ut=''
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent


set list
set listchars=tab:\|\ ,trail:▫

" 执行一些指令后 有一定时间延迟
set ttimeoutlen=0
set notimeout

set viewoptions=cursor,folds,slash,unix
set wrap

set tw=0
set indentexpr=
" set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set foldenable    " 折叠
set formatoptions-=tc

" 新文件放右边 下边
set splitright
set splitbelow

" 在底部命令行不显示当前模式
set noshowmode


" 在状态栏显示目前所执行的指令，未完成的指令片段亦会显示出来
set showcmd

" 输入指令行 模糊匹配
set wildmenu


set shortmess+=c

set inccommand=split



set completeopt=preview,longest,noinsert,menuone,noselect


set ttyfast "should make scrolling faster


set lazyredraw "same as above

" 出错时，发出视觉提示，通常是屏幕闪烁。
set visualbell



set laststatus=2
set autochdir

set scrolloff=7


silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo

set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.

if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif

set colorcolumn=80 " 80个字节处 有个红线
set updatetime=1000
set virtualedit=block

" 上次写到哪 再打开还在哪
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif





" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'
augroup TermHandling
    autocmd!
    " Turn off line numbers, listchars, auto enter insert mode and map esc to
    " exit insert mode
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber
                \ | startinsert
    autocmd FileType fzf call LayoutTerm(0.6, 'horizontal')
augroup END

function! LayoutTerm(size, orientation) abort
    let timeout = 16.0
    let animation_total = 120.0
    let timer = {
                \ 'size': a:size,
                \ 'step': 1,
                \ 'steps': animation_total / timeout
                \}

    if a:orientation == 'horizontal'
        resize 1
        function! timer.f(timer)
            execute 'resize ' . string(&lines * self.size * (self.step / self.steps))
            let self.step += 1
        endfunction
    else
        vertical resize 1
        function! timer.f(timer)
            execute 'vertical resize ' . string(&columns * self.size * (self.step / self.steps))
            let self.step += 1
        endfunction
    endif
    call timer_start(float2nr(timeout), timer.f, {'repeat': float2nr(timer.steps)})
endfunction

" Open autoclosing terminal, with optional size and orientation
function! OpenTerm(cmd, ...) abort
    let orientation = get(a:, 2, 'horizontal')
    if orientation == 'horizontal'
        new | wincmd J
    else
        vnew | wincmd L
    endif
    call LayoutTerm(get(a:, 1, 0.5), orientation)
    call termopen(a:cmd, {'on_exit': {j,c,e -> execute('if c == 0 | close | endif')}})
endfunction
" }}}
" vim:fdm=marker





" ===
" === Basic Mappings
" ===

noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
noremap <LEADER>rG :e ~/Documents/GoProject/src


map S :w<CR>
" map S <nop>

map s <nop>
map Q :q!<CR>
map <C-q> :qa<CR>
map R :source $MYVIMRC<CR>
map ; :

" 调整分屏长宽 其他分屏也可以
map <UP> :res +5<CR>
map <down> :res -5 <CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>




" Duplicate words
" map <LEADER>fd /\(\<\w\+\>\)\_s*\1

" 光标操作
noremap <silent> n nzz
noremap <silent> N Nzz
" noremap k kzz
" noremap j jzz
noremap <silent> K 5kzz
noremap <silent> J 5jzz
noremap <C-k> 5kzz
" noremap <C-j> 5jzz
noremap <LEADER><CR> :nohlsearch<CR>
noremap <silent> H 0
noremap <silent> L $
noremap W 5w
noremap B 5b

" Check spell error
map <LEADER>sp :set spell!<CR> " check spell
noremap <C-x> ea<C-x>s
inoremap <C-x> <ESC>ea<C-x>s

" 锚点
map <LEADER><LEADER> <ESC>/<++><CR>:nohlsearch<CR>c4i


" make Y to copy till the end of the line
nnoremap Y v$y

" Copy to system clipboard
vnoremap Y "+y


" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Space to Tab
"nnoremap <LEADER>tt :%s/    /\t/g
"vnoremap <LEADER>tt :s/    /\t/g


" Folding
noremap <silent> <LEADER>o za


" Open up lazygit
noremap \g :term lazygit<CR>
noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>



" Open up pudb
noremap <c-d> :tab sp<CR>:term python3 -m pudb %<CR>
"noremap <f5> :tab sp<CR>:term python3 -m pudb %<CR>



" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
" 切换分屏
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l



" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Place the two screens up and down
noremap su <C-w>t<C-w>K
" Place the two screens side by side
noremap si <C-w>t<C-w>H



" Rotate screens
noremap sru <C-w>b<C-w>K
noremap sru <C-w>b<C-w>H


" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>



" ===
" === Command Mode Cursor Movement
" ===
" cnoremap <C-a> <Home>
" cnoremap <C-e> <End>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>
" cnoremap <C-b> <Left>
" cnoremap <C-f> <Right>
" cnoremap <M-b> <S-Left>
" cnoremap <M-w> <S-Right>


" 标签页
" 新建标签页
noremap tn :tabe<CR>
" 左右切换标签页
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" Move the tabs with tmn and tmi
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd!
  autocmd VimEnter * PlugInstall

endif

func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc






call plug#begin('~/.config/nvim/plugged')
"AirLine:
Plug 'vim-airline/vim-airline'

"Golang:
Plug 'fatih/vim-go', {'for':['go', 'vim-plug'], 'do': ':GoInstallBinaries' }
"CocNVim:
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"File Search:
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"File Browser:
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mkitt/tabline.vim'
Plug 'ryanoasis/vim-devicons'
"Color:
Plug 'morhetz/gruvbox'
Plug 'connorholyday/vim-snazzy'
Plug 'vim-scripts/Visual-Studio'
Plug 'kristijanhusak/vim-hybrid-material'
" VimStartify:
" vim开始界面
Plug 'mhinz/vim-startify'

"NERDCommenter:
" 批量注释
Plug 'preservim/nerdcommenter'

"VimSurround:
" 替换括号
Plug 'tpope/vim-surround'
" VimSignature:
" mark
Plug 'kshenoy/vim-signature'

" Plug 'dgryski/vim-godef'

"AutoPairs:
"自动括号补全
Plug 'jiangmiao/auto-pairs'

"Ranger:

Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'

"Emmet:   html editor
Plug 'mattn/emmet-vim'

"Smartim: 自动切换输入法
Plug 'ybian/smartim'










call plug#end()


"===============================================================================
"
"



"
"
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


"===============================================================================




"NERDCommenter:
" 批量注释
" 在默认情况下添加注释分隔后的空间
let g:NERDSpaceDelims = 1

" 对紧凑的多行注释使用紧凑语法，
let g:NERDCompactSexyComs = 1

" 将行注释注释定界符向左对齐，而不是以下代码缩进
let g:NERDDefaultAlign = 'left'

" 设置一种语言，默认情况下使用其替代定界符
let g:NERDAltDelims_java = 1

" 加入自己的自定义格式或覆盖默认
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" 允许注释和倒空行（在注释区域时很有用)
let g:NERDCommentEmptyLines = 1

" 取消注释时启用尾随空白的修剪，
let g:NERDTrimTrailingWhitespace = 1

" 启用NERDCommenterToggle以检查所有选定的行是否带注释，或者
let g:NERDToggleCheckAllLines = 1


" [count]<leader>cc |NERDCommenterComment|
" 
" Comment out the current line or text selected in visual mode.
" 
" [count]<leader>cn |NERDCommenterNested|
" 
" Same as cc but forces nesting.
" 
" [count]<leader>c<space> |NERDCommenterToggle|
" 
" Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
" 
" [count]<leader>cm |NERDCommenterMinimal|
" 
" Comments the given lines using only one set of multipart delimiters.
" 
" [count]<leader>ci |NERDCommenterInvert|




"VimSurround:
" https://github.com/tpope/vim-surround
" It's easiest to explain with examples. Press cs"' inside
"
" "Hello world!"
" to change it to
"
" 'Hello world!'
" Now press cs'<q> to change it to
"
" <q>Hello world!</q>
" To go full circle, press cst" to get
"
" "Hello world!"
" To remove the delimiters entirely, press ds".
"
" Hello world!
" Now with the cursor on "Hello", press ysiw] (iw is a text object).
"
" [Hello] world!
" Let's make that braces and add some space (use } instead of { for no space): cs]{
"
" { Hello } world!
" Now wrap the entire line in parentheses with yssb or yss).
"
" ({ Hello } world!)
" Revert to the original text: ds{ds)
"
" Hello world!
" Emphasize hello: ysiw<em>
"
" <em>Hello</em> world!
" Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by S<p class="important">.
"
" <p class="important">
"   <em>Hello</em> world!
" </p>



" Golang:
set updatetime=100
" let g:go_auto_sameids = 1
let g:go_def_mapping_enabled = 0
let g:go_fmt_experimental = 1
let g:go_fmt_command = "goimports"
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
" let g:go_doc_popup_window = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_deadline = "5s"

let g:go_gopls_enabled = 1
let g:go_referrers_mode = 'gopls'

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <LEADER>g :GoSameIds<CR>
" autocmd FileType go noremap K 5kzz
autocmd FileType go noremap <LEADER>u :GoDoc<CR>
" git 地址: https://github.com/fatih/vim-go
" 1. ctrl + x + o // 全能补全
" 2. ctrl + n / p //选择下一个或者上一个
" 3. ctrl + ] // 跳转到引用函数/方法/结构体..定义
" 4. ctrl + o // 跳转回来
" 5. ctrl + i // 向前跳
" 6. :GoFmt // 格式化代码
" 7. :ReName  // 代码重构，Enter后光标指向的单词即可重命名
" 8. :GoImports // 自动导包
" 9. :w //保存后代码自动格式化
" 10.:GoRun // 运行代码

        " / "golang":{
        " /     "command":"/Users/diaojian/Documents/GoProject/bin/gopls",
        " /     "rootPatterns":[
        " /         "go.mod",
        " /         ".vim/",
        " /         ".git/",
        " /         ".hg/"
        " /     ],
        " /     "filetypes":[
        " /         "go"
        " /     ],
        " /     "initializationOptions":{
        " /         "gocodeCompletionEnabled": true,
		" /         "diagnosticsEnabled": true,
		" /         "lintTool": "golint",
        " /         "usePlaceholders":true
        " /     }
        " / },





" VimSignature:
" mx           Toggle mark 'x' and display it in the leftmost column
" dmx          Remove mark 'x' where x is a-zA-Z
"
" m,           Place the next available mark
" m.           If no mark on line, place the next available mark. Otherwise, remove (first) existing mark.
" m-           Delete all marks from the current line
" m<Space>     Delete all marks from the current buffer
" ]`           Jump to next mark
" [`           Jump to prev mark
" ]'           Jump to start of next line containing a mark
" ['           Jump to start of prev line containing a mark
" `]           Jump by alphabetical order to next mark
" `[           Jump by alphabetical order to prev mark
" ']           Jump by alphabetical order to start of next line having a mark
" '[           Jump by alphabetical order to start of prev line having a mark
" m/           Open location list and display marks from current buffer
"
" m[0-9]       Toggle the corresponding marker !@#$%^&*()
" m<S-[0-9]>   Remove all markers of the same type
" ]-           Jump to next line having a marker of the same type
" [-           Jump to prev line having a marker of the same type
" ]=           Jump to next line having a marker of any type
" [=           Jump to prev line having a marker of any type
" m?           Open location list and display markers from current buffer
" m<BS>        Remove all markers



"===============================================================================
"NERDTree:
map <LEADER>nt :NERDTree<CR>




"===============================================================================
"Ranger:
let g:ranger_map_keys = 0
let g:NERDTreeHijackNetrw = 0 " add this line if you use NERDTree
let g:ranger_replace_netrw = 1 " open ranger when vim open a directory

map <LEADER>f :RangerNewTab<CR>





"===============================================================================
"Emmet:
let g:user_emmet_install_global = 0
let g:user_emmet_mode='inv'  "enable all functions, which is equal to
autocmd FileType html,css EmmetInstall

"===============================================================================
"Smartim:
let g:smartim_default = 'com.apple.keylayout.ABC'
function! Multiple_cursors_before()
    let g:smartim_disable = 1
endfunction
function! Multiple_cursors_after()
    unlet g:smartim_disable
endfunction









" ==============================================================================

" ===
" === Auto load for first time uses
" ===




color snazzy

"color visualstudio




