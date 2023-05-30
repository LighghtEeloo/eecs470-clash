FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    zsh \
    git \
    build-essential curl libffi-dev libffi7 libgmp-dev \
    libgmp10 libncurses-dev libncurses5 libtinfo5 \
    manpages-dev \
    wget \
    zip \
    tmux \
    neovim \
    libnuma-dev \
    llvm \
    autojump

# install ghc toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
RUN PATH=/root/.ghcup/bin:$PATH && ghcup install ghc 9.0.2 && ghcup set ghc 9.0.2

# install rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
RUN . /root/.cargo/env && CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse cargo install exa

# zsh configs
COPY zsh/.zshrc /root/.zshrc
COPY zsh/.zshrcx /root/.zshrcx
COPY zsh/.p10k.zsh /root/.p10k.zsh

# build clash
COPY clash /root/clash
RUN PATH=/root/.ghcup/bin:$PATH && cd /root/clash && cabal update && cabal build

# optionally, build formatter
RUN PATH=/root/.ghcup/bin:$PATH && cabal install ormolu

CMD ["zsh"]
