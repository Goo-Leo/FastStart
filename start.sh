#!/bin/sh
pgm="$1"
options="$2"

case "pgm" in
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
    *)
	    echo "Not support yet, exiting"
esac
