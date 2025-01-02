#!/bin/bash
set -x  
cp ./.gitconfig ~

sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin/

sudo apt-get install bat -y    

# powerline fonts for zsh agnoster theme
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
cd .. && rm -rf fonts


zsh -c 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
zsh -c 'git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting'
cp ./.zshrc ~

########################################################################################################################
#### set agnoster as theme, this came from https://gist.github.com/corentinbettiol/21a6d4e942a0ee58d51acb7996697a88
#### in vscode settings for devcontainer (not for User or Workspace), Search for terminal.integrated.fontFamily value, and set it to "Roboto Mono for Powerline" (or any of those: https://github.com/powerline/fonts#font-families font families).
# save current zshrc
mv ~/.zshrc ~/.zshrc.bak

sudo sh -c "$(wget -O- https://raw.githubusercontent.com/deluan/zsh-in-docker/master/zsh-in-docker.sh)" -- \
    -t agnoster -p zsh-autosuggestions -p zsh-syntax-highlighting 
# remove newly created zshrc
rm -f ~/.zshrc
# restore saved zshrc
mv ~/.zshrc.bak ~/.zshrc
# update theme
sed -i '/^ZSH_THEME/c\ZSH_THEME="agnoster"' ~/.zshrc
########################################################################################################################
