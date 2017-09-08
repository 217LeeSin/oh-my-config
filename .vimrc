" vim-plug
call plug#begin('~/.vim/plugged') 
    Plug 'vim-airline/vim-airline' 
    Plug 'mattn/emmet-vim', {'for': 'html'} 
    Plug 'https://github.com/lilydjwg/fcitx.vim'
    Plug 'https://github.com/Shougo/neocomplete.vim.git'
    Plug 'https://github.com/scrooloose/nerdtree.git', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    Plug 'https://github.com/majutsushi/tagbar.git'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter'
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
    Plug 'w0rp/ale'
    Plug 'https://github.com/vim-scripts/a.vim.git', {'for':['c', 'cpp']}
    Plug 'https://github.com/tomasr/molokai'
    Plug 'https://github.com/davidhalter/jedi-vim', {'for': 'python'}
    Plug 'mhinz/vim-startify'
    Plug 'https://github.com/easymotion/vim-easymotion'
    Plug 'MattesGroeger/vim-bookmarks'
    Plug 'https://github.com/vim-scripts/YankRing.vim'
    Plug 'wakatime/vim-wakatime'
call plug#end()


" 设置vim默认的编码格式(utf-8)和可支持的编码格式(utf-8,GBK，其他的编码可以在后面增加)
set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

syntax on " 启用语法高亮 

set nu! "显示行号
set relativenumber "显示相对行号   

set tabstop=4 " 一个tab键所跨过的空格数 
set softtabstop=4  " 输入tab键时实际占有的列数
set shiftwidth=4   " reindent 操作（<<和>>）时缩进的列数

set showmatch " 设置匹配模式，当属于一个左括号时会匹配相应的那个右括号

set expandtab               " 使用空格来替换tab
set smarttab                " 开启新行时使用智能 tab 缩进

"set autoindent  " 启用自动对齐功能，把上一行的对齐格式应用到下一行
"set smartindent " 依据上面的格式，智能的选择对齐方式，对于类似C语言编写很有用处

set lazyredraw  " 解决某些类型的文件由于syntax导致vim反应过慢的问题
set ttyfast		" 平滑地变化
set cc=80       " 第80字符处显示分隔符


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


""""""""""""""""""""""""""""""""""""""""""""
"状态栏的设置，在不使用airline时显示的状态栏
""""""""""""""""""""""""""""""""""""""""""""
"显示文件名：总行数，总的字符数
"set statusline=[%F]%y%r%m[%{GitBranch()}]%*%=[Line:%l/%L,Column:%c][%p%%] 
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%] 

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\[HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" 设置insert模式和normal模式的状态栏颜色
"au InsertEnter * hi StatusLine cterm=none ctermbg=yellow ctermfg=black
"au InsertLeave * hi StatusLine cterm=none ctermfg=black ctermbg=green 

"""""""""""""""""""
"状态栏的设置 end
"""""""""""""""""""

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


"设置中文提示
language messages zh_CN.utf-8 
"设置中文帮助
set helplang=cn


" python和c语言规定一行不超过80个字符，当超过时用红色方块标出
" au BufRead,BufNewFile *.c,*.cpp,*.py match Error /\%80v.\%81v./
" python和c语言规定一行不超过80个字符，当超过时用下划线标出
au BufRead,BufNewFile *.c,*.cpp,*.py 2match Underlined /.\%81v/


colorscheme molokai
"set mouse=a

" 在普通和可视模式下禁用方向键
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" gvim设置
if has('gui_running')
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    set showtabline=0 " 隐藏Tab栏
    colorscheme molokai
    set guifont=Source\ Code\ Pro\ for\ Powerline\ Regular\ 11
    set mouse=a
endif



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


" vim <Tab>等字符显示设置，为了精确控制文本编辑
"set list
"set listchars=tab:➢\ ,trail:·,eol:⏎,precedes:«,extends:»



""""""""""""""""""""""""""""""
" Tagbar settings
""""""""""""""""""""""""""""""

nmap <silent> <F3> :TagbarToggle<CR>  
let g:tagbar_ctags_bin = 'ctags'  
let g:tagbar_width = 20


""""""""""""""""""""""""""""""
" NERDTree settings
""""""""""""""""""""""""""""""

nmap <silent> <F2> :NERDTreeToggle  <CR>
let g:NERDTreeWinPos="left"
let g:NERDTreeWinSize=20
let g:NERDTreeShowLineNumbers=1
let g:neocomplcache_enable_at_startup = 1 

let g:NERDTreeWinPos="left"
let g:NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=2     " 设置当前目录为nerdtree的起始目录
let NERDChristmasTree=1     " 使得窗口有更好看的效果
let NERDTreeMouseMode=1     " 双击鼠标左键打开文件
let NERDTreeWinSize=25      " 设置窗口宽度为25
let NERDTreeQuitOnOpen=1    " 打开一个文件时nerdtree分栏自动关闭

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
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


" 设置fcitx.vim 的延时,否则会有明显的卡顿
set ttimeoutlen=10



"""""""""""""""""""""""""""""""""""
" airline settings
"""""""""""""""""""""""""""""""""""
let g:airline_theme='powerlineish'  
" 使用powerline打过补丁的字体  
let g:airline_powerline_fonts=1  
if !exists('g:airline_symbols')  
    let g:airline_symbols={}  
endif  
" 关闭空白符检测  
let g:airline#extensions#whitespace#enabled=0

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


""""""""""""""""""""""
"快速编译和运行文件
""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!opera % "
    elseif &filetype == 'markdown'
        exec "!opera % "
    endif
endfunc


" 新文件
" 新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
" 定义函数SetTitle，自动插入文件头 
func SetTitle() 
	if &filetype == 'sh' 
		call setline(1,"\#!/bin/bash") 
		call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#! /usr/bin/ python3")
        call append(line("."),"# -*- coding: utf-8 -*-")
	    call append(line(".")+1, "")
    elseif &filetype == 'markdown'
        call setline(1,"# ".expand("%"))
	else 
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: ") 
		call append(line(".")+2, "	> Mail: ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, "	> Description: ") 
		call append(line(".")+5, " ************************************************************************/") 
		call append(line(".")+6, "")
	endif
	if expand("%:e") == 'cpp'
		call append(line(".")+7, "#include <iostream>")
		call append(line(".")+8, "using namespace std;")
		call append(line(".")+9, "")
		call append(line(".")+10,"int main(int argc, char *argv[])")
		call append(line(".")+11,"{")
		call append(line(".")+12,"")
		call append(line(".")+13,"    return 0;")
		call append(line(".")+14,"}")
		call append(line(".")+15,"")
	endif
	if &filetype == 'c'
		call append(line(".")+7, "#include <stdio.h>")
		call append(line(".")+8, "")		
		call append(line(".")+9,"int main(int argc, char *argv[])")
		call append(line(".")+10,"{")
		call append(line(".")+11,"")
		call append(line(".")+12,"    return 0;")
		call append(line(".")+13,"}")
		call append(line(".")+14,"")

	endif
	if expand("%:e") == 'h'
		call append(line(".")+7, "#ifndef _".toupper(expand("%:r"))."_H_")
		call append(line(".")+8, "#define _".toupper(expand("%:r"))."_H_")
		call append(line(".")+9, "#endif")
	endif
	if &filetype == 'java'
		call append(line(".")+7,"public class ".expand("%:r"))
		call append(line(".")+8,"")
	endif
	" 新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G






"--ctags setting--
" 按下F5重新生成tag文件，并更新taglist
"map <F4> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
"imap <F6> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>

" 打开c相关的文件时自动生成tags文件，BufReadPre 是打开已经存在的文件
"autocmd BufReadPre *.cpp,*.h,*.c exec ":!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>" 
"set tags=tags
"set tags+=./tags 





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
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions',
	\ 'python' : '~/.vim/dict/python.dict',
	\ 'c' : '~/.vim/dict/c.dict',
    \ 'cpp' : '~/.vim/dict/cpp.dict',
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
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
let g:jedi#show_call_signatures = "0"   " 补全时不弹出函数的参数列表框


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 0 或 s	查找本 C 符号(可以跳过注释)
" 1 或 g	查找本定义
" 2 或 d	查找本函数调用的函数
" 3 或 c	查找调用本函数的函数
" 4 或 t	查找本字符串
" 6 或 e	查找本 egrep 模式
" 7 或 f	查找本文件
" 8 或 i	查找包含本文件的文件
" find . –name "*.py" > cscope.files cscope生成python文件的索引
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>  
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>  
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>  
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>  
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>  
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>  
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR> 
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>  
nmap <C-@>w :w<CR>:!cscope -bqR<CR><CR>  


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
" wakatime settings
""""""""""""""""""""""""""""
let g:wakatime_PythonBinary = '/usr/bin/python'


""""""""""""""""""""""""""""
" wakatime settings
""""""""""""""""""""""""""""
let g:yankring_history_dir = $HOME.'/.vim/'
let g:yankring_history_file = '.yankring_history'
nnoremap <silent> <F4> :YRShow<CR>
