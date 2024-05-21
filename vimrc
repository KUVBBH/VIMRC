" ======= 基础设置 =======

" 关闭兼容模式
set nocompatible

" 设置真颜色
set termguicolors

" 开启备份功能
set backup

" 备份保存位置
set backupdir=/storage/emulated/0/vim备份

" 设置leader键,主键
let mapleader=" "

" 文件编码
set enc=utf-8

" 代码高亮
syntax on

" 左侧显示行号
set number

" 相对行号显示
set relativenumber

" 突出显示当前行
set cursorline

" 突出显示当前列
" set cursorcolumn

" 文本自动换行
set wrap

" 显示正在键入的命令或者动作
set showcmd

" 菜单命令补全
set wildmenu

" 搜索高亮
set hlsearch

" 搜索结果即时显示
set incsearch

" 清除搜索高亮
exec "nohlsearch"

" 搜索区分大小写
set noignorecase

" 搜索智能区分大小写
set nosmartcase

" 分屏
" set splitright
" set splitbelow

" 制表符长度
set tabstop=4

" 自动缩进
set autoindent

" Tap和Backspace的行为
set softtabstop=4 

" 用空格代替制表符
set expandtab

" 自动缩进和宽度
set shiftwidth=4

" 自动Tab
set smarttab

" 智能缩进
set smartindent

" 智能缩进，联系上下文
set autoindent

" C,C++的智能缩进
set cindent

" 左侧显示更多内容
set signcolumn=yes

" 响应速度
set updatetime=100

" 开启插件
filetype plugin indent on

" 光标状态
let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)




" ======= 插件安装 =======
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()

" 状态栏
Plug 'vim-airline/vim-airline'

" 中文文档
Plug 'yianwillis/vimcdoc'

" 文件目录
Plug 'scrooloose/nerdtree'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()




" ======= 插件管理 =======

" ======= coc =======

" 颜色
hi Pmenu ctermfg=7 ctermbg=236
hi PmenuSel ctermfg=white ctermbg=32
hi CocFloating ctermfg=black ctermbg=240

" coc插件管理
let g:coc_global_extensions = [
    \ 'coc-vimlsp',
    \ 'coc-highlight',
    \ 'coc-jedi']


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 触发补全
inoremap <silent><expr> <c-o> coc#refresh()

" 同词高亮
autocmd CursorHold * silent call CocActionAsync('highlight')

" ======= 按键映射 =======

" ======= VIMRC =======

autocmd BufRead,BufNewFile vimrc inoremap <buffer> `= " =======  =======<Esc>6F=hi

" ======= gitcommit =======
autocmd Filetype gitcommit map <LEADER>d ggdd:0r !date +"\%Y-\%m-\%d \%H:\%M:\%S"<CR>

" ======= markdown =======

function! Markdown_map()
    inoremap <buffer> `> <Esc>/<++><CR>:nohlsearch<CR>c4l
    inoremap <buffer> `b **** <++><Esc>F*hi
    inoremap <buffer> `* ** <++><Esc>F*i
    inoremap <buffer> `` `` <++><Esc>F`i
    inoremap <buffer> `c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
    inoremap <buffer> `1 #<Space><Enter><++><Esc>kA
    inoremap <buffer> `2 ##<Space><Enter><++><Esc>kA
    inoremap <buffer> `3 ###<Space><Enter><++><Esc>kA
    inoremap <buffer> `4 ####<Space><Enter><++><Esc>kA
    inoremap <buffer> `5 #####<Space><Enter><++><Esc>kA
    inoremap <buffer> `6 ######<Space><Enter><++><Esc>kA
    inoremap <buffer> `p ![](<++>) <++><Esc>F[a
    inoremap <buffer> `j <img src="" width="auto<++>" height="auto<++>" alt="None"<++>><++><Esc>0f"a
    inoremap <buffer> `~ ~~~~ <++><Esc>F~hi
    inoremap <buffer> `- ---<Enter><Enter>
    inoremap <buffer> `= ===<Enter><Enter>
    inoremap <buffer> `l --------<Enter>
    inoremap <buffer> `i <++>
    inoremap <buffer> `a [](<++>)<++><Esc>F[a
    inoremap <buffer> `m <span id="move"></span><++><Esc>F"i
endfunction

" ======= Python =======

function! Python_map()
    inoremap <buffer> `> <Esc>/<++><CR>:nohlsearch<CR>c4l
    inoremap <buffer> `( ()<++><Esc>F(a
    inoremap <buffer> `[ []<++><Esc>F[a
    inoremap <buffer> `{ {}<++><Esc>F{a
    inoremap <buffer> `' ''<++><Esc>F'i
    inoremap <buffer> `" ""<++><Esc>F"i
    " Python run
    map <buffer> <LEADER>r :w<CR>:!clear && python %<CR>
    map <buffer> <LEADER>R :w<CR>:below terminal ++rows=10 python %<CR>
    map <buffer> <LEADER>b :w<CR>:!python -m black %<CR>
endfunction

" ======= others =======

autocmd Filetype markdown call Markdown_map()
autocmd Filetype python call Python_map()

" 按键映射,保存并退出
map <LEADER>q :wq<CR>

" 按键映射,保存
map <LEADER><Space> :w<CR>

" 按键映射,打开NERDTree
map <LEADER>n :NERDTreeToggle<CR>
