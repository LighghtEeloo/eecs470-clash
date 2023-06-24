FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y \
    zsh \
    git
RUN apt-get install -y \
    build-essential curl libffi-dev libffi7 libgmp-dev
RUN apt-get install -y \
    libgmp10 libncurses-dev libncurses5 libtinfo5
RUN apt-get install -y \
    manpages-dev \
    wget \
    zip \
    tmux \
    neovim \
    libnuma-dev
RUN apt-get install -y \
    llvm \
    autojump

# install ghc toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
RUN PATH=/root/.ghcup/bin:$PATH && ghcup install ghc 9.0.2 && ghcup set ghc 9.0.2
RUN PATH=/root/.ghcup/bin:$PATH && ghcup install hls 1.10.0.0 && ghcup set hls 1.10.0.0

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . /root/.cargo/env && CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse cargo install exa

# optionally, build formatter
RUN PATH=/root/.ghcup/bin:$PATH && cabal install ormolu

# build clash
RUN git clone https://github.com/LighghtEeloo/clash-from-the-gates-up.git /root/clash
RUN PATH=/root/.ghcup/bin:$PATH && cd /root/clash && cabal update && cabal build

# zsh configs
COPY zsh/.zshrc /root/.zshrc
COPY zsh/.zshrcx /root/.zshrcx
COPY zsh/.p10k.zsh /root/.p10k.zsh

# update the vscode template folder for using hls with clash
COPY .vscode /root/.vscode_template

# finally, let zinit configure itself
RUN zsh -c ". ~/.zshrc"

CMD ["zsh"]
