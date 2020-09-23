" -------------------------------------------------------------------
" |                          base config                            |
" -------------------------------------------------------------------
set nu				" 显示行号
syntax on			" 语法高亮 
set showcmd     	" 输入的命令显示出来，看的清楚些
set cursorline		" 当前行显示 
set autoindent      " 自动缩进
set cindent
set tabstop=4		" tab缩进4个空格
set softtabstop=4
set shiftwidth=4
set expandtab
set incsearch		" 开启实时搜索功能
set ignorecase		" 搜索时大小写不敏感
set hlsearch		" 高亮显示搜索结果
set foldenable      " 允许折叠 
set foldmethod=manual   " 手动折叠
set nocompatible    " 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set clipboard+=unnamed  " 共享剪贴板
set autowrite       " 自动保存
set confirm         " 在处理未保存或只读文件的时候，弹出确认
set ruler           " 打开状态栏标尺
set langmenu=zh_CN.UTF-8    " 语言设置
set helplang=cn
set laststatus=2    " 总是显示状态行
set linespace=0     " 字符间插入的像素行数目
set backspace=2     " 使回格键（backspace）正常处理indent, eol, start等
set showmatch       " 高亮显示匹配的括号
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
set completeopt=menu
" 相关颜色替换
hi Search term=standout cterm=bold ctermfg=7 ctermbg=1
hi SpellBad term=reverse ctermfg=15 ctermbg=9 guifg=White guibg=Red
let mapleader=','

" -------------------------------------------------------------------
" |                         plugin install                          |
" -------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" [目录树]
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" [函数列表]
Plug 'preservim/tagbar'

" [状态栏美化]
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" [快速注释]
Plug 'preservim/nerdcommenter'

" [gocode]
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

" [代码补全]
Plug 'Valloric/YouCompleteMe'


" [异步检查]
" Plug 'w0rp/ale'
Plug 'dense-analysis/ale'


" Initialize plugin system
call plug#end()

" -------------------------------------------------------------------
" |                          plugin config                          |
" -------------------------------------------------------------------
" [nerdtree]
autocmd vimenter * NERDTree  "自动开启Nerdtree
" 关闭所有文本窗口时自动退出vim,否则需要两次退出才可
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
let NERDTreeShowHidden=1    " 是否显示隐藏文件
let NERDTreeIgnore=['\.pyc','\~$','\.swp']  " 忽略文件的显示

" 设置NerdTree 按f2打开或关闭NERDTree
map <F2> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

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

" [tagbar]
" 设置tagbar使用的ctags的插件,必须要设置对
let g:tagbar_ctags_bin='/usr/bin/ctags'
" 设置tagbar的窗口宽度
let g:tagbar_width=35
" 设置tagbar的窗口显示的位置,默认右边
let g:tagbar_right=1
" 打开文件自动 打开tagbar
" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
" 这是tagbar一打开，光标即在tagbar页面内，默认在vim打开的文件内
let g:tagbar_autofocus = 1
"设置标签不排序，默认排序
let g:tagbar_sort = 0
" 映射tagbar的快捷键
nnoremap <silent> <F3> :TagbarToggle<CR>
" nmap <silent> <F3> :TagbarToggle<CR>

" [airline]
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
"这个是安装字体后 必须设置此项"
let g:airline_powerline_fonts = 1
set laststatus=2  "永远显示状态栏
let g:airline_theme='bubblegum' "选择主题
let g:airline#extensions#tabline#enabled=1    "Smarter tab line:显示窗口tab和buffer
"let g:airline#extensions#tabline#left_sep = ' '  "separater
"let g:airline#extensions#tabline#left_alt_sep = '|'  "separater
"let g:airline#extensions#tabline#formatter = 'default'  "formater
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'

" [nerdcommenter]
let g:NERDSpaceDelims = 1   " 注释中间加一个空格
let g:NERDDefaultAlign = 'left' " 多行注释向左对齐


" [YouCompleteMe]
let g:ycm_confirm_extra_conf=0      " 关闭加载.ycm_extra_conf.py提示
let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
let g:ycm_collect_identifiers_from_tags_files=1                 " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开
let g:ycm_min_num_of_chars_for_completion=2                     " 从第2个键入字符就开始罗列匹配项
" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
if !empty(glob("~/..vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/..vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
endif

"mapping
nmap <leader>gd :YcmDiags<CR>
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>           " 跳转到申明处
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>            " 跳转到定义处
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

" 直接触发自动补全
let g:ycm_key_invoke_completion = '<C-Space>'
" 黑名单,不启用
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'gitcommit' : 1,
      \}

" [ale]
" 始终开启标志列
let g:ale_sign_column_always = 1
" 不需要高亮行
let g:ale_set_highlights = 0
" 自定义error和warning图标
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" 显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" 普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
" <Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
" <Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
" 设置状态栏显示的内容
let g:airline#extensions#ale#enabled = 1

" 启动检查方式
let g:ale_lint_on_text_changed = 'normal' " 代码更改后启动检查
let g:ale_lint_on_insert_leave = 1        " 退出插入模式即检查

" 设置c/c++的检查选项
" C 语言配置检查参数
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_c_clang_options = '-Wall -O2 -std=c99'
let g:ale_c_cppcheck_options = '--enable=all'

" C++ 配置检查参数
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11'
let g:ale_cpp_clang_options = '-Wall -O2 -std=c++11'
let g:ale_cpp_cppcheck_options = '--enable=all'

" 使用cppcheck对c和c++进行语法检查，对python使用pylint进行语法检查
" 需要额外安装cppcheck,clang,gcc,pylint
let g:ale_linters = {
\   'cpp': ['cppcheck','clang','gcc'],
\   'c': ['cppcheck','clang','gcc'],
\   'python': ['pylint'],
\}

" -------------------------------------------------------------------
" |                          other config                           |
" -------------------------------------------------------------------
" debug
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'sh'
        :!time zsh %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc

" [cscope]
cs add /home/lihuixiong/c++/cscope.out
" 按ctrl+\，松开后按相应的键（s/g/c/d等）执行cscope命令

" 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" 查找函数、宏、枚举等定义的位置，类似ctags所提供的功能
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" 查找调用本函数的函数
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" 查找本函数调用的函数
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" 查找指定的字符串
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" 查找egrep模式，相当于egrep功能，但查找速度快多了
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" 查找并打开文件，类似vim的find功能
nmap <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>

" [标签页]
noremap <silent><leader>t :tabnew<cr>
noremap <silent><leader>g :tabclose<cr>
noremap <silent><leader>1 :tabn 1<cr>
noremap <silent><leader>2 :tabn 2<cr>
noremap <silent><leader>3 :tabn 3<cr>
noremap <silent><leader>4 :tabn 4<cr>
noremap <silent><leader>5 :tabn 5<cr>
noremap <silent><leader>6 :tabn 6<cr>
noremap <silent><leader>7 :tabn 7<cr>
noremap <silent><leader>8 :tabn 8<cr>
noremap <silent><leader>9 :tabn 9<cr>
noremap <silent><leader>0 :tabn 10<cr>
