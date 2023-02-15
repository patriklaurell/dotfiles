#!/bin/bash

git submodule init
git submodule update

# Helper functions used for coloring output
CLEAR="\033[0m"
BOLD="\033[0;01m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
echo_red()    { echo -e    "${RED}${1}${CLEAR}"; }
echo_green()  { echo -e  "${GREEN}${1}${CLEAR}"; }
echo_yellow() { echo -e "${YELLOW}${1}${CLEAR}"; }
echo_bold()   { echo -e   "${BOLD}${1}${CLEAR}"; }

dotfiles () {
    ##########
    # This function is based on a blogpost by Michael Smalley
    # http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
    #
    # This function creates symlinks for all files/dirs in the ./home directory to ~/ and backs up any files/dirs that collide to ./backup
    #
    # Modifications by Erik Bjäreholt (github.com/ErikBjare)
    #  - Made so that it automatically symlinks all files/dirs in ./home
    #  - Improved output and added color
    # Modifications by Johan Bjäreholt (github.com/johan-bjareholt)
    ##########

    # Variables
    cwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    dir=$cwd/home                    # files will symlink to ~/
    backup=$cwd/backup               # old dotfiles backup directory

    # files="zshrc config/awesome oh-my-zsh Xdefaults vimrc xmonad"   # list of files/folders to symlink in homedir
    files=$( cd $dir && find ./ -maxdepth 1 -mindepth 1 )

    # create dotfiles_old in homedir
    # echo "Creating $backup for backup of any existing dotfiles"
    mkdir -p $backup
    # echo "...done"

    # change to the dotfiles directory
    # echo "Changing to the $dir directory"
    cd $dir
    # echo "...done"

    # move any existing dotfiles (excluding symlinks) in homedir to dotfiles_old directory, then create symlinks
    for file in $files; do
        if [ -e ~/$file ]; then
            if [ ! -h ~/$file ]; then
                echo_red "Collision: Moving existing ~${file:2} to $backup"
                mv ~/$file $backup
            else
                echo_yellow "Symlink already existed at ~${file:2}"
            fi
	fi
        if [ ! -h ~/$file ]; then
            echo_green "Creating symlink to ${file:2}"
            ln -si $dir/$file ~/$file
        fi
    done

    cd $cwd
}

echo Welcome to my linux config setup script!

# Install tpm if it doesn't exist
if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo -ne "Tmux plugin manager not found, would you like to install it? (y/n): "
    read prompt
    if [ $prompt = y ]; then   
        echo "Installing tpm..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
fi

# Install vim-plug if it doesn't exist
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo -ne "Vim-plug not found, would you like to install it? (y/n): "
    read prompt
    if [ $prompt = y ]; then
        echo "Installing vim-plug..."
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
fi

# Install oh-my-zsh if it doesn't exist
if [ ! -d ~/.oh-my-zsh ]; then
    echo -ne "Oh-my-zsh not found, would you like to install it? (y/n): "
    read prompt
    if [ $prompt = y ]; then
        echo "Installing oh-my-zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
fi

# Install zsh-autosuggestions if it doesn't exit$
if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
    echo -ne "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi

# Install pyenv if it doesn't exist
if [ ! -d ~/.pyenv ]; then
    echo -ne "Pyenv not found, would you like to install it? (y/n): "
    read prompt
    if [ $prompt = y ]; then
        echo "Installing pyenv..."
        curl https://pyenv.run | bash
    fi
fi

for section in dotfiles; do
    echo -ne "Would you like to setup $section? (y/n): "
    read prompt
    if [ $prompt = y ]; then
        `echo $section`
    fi
done

echo -e "${CLEAR}Done!"
