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
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rkulla/pydiction'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'vim-scripts/taglist.vim'

Plug 'ycm-core/YouCompleteMe'

" Initialize plugin system
call plug#end()

" -------------------------------------------------------------------
" |                          plugin config                          |
" -------------------------------------------------------------------
" nerdtree
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

" pydiction
filetype plugin on
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'
" let g:pydiction_menu_height = 6

" YouCompleteMe
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

" leaderF
" Ctrl + p 打开文件搜索
let g:Lf_ShortcutF = '<c-p>'    
"\p 打开函数列表
noremap <Leader>p :LeaderfFunction<CR>

" taglist
let Tlist_Use_Right_Window = 1  " 让taglist窗口出现在Vim的右边
let Tlist_File_Fold_Auto_Close = 1 " 当同时显示多个文件中的tag时，设置为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来
let Tlist_Show_One_File = 1     " 只显示一个文件中的tag，默认为显示多个
let Tlist_Sort_Type ='name'     " Tag的排序规则，以名字排序。默认是以在文件中出现的顺序排序
let Tlist_GainFocus_On_ToggleOpen = 1 " Taglist窗口打开时，立刻切换为有焦点状态
let Tlist_Exit_OnlyWindow = 1   " 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_WinWidth = 35         " 设置窗体宽度，可以根据自己喜好设置
let Tlist_Ctags_Cmd = '/usr/bin/ctags'  " 设置ctags的位置
map <silent> <F3> :Tlist<CR> 


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
