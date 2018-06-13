call plug#begin('~/vimfiles/plugged') 
    Plug 'https://github.com/Shougo/neocomplete.vim.git'
    Plug 'https://github.com/scrooloose/nerdtree.git', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    Plug 'airblade/vim-gitgutter'
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'w0rp/ale'
    Plug 'https://github.com/tomasr/molokai'
    Plug 'https://github.com/davidhalter/jedi-vim', {'for': 'python'}
    Plug 'mhinz/vim-startify'
	Plug 'https://github.com/easymotion/vim-easymotion'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'https://github.com/vim-scripts/YankRing.vim'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'Konfekt/FastFold'
	Plug 'liuchengxu/eleline.vim'
call plug#end()


" gvim设置
if has('gui_running')
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    set showtabline=0 " 隐藏Tab栏
endif

" 设置vim默认的编码格式(utf-8)和可支持的编码格式(utf-8,GBK，其他的编码可以在后面增加)
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

syntax on " 启用语法高亮 

set nu! "显示行号
set relativenumber "显示相对行号   

set tabstop=4 " 一个tab键所跨过的空格数 
set softtabstop=4  " 输入tab键时实际占有的列数
set shiftwidth=4   " reindent 操作（<<和>>）时缩进的列数
set showmatch " 设置匹配模式，当属于一个左括号时会匹配相应的那个右括号

"------------Gvim中文菜单乱码解决方案-------------
" 设置文件编码格式
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1,gbk,gb18030,gk2312
set fileencoding=utf-8

"解决菜单乱码 删除菜单，再重新添加菜单，vim会按照之前设定的编码格式创建菜单栏
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"解决consle提示信息输出乱码
language messages zh_CN.utf-8

set nocompatible
set backspace=indent,eol,start 

set lazyredraw  " 解决某些类型的文件由于syntax导致vim反应过慢的问题
set ttyfast		" 平滑地变化
set cc=80       " 第80字符处显示分隔符

" 设置窗口大小
set lines=35 columns=118
" 设置字体
set guifont=Lucida\ Console:h12

" 自动重新读入
set autoread                " 当文件在外部被修改，自动更新该文件
" 自动保存
let autosave=2
autocmd CursorHold,CursorHoldI * update


" 备份与缓存
set nobackup
set nowb
set noswapfile
set writebackup             " 设置无备份文件

"搜索时高亮现实被找到的文本
set hlsearch
"搜索不区分大小写
set ignorecase
" 如果有一个大写字母，则切换到大小写敏感查找
set smartcase


" 状态栏
set laststatus=2  " 总是显示状态栏
set ruler "在编辑过程中，在右下角显示光标位置的状态行


" 退出插入模式时自动保存文件
au InsertLeave * write

" 侦测文件类型 
filetype on 

" 载入文件类型插件 
filetype plugin on 

  
" 高亮显示当前行
set cursorline
hi CursorLine cterm=NONE ctermbg=black ctermfg=green guibg=NONE guifg=NONE
" 高亮显示当前列
set cursorcolumn
hi CursorColumn cterm=NONE ctermbg=black ctermfg=none guibg=NONE guifg=NONE


" python和c语言规定一行不超过80个字符，当超过时用下划线标出
au BufRead,BufNewFile *.c,*.cpp,*.py 2match Underlined /.\%81v/


colorscheme molokai
"set mouse=a

" 在普通和可视模式下禁用方向键
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>


" 设置折叠方式(manual, indent, expr, syntax, diff, marker)
" zc 折叠
" zo 展开折叠
" [z 到当前打开的折叠的开始处
" ]z 到当前打开的折叠的末尾处
" zj 向下移动到下一个折叠的开始处
" zk 向下移动到前一个折叠的结束处
" zm 折叠所有
" zr 打开所有折叠
set foldmethod=syntax
setlocal foldlevel=1        " 设置折叠层数为10
" set foldclose=all           " 设置为自动关闭折叠                            
set foldlevelstart=99      "打开文件时不自动折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"使用空格键打开关闭折叠


" 重新映射j，k ，用于虚拟行之间的移动
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" 切换窗口的按键映射
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" 自动切换到当前目录
set autochdir
autocmd BufEnter * silent! !cd %:p:h



""""""""""""""""""""""""""""""
" NERDTree settings
""""""""""""""""""""""""""""""

nmap <silent> <F2> :NERDTreeToggle  <CR>
let g:NERDTreeWinPos="left"
let g:NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=2     " 设置当前目录为nerdtree的起始目录
let NERDChristmasTree=1     " 使得窗口有更好看的效果
let NERDTreeMouseMode=1     " 双击鼠标左键打开文件
let NERDTreeWinSize=25      " 设置窗口宽度为25
let NERDTreeQuitOnOpen=1    " 打开一个文件时nerdtree分栏自动关闭
let NERDTreeIgnore=['\.pyc','\~$','\.swp']

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "M",
    \ "Staged"    : "A",
    \ "Untracked" : "U",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "D",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : "~",
    \ "Unknown"   : "?"
    \ }


"""""""""""""""""""""""""""""""""""
" ale settings requests:vim8.0
"""""""""""""""""""""""""""""""""""
" ctrl+j jump to next wrap
" ctrl+k jump to previous wrap
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {
    \   'cpp': ['g++'],
    \   'c': ['gcc'],
    \   'python': ['flake8'], 
    \}
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)



"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : '~/vimfiles/.vimshell_hist',
    \ 'scheme' : '~/vimfiles/.gosh_completions',
	\ 'python' : '~/vimfiles/dict/python.dict',
	\ 'c' : '~/vimfiles/dict/c.dict',
    \ 'cpp' : '~/vimfiles/dict/cpp.dict',
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
"autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python3 setlocal omnifunc=jedi#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'


"""""""""""""""""""""""""""""""""
" jedi-vim
"""""""""""""""""""""""""""""""""
let g:neocomplete#enable_auto_select = 0
let g:jedi#popup_select_first=0
set completeopt=longest,menuone
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
let g:jedi#show_call_signatures = "0"   " 补全时不弹出函数的参数列表框


""""""""""""""""""""""""""""
" easymotion settings
""""""""""""""""""""""""""""
" \l 当前位置向右行内搜索
" \j 当前位置向下多行搜索
" \k 当前位置向上多行搜索
" \h 当前位置向左行内搜索
" \s 全文关键字搜索
map <Leader> <Plug>(easymotion-prefix)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>s <Plug>(easymotion-s)
let g:EasyMotion_smartcase = 1


""""""""""""""""""""""""""""
" vim-bookmarks settings
""""""""""""""""""""""""""""
" 添加/删除书签(当前行)	mm	:BookmarkToggle
" 添加/编辑/删除当前行注释书签	mi	:BookmarkAnnotate <TEXT>
" 跳转到当前 buffer 的下一个书签	mn	:BookmarkNext
" 跳转到当前 buffer 的前一个书签	mp	:BookmarkPrev
" 在 quickfix 窗口中列出所有书签(toggle)	ma	:BookmarkShowAll
" 清除当前 buffer 内的所有书签	mc	:BookmarkClear
" 清除所有 buffer 内的书签	mx	:BookmarkClearAll
" 保存书签到文件		:BookmarkSave <FILE_PATH>
" 从文件加载书签		:BookmarkLoad <FILE_PATH>
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 0
let g:bookmark_auto_close = 1
let g:bookmark_show_warning = 0
let g:bookmark_center = 1



""""""""""""""""""""""""""""
" vim-multiple-cursors settings
""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:bookmark_auto_save_file = '~/vimfiles'


"YankRing
"将yankring的历史文件夹移到~/.vim
let g:yankring_history_dir = '~/vimfiles/'
"修改历史文件名
let g:yankring_history_file = '.yankring_history'
"<leader>m选择上一个复制的文本
let g:yankring_replace_n_pkey = '<Leader>m'
"<leader>n选择下一个复制的文本
let g:yankring_replace_n_pkey = '<Leader>n'
"<leader>y显示yankring中的内容
nmap <Leader>y :YRShow<CR>
