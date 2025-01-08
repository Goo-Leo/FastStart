#!/bin/sh
pgm="$1"
pram="$2"

case "$pgm" in
    -zsh)
	    echo "Installing zsh"
	    sudo apt install -y zsh
	    if [ ! -d "$HOME/.oh-my-zsh" ]; then
		    echo "Installing Oh-My-Zsh..."
		    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	    fi
	    sudo chsh -s $(which zsh)
	    mv $HOME/.zshrc .zshrc_old
	    cp ./.zshrc $HOME/
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        source $HOME/.zshrc
	    echo "Done, excute 'zsh' for a try"
	;;
    -neovim)
	    sudo apt install -y neovim clangd
        case "$pram" in
            --vim)
                cp ./init.vim ~/.config/nvim/
                ;;
            --lua)
            if command -v lua >/dev/null 2>&1; then
                lua -v
            else
                echo "Installing Lua"
                sudo apt update
                sudo apt install lua5.4
            fi
                cp ./init.lua ~/.config/nvim/init.lua
                git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
                nvim --headless +PackerSync +qa
                echo "pack.vim config done"
                ;;
            esac
	;;
    -change)
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
    -help)
        echo "Call -zsh for change default shell into zsh with oh-myzsh"
        echo "Call -neovim --vim/lua for deploying neovim in vim or lua config"
        echo "Call -change for change apt source to tuna source(ubuntu noble only)"
    ;;
    *)
	    echo "Not support yet, exiting, call -help for what I can do."
        exit 1
esac
