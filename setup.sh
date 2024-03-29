#!/bin/bash

## VARIABLES
FOLDER=$(pwd)
user=$(whoami)

HOME=/home/$user

# Get tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Get ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
mkdir ~/.zsh/
cp -v zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Rust 
echo "------ Installing Rust ------"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## COPY CONFIGS
echo ""
echo "----------------------------"
echo "Copying config files to home"
echo "----------------------------"
echo ""

cp -v $FOLDER/zshrc $HOME/.zshrc
cp -v $FOLDER/tmux.conf $HOME/.tmux.conf
cp -v $FOLDER/wallpaper.png $HOME/.wallpaper
cp -v $FOLDER/gdbinit $HOME/.gdbinit
cp -v $FOLDER/kitty $HOME/.config/kitty/kitty.conf

if [ $XDG_CURRENT_DESKTOP == 'GNOME' ]
then
	gsettings set org.gnome.desktop.background picture-uri file://$HOME/.wallpaper
else
	echo "[!] Set wallpaper manually"
fi

# Download fonts
echo "Downloading Nerd Font"
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip "*.ttf" -d $HOME/.fonts 
fc-cache -f -v

$(chsh -s $(which zsh))

kitty +kitten themes --reload-in=all Catppuccin-Mocha && exit

git clone git@github.com:skrewby/kickstart.nvim.git $HOME/.config/nvim
nvim --headless "+Lazy! sync" +qa

source "$HOME/.cargo/env"
rustup component add rust-analyzer

echo "                            "
echo "----------------------------"
echo "            DONE            "
echo "----------------------------"
echo "                            "
