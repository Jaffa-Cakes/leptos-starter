## This image is meant for use during development
FROM debian:bookworm

# Locked versions
ARG RUST_VERSION_FULL=1.75.0
ARG NODE_VERSION_MAJOR=20

# Update package repositories and existing packages
RUN apt update && \
    apt upgrade -y

# Install basic essential packages
RUN apt install -y \
    build-essential \
    curl \
    git \
    pkg-config \
    libssl-dev \
    libpq-dev \
    zsh \
    lsb-release

# Install Zsh with Oh My Zsh with plugins and set as default shell
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended && \
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/zsh-users/zsh-history-substring-search $HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search && \
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search history aliases sudo themes docker nmap kubectl)/' $HOME/.zshrc && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/' $HOME/.zshrc && \
    chsh -s /usr/bin/zsh

# Install Rust with targets and CLI tools
ENV PATH="/root/.cargo/bin:${PATH}"
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${RUST_VERSION_FULL} && \
    rustup target add wasm32-unknown-unknown && \
    rustup component add rustfmt clippy && \
    cargo install cargo-watch --version 8.* && \
    cargo install cargo-leptos --version 0.2.* && \
    cargo install diesel_cli --version 2.* --no-default-features --features postgres

# Install Node.js
RUN set -uex && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_VERSION_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt -y update && \
    apt -y install nodejs

# Install Docker with socket mounted from host
ENV DOCKER_HOST=unix:///var/run/docker-host.sock
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt update && \
    apt install -y docker-ce docker-ce-cli containerd.io && \
    if getent group docker > /dev/null 2>&1; then \
    echo "Docker group exists"; \
    else \
    groupadd docker; \
    fi && \
    usermod -aG docker root