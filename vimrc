" ======= 基础设置 =======

set nocompatible       " 关闭兼容模式
set termguicolors      " 设置真颜色
let mapleader=" "      " 设置leader键,主键
set enc=utf-8          " 文件编码
syntax on              " 代码高亮
set number             " 左侧显示行号
set relativenumber     " 相对行号显示
set cursorline         " 突出显示当前行
set wrap               " 文本自动换行
set showcmd            " 显示正在键入的动作
set wildmenu           " 菜单命令补全
set hlsearch           " 搜索高亮
set incsearch          " 搜索结果即时显示
set noignorecase       " 搜索区分大小写
set nosmartcase        " 搜索智能区分大小写
set tabstop=4          " 制表符长度
set autoindent         " 自动缩进
set softtabstop=4      " Tap
set expandtab          " 用空格代替制表符
set shiftwidth=4       " 自动缩进和宽度
set smarttab           " 自动Tab
set smartindent        " 智能缩进
set autoindent         " 智能缩进，联系上下文
set cindent            " C,C++的智能缩进
set signcolumn=yes     " 左侧显示更多内容
set updatetime=100     " 响应速度

" 开启插件
filetype plugin indent on

" 光标状态
let &t_SI.="\e[6 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

" set backup             " 开启备份功能
" set backupdir=~/.备份  " 备份保存位置
" set cursorcolumn       " 突出显示当前列
" exec "nohlsearch"      " 清除搜索高亮




" ======= undofile文件修改历史记录 =======

if has("persistent_undo")
    let target_path = expand('~/.undodir')
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif
    let &undodir=target_path
    set undofile
endif




" ======= 插件安装 =======
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()

" 状态栏
Plug 'vim-airline/vim-airline'

" 中文文档
Plug 'yianwillis/vimcdoc'

" 文件目录
Plug 'scrooloose/nerdtree'

" undotree
Plug 'mbbill/undotree'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" MarkDown预览
Plug 'instant-markdown/vim-instant-markdown', {'for': ['markdown'], 'do': 'yarn install'} 

" 制表插件
Plug 'dhruvasagar/vim-table-mode',{'for': ['markdown']}

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

" ======= vim-instant-markdown =======

" 是否使用慢速模式，默认为 0（关闭），设为 1 则开启。
let g:instant_markdown_slow = 0

" 是否在 Vim 启动时自动启动 Markdown 实时预览，设为 0（不自动启动），设为 1 则自动启动。
let g:instant_markdown_autostart = 0

" 是否启用 MathJax 支持 LaTeX 公式渲染，设为 1（启用）。
let g:instant_markdown_mathjax = 1

"是否启用 Mermaid.js 支持流程图和序列图，设为 1（启用）。
let g:instant_markdown_mermaid = 0

" 是否启用预览窗口跟随编辑窗口自动滚动，设为 0（关闭）。
let g:instant_markdown_autoscroll = 1





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
    " Markdown run
    map <LEADER>r :InstantMarkdownPreview<CR>

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
    " black
    map <LEADER>b :w<CR>:!python -m black %<CR>

" ======= others =======

autocmd Filetype markdown call Markdown_map()
autocmd Filetype python call Python_map()

" 按键映射,保存并退出
map <LEADER>q :wq<CR>

" 按键映射,保存
map <LEADER><Space> :w<CR>

" 按键映射,打开NERDTree
map <LEADER>n :NERDTreeToggle<CR>

" 按键映射,打开UndotreeToggle
map <LEADER>u :UndotreeToggle<CR>
