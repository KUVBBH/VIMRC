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

" 配色
" https://github.com/tomasr/molokai
colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1


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

" 按键提示
Plug 'liuchengxu/vim-which-key'

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
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 触发补全
inoremap <silent><expr> <c-o> coc#refresh()

" 同词高亮
autocmd CursorHold * silent call CocActionAsync('highlight')

" ======= vim-instant-markdown =======

" 是否使用慢速模式，默认为 0（关闭）
let g:instant_markdown_slow = 0

" 自动开启Markdown 实时预览
let g:instant_markdown_autostart = 0

" 支持 LaTeX 公式渲染
let g:instant_markdown_mathjax = 0

" 启用 Mermaid.js 支持流程图和序列图
let g:instant_markdown_mermaid = 0

" 预览窗口跟随编辑窗口自动滚动
let g:instant_markdown_autoscroll = 1

" ======= vim-which-key =======

" https://vimcdoc.sourceforge.net/doc/usr_02.html#usr_02.txt
" Vim 9.0

let g:help_0 = {
    \ 'name' : '基本操作' ,
    \ 'A1       i,I' : '前插入,行前插入' ,
    \ 'A2       a,A' : '后插入,行尾插入' ,
    \ 'A3     <Esc>' : '普通模式' ,
    \ 'A4      hjkl' : '左下上右' ,
    \ 'A5         x' : '删除当前光标下字符' ,
    \ 'A6        dd' : '删除一行' ,
    \ 'A7       u,U' : '撤销,行撤销' ,
    \ 'A8    CTRL-R' : '撤销一个命令' ,
    \ 'A9       o,O' : '光标下方,上方建立一个新的空行' ,
    \ 'B1     :w,ZZ' : '保存文件并退出' ,
    \ 'B2       :q!' : '放弃修改' ,
    \ 'B3        :q' : '退出' ,
    \ 'B4       :e!' : '重新装载原来的文件' ,
    \ }

" https://vimcdoc.sourceforge.net/doc/usr_03.html#usr_03.txt
" Vim 9.0
let g:help_1 = {
    \ 'name' : '词移动,行移动,查找,标记,标记' ,
    \ 'A1              w,b' : '移动到下一个,上一个词的词头' ,
    \ 'A2             e,ge' : '移动到下一个,上一个词的词尾' ,
    \ 'A3         W,B,E,gE' : '字串间移动' ,
    \ 'A4                $' : '移动到行尾' ,
    \ 'A5                0' : '移动到行首' ,
    \ 'A6                ^' : '移动到行首非空字符' ,
    \ 'A7               2$' : '移动到下一行的行尾' ,
    \ 'A8            fx,Fx' : '向前,向后查找并移动到本行中的字符x' ,
    \ 'A9              3fx' : '执行 3 次fx操作' ,
    \ 'B1            tx,Tx' : '向前,向后查找并移动到x的前一个字符' ,
    \ 'B2                %' : '括号间跳转' ,
    \ 'B3             gg,G' : '移动到文件开头,结尾' ,
    \ 'B4         15gg,15G' : '跳转到第15行' ,
    \ 'B5              50%' : '跳转到第(总行数*50%)行' ,
    \ 'B6            H,M,L' : '跳转到当前屏幕的行首,行中,行尾' ,
    \ 'B7           CTRL-G' : '光标定位' ,
    \ 'B8    CTRL-U,CTRL-D' : '半屏滚动' ,
    \ 'B9    CTRL-E,CTRL-Y' : '行滚动' ,
    \ 'C1    CTRL-F,CTRL-B' : '全屏滚动' ,
    \ 'C2         zt,zz,zb' : '当前行置于屏幕顶部,中部,底部' ,
    \ 'C3            /x,?x' : '正向,反向查找x' ,
    \ 'C4              n,N' : '正向,反向在查找结果之间跳转' ,
    \ 'C5    /<Up>,/<Down>' : '历史查找记录' ,
    \ 'C6           /\<X\>' : '\<,\>,匹配单词开头,结尾' ,
    \ 'C7          /^x,/x$' : '仅在行首,行尾匹配x' ,
    \ 'C8             /a.b' : '匹配字符a+一个任意字符+字符b' ,
    \ "C9            ``,''" : '来回跳转' ,
    \ 'D1   CTRL-O ,CTRL-I' : '跳转到较老,较新的位置' ,
    \ 'D2           :jumps' : '可用跳转列表' ,
    \ 'D3               ma' : '标记当前位置并且命名为标记a' ,
    \ 'D4               `a' : '跳转到a标记' ,
    \ 'D5           :marks' : '所有标记列表' ,
    \ "D6               `'" : '跳转前的光标位置' ,
    \ 'D7         "`,[`,]`' : '最后编辑,修改开始,修改结束的位置' ,
    \ }
" https://vimcdoc.sourceforge.net/doc/usr_04.html#usr_04.txt
" Vim 9.0
let g:help_2 = {
    \ 'name' : '删除,修改,复制,粘贴,可视模式' ,
    \ 'A1       x,x' : '删除光标下,光标前字符' ,
    \ 'A2         D' : '从当前位置删除到行尾 ("d$" 的缩写)' ,
    \ 'A3        dw' : '从当前位置删除到下一个单词开头' ,
    \ 'A4        db' : '从当前位置删除到上一个单词开头' ,
    \ 'A5       diw' : '删除光标上的单词 (不包括空白字符)' ,
    \ 'A6       daw' : '删除光标上的单词 (包括空白字符)' ,
    \ 'B7        dd' : '删除一整行' ,
    \ 'A9    dG,dgg' : '删除到文件末,头' ,
    \ 'A9         ~' : '修改光标下字符的大小写' ,
    \ 'B1        cw' : '执行dw操作并且进入编辑模式' ,
    \ 'B2        cc' : '执行dd操作并且进入编辑模' ,
    \ 'B3         C' : '执行D操作并且进入编辑模' ,
    \ 'B4         s' : '修改当前字符' ,
    \ 'B5         S' : '修改当前行' ,
    \ 'B6       r,R' : '替换光标下字符,替换模式' ,
    \ 'B7       3rx' : '执行 3 次r操作,光标下向右3个字符替换成x' ,
    \ 'B8         .' : '重复前一个修改操作' ,
    \ 'B9         v' : '可视模式' ,
    \ 'C1         V' : '可视行模式' ,
    \ 'C2    CTRL-V' : '可视块模式' ,
    \ 'C3       o,O' : '可视块模下光标对角,行首尾移动' ,
    \ 'C4       p,P' : '光标后,前粘贴' ,
    \ 'C5        xp' : '交换两个字符' ,
    \ 'C6        3p' : '执行 3 次p操作' ,
    \ 'C7      yy,Y' : '复制当前行' ,
    \ 'C8        yw' : '复制当前词' ,
    \ 'C9       y2w' : '复制当前光标下两个词' ,
    \ 'D1        y$' : '复制到行尾' ,
    \ 'D2      "1yy' : '复制当前行到1号粘贴板' ,
    \ 'D3       "1p' : '粘贴1号粘贴板的内容' ,
    \ 'D4      :reg' : '查看粘贴板' ,
    \ }
" https://vimcdoc.sourceforge.net/doc/usr_08.html#usr_08.txt
" Vim 9.0
let g:help_3 = {
    \ 'name' : '分屏,标签页' ,
    \ 'A1          :split,:vsplit' : '上下分屏,左右分屏' ,
    \ 'A2                CTRL-W w' : '屏幕间跳转' ,
    \ 'A3                  :close' : '关闭窗口' ,
    \ 'A4                   :only' : '关闭除当前窗口外的所有窗口' ,
    \ 'A5          :split new.txt' : '指定一个文件' ,
    \ 'A6               :new,vnew' : '打开窗口编辑一个新文件' ,
    \ 'A7                 :3split' : '打开一个三行的窗口' ,
    \ 'A8       CTRL-W +,CTRL-W -' : '改变窗口大小' ,
    \ 'A9             20 CTRL-W +' : '重复20次 CTRL-W + 操作' ,
    \ 'B1             10 CTRL-W _' : '设置窗口高度为10' ,
    \ 'B2                CTRL-W _' : '把一个窗口扩展到尽可能大' ,
    \ 'B3           :vertical new' : '左右分屏,打开一个新窗口' ,
    \ 'B4                CTRL-W h' : '跳转到左边的窗口' ,
    \ 'B5                CTRL-W j' : '跳转到下面的窗口' ,
    \ 'B6                CTRL-W k' : '跳转到上面的窗口' ,
    \ 'B7                CTRL-W l' : '跳转到右边的窗口' ,
    \ 'B8                CTRL-W t' : '跳转到最顶上的窗口' ,
    \ 'B9                CTRL-W b' : '跳转到最底下的窗口' ,
    \ 'C1                CTRL-W H' : '把当前窗口移到最左边' ,
    \ 'C2                CTRL-W J' : '把当前窗口移到最下边' ,
    \ 'C3                CTRL-W K' : '把当前窗口移到最上边' ,
    \ 'C4                CTRL-W L' : '把当前窗口移到最右边' ,
    \ 'C5      :qall,:wall,:wqall' : '全部退出,保存,保存并退出' ,
    \ 'C6                  :qall!' : '全部放弃修改且退出' ,
    \ 'C7              :tab split' : '在新标签页上打开当前缓冲区' ,
    \ 'C8    :tab help,:.tab help' : '新的标签页中显示帮助' ,
    \ 'C9                :tabonly' : '关闭其它所有标签页' ,
    \ 'D1   :+tab help,:-tab help' : '在下页,上页打开标签页显示帮助' ,
    \ 'D2   :0tab help,:$tab help' : '在首页,尾页打开标签页显示帮助' ,
    \ 'D3               :tabclose' : '关闭当前标签页' ,
    \ 'D4             :tabclose #' : '关闭最近访问的标签页' ,
    \ 'D5                   gt,gT' : '下个,上个标签页' ,
    \ 'D6               {count}gt' : '转到第 {count} 个标签页' ,
    \ 'D7             :tabn,:tabp' : '下,上一个标签页' ,
    \ 'D8                   :tabs' : '列出标签页和它们包含的窗口' ,
    \ 'D9           :tabnew 1.txt' : '在新的标签页编辑1.txt' ,
    \ }

" https://vimcdoc.sourceforge.net/doc/usr_10.html#usr_10.txt
" Vim 9.0
let g:help_4 = {
    \ 'name' : '宏,替换,排版,改变大小写,外部命令' ,
    \ 'A1                    .' : '重复前一个修改操作' ,
    \ 'A2                   qa' : '记录键盘保存到寄存器a' ,
    \ 'A3                    q' : '停止录制' ,
    \ 'A4                   @a' : '执行寄存器a里的命令 1 次' ,
    \ 'A5                  3@a' : '执行寄存器a里的命令 3 次' ,
    \ 'A6                   @@' : '重复上一个命令' ,
    \ 'A7           :s/ord/new' : '将本行第一个ord替换为new' ,
    \ 'A8         :s/ord/new/g' : '将本行所有ord替换为new' ,
    \ 'A9        :%s/ord/new/g' : '将本文所有ord替换为new' ,
    \ 'B1        :5s/old/new/g' : '将第五行所有ord替换为new' ,
    \ 'B2      :1,5s/old/new/g' : '将第一到五行所有ord替换为new' ,
    \ 'B3      :.,$s/old/new/g' : '当前行到文件末的old替换为new' ,
    \ "B4    :'a,'bs/old/new/g" : "a标记到b标记之间的old替换为new" ,
    \ 'B5    :.,.+4s/old/new/g' : '当前行及其后四行的old替换为new' ,
    \ 'B6          :read 1.txt' : '将1.txt的内容读取到本文件' ,
    \ 'B7             :r 1.txt' : '同上' ,
    \ 'B8            :$r 1.txt' : '1.txt的内容插入到当前文件的最后' ,
    \ 'B9            :0r 1.txt' : '1.txt的内容插入到当前文件的最前面' ,
    \ 'C1    :set textwidth=72' : '设置每行的字数' ,
    \ 'C2       :set textwidth' : '查看当前排版设置' ,
    \ 'C3                 gqap' : '排版当前的段落' ,
    \ 'C4                gggqG' : '排版整个文档' ,
    \ 'C5                  gUw' : '词转换为大写' ,
    \ 'C6                  guw' : '词转换为小写' ,
    \ 'C7                  g~w' : '交换当前词的大小写' ,
    \ 'C8             gugu,guu' : '一行转换为小写' ,
    \ 'C9             gUgU,gUU' : '一行转换为大写' ,
    \ 'D1             g~g~,g~~' : '交换一行大小写' ,
    \ 'D2                   :!' : '执行外部命令' ,
    \ 'D3               :r !ls' : '将ls命令的结果读取到当前文件' ,
    \ 'D4               CTRL-L' : '强制刷新屏幕' ,
    \ }
" https://vimcdoc.sourceforge.net/doc/usr_11.html#usr_11.txt
" Vim 9.0
let g:help_5 = {
    \ 'name' : '崩溃恢复' ,
    \ 'A1        vim -r 1.txt' : '恢复文件' ,
    \ 'A2           vim -r ""' : '恢复没有给丁文件名的文件' ,
    \ 'A3              vim -r' : '交换文件的保存位置' ,
    \ 'A4    vim -r 1.txt.swo' : '使用swo文件恢复' ,
    \ 'A5    [O]pen Read-Only' : 'O用只读方式打开文件' ,
    \ 'A6       (E)dit anyway' : '直接编辑' ,
    \ 'A7           (R)ecover' : '从交换文件中恢复文件' ,
    \ 'A8              (Q)uit' : '退出' ,
    \ 'A9             (A)bort' : '终止' ,
    \ 'B1         (D)elete it' : '删除交换文件' ,
    \ }
" https://vimcdoc.sourceforge.net/doc/usr_20.html#usr_20.txt
" Vim 9.0
let g:help_6 = {
    \ 'name' : '切换到后台' ,
    \ 'A1    CTRL-Z' : '挂起VIM,类似于后台' ,
    \ 'A2        fg' : '回到VIM' ,
    \ 'A3    :shell' : '打开一个新的shell' ,
    \ 'A4      exit' : '退出当前shell,回到VIM' ,
    \ }
" https://vimcdoc.sourceforge.net/doc/usr_28.html#usr_28.txt
" Vim 9.0
let g:help_7 = {
    \ 'name' : '折叠' ,
    \ 'A1                      zf4j' : '折叠当前行和下面四行' ,
    \ 'A2                        zo' : '打开折叠' ,
    \ 'A3                        zc' : '关闭折叠' ,
    \ 'A4                        zd' : '删除折叠' ,
    \ 'A5                        zr' : '展开一层折叠' ,
    \ 'A6                        zm' : '收起一层折叠' ,
    \ 'A7                        zR' : '展开所有折叠' ,
    \ 'A8                        zM' : '收起所有折叠' ,
    \ 'A9                     zn,zN' : '禁止,恢复折叠' ,
    \ 'B1                   :mkview' : '保存折叠' ,
    \ 'B2                 :mkview 3' : '当前设置储存为第三个视图' ,
    \ 'B3                 :loadview' : '载入视图' ,
    \ 'B4               :loadview 2' : '载入第二个视图' ,
    \ 'B5    :set foldmethod=indent' : '依缩进折叠' ,
    \ 'B6          :set foldlevel=3' : '折叠深度设置为3' ,
    \ }

" https://vimcdoc.sourceforge.net/doc/motion.html#object-select
" Vim 9.0
let g:help_8 = {
    \ 'name' : '文本对象选择和一些例子' ,
    \ 'A1        aw,aW' : '一个单词,一个字串' ,
    \ 'A2        iw,iW' : '内含单词,内含字串' ,
    \ 'A3           as' : '一个句子' ,
    \ 'A4           is' : '内含句子' ,
    \ 'A5           ap' : '一个段落' ,
    \ 'A6           ip' : '内含段落' ,
    \ 'A7        a[,a]' : '一个 [] 块' ,
    \ 'A8        i[,i]' : '内含 [] 块' ,
    \ 'A9     a(,a),ab' : '一个块' ,
    \ 'B1     i(,i),ib' : '内含块' ,
    \ 'B2        a<,a>' : '一个 <> 块' ,
    \ 'B3        i<,i>' : '内含 <> 块' ,
    \ 'B4           at' : '一个标签块' ,
    \ 'B5           it' : '内部标签块' ,
    \ 'B6     a{,a},aB' : '一个大块' ,
    \ 'B7     i{,i},iB' : '内含大块' ,
    \ "B8    a'',a`,a'" : "一个引号块" ,
    \ "B9    i'',i`,i'" : "引号块中的内容" ,
    \ 'C1           dl' : '删除字符 (缩写: "x")' ,
    \ 'C2          diw' : '删除内含单词' ,
    \ 'C3          daw' : '删除一个单词' ,
    \ 'C4          diW' : '删除内含字串' ,
    \ 'C5          daW' : '删除一个字串' ,
    \ 'C6`         dgn' : '删除后一个前次搜索模式的匹配' ,
    \ 'C7           dd' : '删除一行' ,
    \ 'C8          dis' : '删除内含句子' ,
    \ 'C9`         das' : '删除一个句子' ,
    \ 'D1          dib' : '删除内含 ( ) 块' ,
    \ 'D2          dab' : '删除一个 ( ) 块' ,
    \ 'D3          dip' : '删除内含段落' ,
    \ 'D4          dap' : '删除一个段落' ,
    \ 'D5          diB' : '删除内含 { } 大块' ,
    \ 'D6          daB' : '删除一个 { } 大块' ,
    \ }
" 只显示自定义的描述字典
let g:which_key_ignore_outside_mappings = 1
let g:which_key_map = {}
let g:which_key_map[1] = {
    \ 'name' : 'VIM操作指南' ,
    \ '0' : g:help_0 ,
    \ '1' : g:help_1 ,
    \ '2' : g:help_2 ,
    \ '3' : g:help_3 ,
    \ '4' : g:help_4 ,
    \ '5' : g:help_5 ,
    \ '6' : g:help_6 ,
    \ '7' : g:help_7 ,
    \ '8' : g:help_8 ,
    \ }

call which_key#register('MyHelp', "g:which_key_map")

nnoremap <silent> <leader>h :WhichKey 'MyHelp'<CR>





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
