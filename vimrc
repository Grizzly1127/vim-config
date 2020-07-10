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

" [python补全]
" Plug 'rkulla/pydiction'

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" [函数列表]
Plug 'vim-scripts/taglist.vim'

" [状态栏美化]
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" [快速注释]
Plug 'preservim/nerdcommenter'

" [代码补全YouCompleteMe]
" Plug 'ycm-core/YouCompleteMe'

" [代码补全deoplete]
" 安装依赖：
" pip3 install pynvim
" pip3 install neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" python补全
" 安装依赖：
" pip3 install jedi
Plug 'zchee/deoplete-jedi'
" c/c++补全
Plug 'Shougo/deoplete-clangx'

" 异步检查
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

" [pydiction]
filetype plugin on
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'
" let g:pydiction_menu_height = 6

" [YouCompleteMe]
let g:ycm_python_binary_path = '/usr/bin/python3'
" 寻找全局配置文件
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
" c++11
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libc++'
" 对全局namespace支持补全
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.','re![_a-zA-z0-9]'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

" 跳转快捷键
nnoremap <c-k> :YcmCompleter GoToDeclaration<CR>|
nnoremap <c-h> :YcmCompleter GoToDefinition<CR>|
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>|

" 停止提示是否载入本地ycm_extra_conf文件
let g:ycm_confirm_extra_conf = 0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files = 1
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 弹出列表时选择第1项的快捷键(默认为<TAB>和<Down>)
let g:ycm_key_list_select_completion = ['<Down>']
" 弹出列表时选择前1项的快捷键(默认为<S-TAB>和<UP>)
let g:ycm_key_list_previous_completion = ['<Up>']
" ycm默认需要按ctrl + space 来进行补全，可以在上面的花括号里面加入下面两行代码来直接进行补全[不需要按键]

"if has('python3')
"let g:loaded_youcompleteme = 1 " 判断如果是python3的话，就禁用ycmd。
"let g:jedi#force_py_version = 3
"let g:pymode_python = 'python3'
"endif

" [leaderF]
" Ctrl + p 打开文件搜索
let g:Lf_ShortcutF = '<c-p>'    
"\p 打开函数列表
noremap <Leader>p :LeaderfFunction<CR>

" [taglist]
let Tlist_Use_Right_Window = 1  " 让taglist窗口出现在Vim的右边
let Tlist_File_Fold_Auto_Close = 1 " 当同时显示多个文件中的tag时，设置为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来
let Tlist_Show_One_File = 1     " 只显示一个文件中的tag，默认为显示多个
let Tlist_Sort_Type ='name'     " Tag的排序规则，以名字排序。默认是以在文件中出现的顺序排序
let Tlist_GainFocus_On_ToggleOpen = 1 " Taglist窗口打开时，立刻切换为有焦点状态
let Tlist_Exit_OnlyWindow = 1   " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_WinWidth = 35         " 设置窗体宽度，可以根据自己喜好设置
let Tlist_Ctags_Cmd = '/usr/bin/ctags'  " 设置ctags的位置
map <silent> <F3> :Tlist<CR> 

" [airline]
set t_Co=256      "在windows中用xshell连接打开vim可以显示色彩
let g:airline#extensions#tabline#enabled = 1   " 是否打开tabline
"这个是安装字体后 必须设置此项"
let g:airline_powerline_fonts = 1
set laststatus=2  "永远显示状态栏
let g:airline_theme='bubblegum' "选择主题
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffer
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

" [deoplete]
set pyxversion=3
let g:deoplete#enable_at_startup=1

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

set tags=/home/lihuixiong/c++/tags
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

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

" [tablist标签页]
let mapleader=","
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
