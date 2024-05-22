# My Vimrc

## Termux

``` sh

# 读写权限授权
termux-setup-storage

# 更换软件源
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list

# 升级
pkg update && pkg upgrade


# 安装软件
pkg install git vim python nodejs yarn -y

#一些Python包
pip install black jedi

# 下载VIM插件管理器Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# git配置文件 https $ ssh

cd ~/.vim && git clone https://github.com/KUVBBH/VIMRC.git

cd ~/.vim && git clone git@github.com:KUVBBH/VIMRC.git

```
