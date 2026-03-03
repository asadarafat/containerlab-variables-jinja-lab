FROM ubuntu:24.04

SHELL ["/bin/bash", "-lc"]

ARG DEBIAN_FRONTEND=noninteractive
ARG CONTAINERLAB_VERSION=0.73.0
ARG DOCKER_COMPOSE_VERSION=2.29.2

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      bash-completion \
      ca-certificates \
      curl \
      docker.io \
      git \
      iproute2 \
      iptables \
      iputils-ping \
      jq \
      make \
      procps \
      python3 \
      python3-pip \
      sudo \
      tar \
      tcpdump \
      unzip \
      wget \
      xz-utils; \
    arch="$(dpkg --print-architecture)"; \
    case "${arch}" in \
      amd64) clab_arch="amd64" ;; \
      arm64) clab_arch="arm64" ;; \
      *) echo "unsupported architecture: ${arch}" >&2; exit 1 ;; \
    esac; \
    curl -fsSLo /tmp/containerlab.deb \
      "https://github.com/srl-labs/containerlab/releases/download/v${CONTAINERLAB_VERSION}/containerlab_${CONTAINERLAB_VERSION}_linux_${clab_arch}.deb"; \
    apt-get install -y --no-install-recommends /tmp/containerlab.deb; \
    rm -f /tmp/containerlab.deb; \
    if ! docker compose version >/dev/null 2>&1; then \
      plugin_arch="x86_64"; \
      if [ "${arch}" = "arm64" ]; then plugin_arch="aarch64"; fi; \
      mkdir -p /usr/local/lib/docker/cli-plugins; \
      curl -fsSL \
        "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${plugin_arch}" \
        -o /usr/local/lib/docker/cli-plugins/docker-compose; \
      chmod +x /usr/local/lib/docker/cli-plugins/docker-compose; \
    fi; \
    python3 -m pip install --no-cache-dir --break-system-packages \
      "jinja2-cli[yaml]" \
      pyyaml \
      yamllint; \
    mkdir -p /workspaces/.clab; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*
