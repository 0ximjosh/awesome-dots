default:
    @just --list

update:
    yay
    flatpak update

bootstrap_apple:
    #!/bin/bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo " eval \"$(/opt/homebrew/bin/brew shellenv)\"" >> ~/.zprofile
    brew install neovim firefox gh kitty cloc go node neofetch eza bat tree rg fd coreutils spotify
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    mkdir ~/github
    cd ~/github
    git clone https://github.com/0ximjosh/awesome-dots
    ln -s kitty ~/.config/
    ln -s neovim ~/.config/
    ln -s cloc ~/.config/
    ln -s .zsh_base.zsh ~/.config/


update_yabai:
    echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

ghostty server:
  infocmp -x | ssh {{server}} -- tic -x -
