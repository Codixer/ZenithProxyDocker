# Use Ubuntu Noble and allow multi-platform builds
FROM --platform=$TARGETPLATFORM ubuntu:noble

ARG TARGETARCH
ENV ARCH_FILENAME=""
ENV USER=container HOME=/home/container

# Create user and working dir
RUN apt-get update && apt-get install -y wget unzip curl ca-certificates && \
    adduser --disabled-password --home /home/container container && \
    mkdir -p /home/container/ZenithProxy

# Set the architecture-specific filename
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        ARCH_FILENAME="amd64"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        ARCH_FILENAME="aarch64"; \
    else \
        echo "Unsupported architecture: $TARGETARCH" && exit 1; \
    fi && \
    cd /home/container/ZenithProxy && \
    wget https://github.com/rfresh2/ZenithProxy/releases/download/launcher-v3/ZenithProxy-launcher-linux-${ARCH_FILENAME}.zip && \
    unzip ZenithProxy-launcher-linux-${ARCH_FILENAME}.zip && \
    rm ZenithProxy-launcher-linux-${ARCH_FILENAME}.zip

USER container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
