# Dockerfile
FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
# Everything after git is for vscode-server
RUN apt-get update && apt-get install -y wget curl build-essential gnupg ca-certificates git libnss3 libxss1 libasound2 libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0 && rm -rf /var/lib/apt/lists/*

# Install Go
ENV GO_VERSION=1.24.3
RUN curl -LO https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
# Installing helpers for vscode
RUN go install golang.org/x/tools/gopls@latest && go install honnef.co/go/tools/cmd/staticcheck@latest

# Install Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:$PATH"

# Install Node.js (LTS)
#RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && \
#    apt-get install -y nodejs && \
#    rm -rf /var/lib/apt/lists/*

# Install code-server
ENV CODE_SERVER_VERSION=4.99.4
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb -o code-server.deb && \
    dpkg -i code-server.deb && \
    rm code-server.deb

EXPOSE 8080
