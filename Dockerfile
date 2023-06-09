FROM archlinux:latest

# add mirrors to pacman
COPY mirrorlist /etc/pacman.d/mirrorlist

# update system and install critical packages
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed \
    sudo base-devel zsh git wget zip tmux neovim gcc gdb llvm openssl openssh

# create a no password user (AUR packages require non-root user)
RUN useradd -m architect -s /bin/zsh && usermod -aG video,lp,input architect
RUN echo "architect ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER architect

# install python and rust
RUN sudo pacman -S --noconfirm --needed python-pip rustup exa && rustup default stable
RUN cargo install bat

# install paru, the AUR helper
RUN cd /home/architect && git clone https://aur.archlinux.org/paru-bin.git
RUN cd /home/architect/paru-bin && makepkg --noconfirm -si
RUN rm -rf /home/architect/paru-bin

# install needed package for development
RUN paru -Syu --noconfirm && paru -S --noconfirm --needed \
    verilator ghcup-hs-bin riscv-gnu-toolchain-bin elf2hex verible-bin autojump
RUN pip install cocotb

# install ghc toolchain
RUN PATH=/home/architect/.ghcup/bin:$PATH && ghcup install ghc 9.0.2 && ghcup set ghc 9.0.2
RUN PATH=/home/architect/.ghcup/bin:$PATH && ghcup install cabal 3.6.2.0 && ghcup set cabal 3.6.2.0
RUN PATH=/home/architect/.ghcup/bin:$PATH && ghcup install stack 2.9.3 && ghcup set stack 2.9.3

# build clash
RUN cd /home/architect && git clone https://github.com/LighghtEeloo/clash-from-the-gates-up.git
RUN PATH=/home/architect/.ghcup/bin:$PATH && cd /home/architect/clash-from-the-gates-up && cabal update && cabal build

# optionally, build formatter
RUN PATH=/home/architect/.ghcup/bin:$PATH && cabal install ormolu

# zsh configs
COPY --chown=architect:architect zsh/.zshrc /home/architect/.zshrc
COPY --chown=architect:architect zsh/.zshrcx /home/architect/.zshrcx
COPY --chown=architect:architect zsh/.p10k.zsh /home/architect/.p10k.zsh

# finally, let zinit configure itself
RUN zsh -c "export TERM=xterm-256color && source ~/.zshrc"

# update the vscode template folder for using hls with clash
COPY --chown=architect:architect .vscode /home/architect/.vscode

# clean up
RUN paru -Scc --noconfirm

CMD ["zsh"]
