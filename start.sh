#!/bin/sh
pgm="$1"

case "$pgm" in
    zsh)
	    echo "Installing zsh"
	    sudo apt install -y zsh
	    if [ ! -d "$HOME/.oh-my-zsh" ]; then
		    echo "Installing Oh-My-Zsh..."
		    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	    fi
	    chsh -s $(which zsh)
	    mv $HOME/.zshrc .zshrc_old
	    cp ./.zshrc $HOME/
	    source $HOME/.zshrc
	    echo "Done, excute 'zsh' for a try"
	;;
    neovim)
	    sudo apt install -y neovim clangd
	;;
    change)
	    sudo mv /etc/apt/sources.list /etc/apt/sources.list.bak
	    sudo cat > /etc/apt/sources.list <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse

# 以下安全更新软件源包含了官方源与镜像站配置，如有需要可自行修改注释切换
deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
# deb-src http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse
# # deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-proposed main restricted universe multiverse
EOF
	sudo apt-get update && sudo apt-get upgrade
	;;
    *)
	    echo "Not support yet, exiting"
esac
