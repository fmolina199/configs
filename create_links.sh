#!/bin/bash

CREATE_NVIM_LINK=0
CREATE_TMUX_LINK=0
CREATE_ZSH_CUSTOM_LINK=0
CREATE_ALACRITTY_LINK=0
GIT_PULL=0

help_message()
{
	# Display Help
	echo "Create symbolic links for configuration on this repo"
	echo
	echo "Syntax: ${0} [-h|p|a|l|n|t|z]"
	echo "options:"
	echo "-h     Print help."
	echo "-p     Run git pull before running other links."
	echo "-a     Create symlink for all configuration."
	echo "-l     Create symlink for ALACRITTY configuration."
	echo "-n     Create symlink for NEOVIM configuration."
	echo "-t     Create symlink for TMUX configuration."
	echo "-z     Create symlink for ZSH configuration."
	echo
}

while getopts ":hpalntz" option; do
	case $option in
		a) # ALL
			CREATE_NVIM_LINK=1
			CREATE_TMUX_LINK=1
			CREATE_ALACRITTY_LINK=1
			CREATE_ZSH_CUSTOM_LINK=1;;
		l) # ALACRITTY
			CREATE_ALACRITTY_LINK=1;;
		n) # NEOVIM
			CREATE_NVIM_LINK=1;;
		t) # TMUX
			CREATE_TMUX_LINK=1;;
		z) # ZSH Custom Links
			CREATE_ZSH_CUSTOM_LINK=1;;
		p) # Run git pull
			GIT_PULL=1;;
		h) # display Help
			help_message
			exit;;
		\?) # Invalid option
			echo "Error: Invalid option"
			echo ""
			help_message
			exit;;
   esac
done

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

if [ "$GIT_PULL" -eq "1" ]; then
	echo "=> Updateing repo..."
	git pull
fi

if [ "$CREATE_ALACRITTY_LINK" -eq "1" ]; then
	if [ ! -d ~/.config/alacritty ]; then
		echo "=> Creating Alacritty config synlink..."
		mkdir -p ~/.config
		ln -s $BASEDIR/alacritty ~/.config/alacritty
	fi
fi

if [ "$CREATE_NVIM_LINK" -eq "1" ]; then
	if [ ! -d ~/.config/nvim ]; then
		echo "=> Creating NVIM config synlink..."
		mkdir -p ~/.config
		ln -s $BASEDIR/nvim ~/.config/nvim
	fi
fi

if [ "$CREATE_TMUX_LINK" -eq "1" ]; then
	if [ ! -f ~/.tmux.conf ]; then
		echo "=> Creating TMUX config synlink..."
		ln -s $BASEDIR/tmux/tmux.conf ~/.tmux.conf
	fi
fi

if [ "$CREATE_ZSH_CUSTOM_LINK" -eq "1" ]; then
	if [ ! -f ~/.zshrc ]; then
		echo "=> Creating ZSHRC config synlink..."
		ln -s $BASEDIR/zsh/zshrc ~/.zshrc
	else
		echo "x> ~/.zshrc file already exist"
	fi
	if [ ! -d ~/.config/zsh ]; then
		echo "=> Creating ZSH custom config synlink..."
		mkdir -p ~/.config/zsh
		ln -s $BASEDIR/zsh/alias.zsh ~/.config/zsh/alias.zsh
	fi
fi
