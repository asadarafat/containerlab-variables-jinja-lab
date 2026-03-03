FROM ubuntu:24.04

SHELL ["/bin/bash", "-lc"]

ARG DEBIAN_FRONTEND=noninteractive
ARG CONTAINERLAB_VERSION=0.73.0

LABEL org.opencontainers.image.title="containerlab-variables-jinja-lab-tools"
LABEL org.opencontainers.image.description="Tool image for Containerlab variable and Jinja topology labs"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      docker.io \
      iproute2 \
      iputils-ping \
      jq \
      python3 \
      python3-pip \
      tcpdump; \
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
    python3 -m pip install --no-cache-dir --break-system-packages \
      "jinja2-cli[yaml]" \
      pyyaml; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["bash"]
