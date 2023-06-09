FROM archlinux:latest

# update system and install critical packages
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm --needed \
    sudo base-devel zsh git wget zip tmux neovim exa

# create a no password user (AUR packages require non-root user)
RUN useradd -m architect && usermod -aG video,lp,input architect
RUN echo "architect ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER architect

# zsh configs
COPY zsh/.zshrc /home/architect/.zshrc
COPY zsh/.zshrcx /home/architect/.zshrcx
COPY zsh/.p10k.zsh /home/architect/.p10k.zsh

# install python and rust
RUN sudo pacman -S --noconfirm --needed python-pip rustup && rustup default stable

# install paru, the aur helper
RUN cd /home/architect && git clone --depth 1 https://aur.archlinux.org/paru.git
RUN cd /home/architect/paru && makepkg -si --noconfirm && cd .. && rm -rf paru

# install needed package for development
RUN paru -S --noconfirm --needed \
    verilator ghcup-hs-bin riscv-gnu-toolchain-bin elf2hex verible-bin autojump

# install ghc toolchain
RUN PATH=/home/architect/.ghcup/bin:$PATH && ghcup install ghc 9.0.2 && ghcup set ghc 9.0.2
RUN PATH=/home/architect/.ghcup/bin:$PATH && ghcup install cabal 3.6.2.0 && ghcup set cabal 3.6.2.0
RUN PATH=/home/architect/.ghcup/bin:$PATH && ghcup install stack 2.9.3 && ghcup set stack 2.9.3

# build clash
RUN cd /home/architect && git clone https://github.com/LighghtEeloo/clash-from-the-gates-up.git
RUN PATH=/home/architect/.ghcup/bin:$PATH && cd /home/architect/clash-from-the-gates-up && cabal update && cabal build

# optionally, build formatter
RUN PATH=/home/architect/.ghcup/bin:$PATH && cabal install ormolu

# update the vscode template folder for using hls with clash
COPY .vscode /home/architect/.vscode

# finally, let zinit configure itself
RUN zsh -c "source ~/.zshrc"

CMD ["zsh"]
