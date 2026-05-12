FROM ubuntu:22.04

# Avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    zstd \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Corporate proxy/firewall intercepts SSL — skip verification for git
ENV GIT_SSL_NO_VERIFY=1

# Install elan (Lean version manager)
RUN curl -sSfk https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | bash -s -- -y --default-toolchain none

ENV PATH="/root/.elan/bin:${PATH}"

WORKDIR /workspace

# Copy toolchain file and manually download + link the Lean toolchain (bypasses elan's SSL)
COPY lean-toolchain ./
RUN LEAN_TAG=$(cat lean-toolchain | sed 's|leanprover/lean4:||') && \
    LEAN_VER=$(echo ${LEAN_TAG} | sed 's|^v||') && \
    echo "Downloading Lean ${LEAN_TAG} ..." && \
    curl -sSfkL -o lean.tar.zst \
      "https://github.com/leanprover/lean4/releases/download/${LEAN_TAG}/lean-${LEAN_VER}-linux.tar.zst" && \
    mkdir -p /root/.elan/toolchains && \
    tar --zstd -xf lean.tar.zst -C /root/.elan/toolchains && \
    mv /root/.elan/toolchains/lean-${LEAN_VER}-linux /root/.elan/toolchains/leanprover--lean4---${LEAN_TAG} && \
    elan default leanprover--lean4---${LEAN_TAG} && \
    rm lean.tar.zst && \
    lean --version

# Copy project files
COPY lakefile.lean lake-manifest.json ./

# Fetch dependencies (mathlib etc.) — this layer is cached unless manifest changes
RUN lake update

# Copy source files
COPY lean/ ./lean/

# Build the project
RUN lake build

CMD ["lake", "env", "lean"]
