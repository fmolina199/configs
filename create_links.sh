#!/bin/bash

CREATE_NVIM_LINK=0
CREATE_TMUX_LINK=0
CREATE_ZSH_CUSTOM_LINK=0


help_message()
{
   # Display Help
   echo "Create symbolic links for configuration on this repo"
   echo
   echo "Syntax: ${0} [-h|a|n|t|z]"
   echo "options:"
   echo "h     Print help."
   echo "a     Create symlink for all configuration."
   echo "n     Create symlink for NEOVIM configuration."
   echo "t     Create symlink for TMUX configuration."
   echo "z     Create symlink for ZSH configuration."
   echo
}

while getopts ":hantz" option; do
	case $option in
		a) # ALL
			CREATE_NVIM_LINK=1
			CREATE_TMUX_LINK=1
			CREATE_ZSH_CUSTOM_LINK=1;;
		n) # NEOVIM
			CREATE_NVIM_LINK=1;;
		t) # TMUX
			CREATE_TMUX_LINK=1;;
		z) # ZSH
			CREATE_ZSH_CUSTOM_LINK=1;;
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

if [ "$CREATE_NVIM_LINK" -eq "1" ]; then
	echo "=> Creating NVIM config synlink..."
	ln -s $BASEDIR/nvim ~/.config/nvim
fi

if [ "$CREATE_TMUX_LINK" -eq "1" ]; then
	echo "=> Creating TMUX config synlink..."
	ln -s $BASEDIR/tmux/tmux.conf ~/.tmux.conf
fi

if [ "$CREATE_ZSH_CUSTOM_LINK" -eq "1" ]; then
	echo "=> Creating ZSH custom config synlink..."
	echo "  => TODO: not implemented"
fi

