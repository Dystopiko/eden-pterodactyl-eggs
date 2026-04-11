ARG VERSION=""
FROM --platform=$TARGETOS/$TARGETARCH memothelemo/eden:${VERSION} AS eden

FROM --platform=$TARGETOS/$TARGETARCH debian:trixie-slim

LABEL author="memothelemo" maintainer="dev@memothelemo.xyz"
LABEL org.opencontainers.image.source = "https://github.com/Dystopiko/eden-pterodactyl-eggs"
LABEL org.opencontainers.image.licenses=AGPL

ENV DEBIAN_FRONTEND=noninteractive

# Required dependencies to run Eden (and entrypoint.sh)
# https://github.com/Dystopiko/eden/blob/c7631dd147f25523505349e5757a414ae4bd883d/Dockerfile#L61-L62
RUN apt update \
    && apt install -y --no-install-recommends \
        ca-certificates \
        libcurl4 \
        lsof \
        openssl \
        iproute2 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

RUN mkdir -p /home/container

COPY --from=eden --chown=container:container /app/eden /home/container/eden
COPY --from=eden --chown=container:container /app/crates /home/container/crates
COPY --chown=container:container entrypoint.sh /entrypoint.sh

CMD [ "/bin/bash", "/entrypoint.sh" ]
