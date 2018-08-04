set nocompatible              " 去除VI一致性,必须要添加
filetype off                  " 必须要添加

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'

Plugin 'scrooloose/nerdtree'                                 "目录树插件

Plugin 'vim-syntastic/syntastic'                                 "syntastic语法检测

Plugin 'kien/ctrlp.vim'                                         "模糊查找 

Plugin 'scrooloose/nerdcommenter'                                "注释插件

Plugin 'fholgado/minibufexpl.vim'                                "buffer管理

" Plugin 'Valloric/YouCompleteMe'                                "自动补全插件

"Plugin 'junegunn/fzf'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line""""""""""""")"}"""}"")"""""""")"")"""



"*************************************************************************
"               目录树配置
"*************************************************************************
autocmd vimenter * NERDTree                 "启动vim时自动打开目录树
                                            "映射ctrl+n关闭目录树
map <C-n> :NERDTreeToggle<CR>                
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif   "关闭最后一个文件时候关闭目录树
let g:NERDTreeDirArrowExpandable = '▸'      "默认的箭头标志
let g:NERDTreeDirArrowCollapsible = '▾'

"*************************************************************************
"         syntastic语法检测配置
"*************************************************************************
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 1

"*************************************************************************
"         模糊查找
"*************************************************************************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux 习惯文件

"************************************************************************
"                           注释插件
"*************************************************************************
" Add spaces after comment delimiters by default
 let g:NERDSpaceDelims = 1

 " Use compact syntax for prettified multi-line comments
 let g:NERDCompactSexyComs = 1

 " Align line-wise comment delimiters flush left instead of following code indentation
 let g:NERDDefaultAlign = 'left'

 " Set a language to use its alternate delimiters by default
 let g:NERDAltDelims_java = 0

 " Add your own custom formats or override the defaults
 let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

 " Allow commenting and inverting empty lines (useful when commenting aregion)
 let g:NERDCommentEmptyLines = 1

 " Enable trimming of trailing whitespace when uncommenting
 let g:NERDTrimTrailingWhitespace = 0

 "*************************************************************************
 "                  buffer管理插件配置
 "*************************************************************************
 let g:miniBufExplMapWindowNavVim = 1

 "**************************************************************************
 "             自动补全
 "**************************************************************************
 " let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'       "配置全局路径
 " let g:ycm_confirm_extra_conf=0   "每次直接加载该文件，不提示是否要加载""

"*************************************************************************
"        elected            配色选择
"*************************************************************************
syntax enable
set background=dark
colorscheme freya
"colorscheme lucius


"括号补全
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap " ""<ESC>i
" inoremap <C-i> <ESC>

"***************************************************************************
"               其他设置
"***************************************************************************
"搜索忽略大小写
set ignorecase
"搜索逐字高亮
set hlsearch
set incsearch
"允许backspace和光标键越界
" set whichwrap+=<,>,h,l
"自动缩进和高亮当前行
set cursorline "高亮当前行
set number "行数
set autoindent "自动缩进
set smartindent "智能缩进
set cindent "C系列缩进
set softtabstop=4 "缩进长度
set shiftwidth=4 "缩进长度
set pastetoggle=<F9>
set clipboard=unnamed
set clipboard=unnamedplus

" "设置VIM状态栏 
 set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏) 
 " set winfixheight
 set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离
 "c编译设置
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -std=c++11 -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -std=c++11 -g -o %<"
	exec "!gdb ./%<"
endfunc

 "**************************************************************************
 "          按键映射
 "**************************************************************************
map <C-h> :bp<CR>
map <C-l> :bn<CR>
imap <C-o> <Esc>
map del <C-w>kd 
