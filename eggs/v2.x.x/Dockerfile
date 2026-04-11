ARG VERSION=""
FROM --platform=$TARGETOS/$TARGETARCH memothelemo/eden:${VERSION} AS eden

FROM --platform=$TARGETOS/$TARGETARCH debian:trixie-slim

LABEL author="memothelemo" maintainer="dev@memothelemo.xyz"
LABEL org.opencontainers.image.source="https://github.com/Dystopiko/eden-pterodactyl"
LABEL org.opencontainers.image.licenses=AGPL

ENV DEBIAN_FRONTEND=noninteractive

# Required dependencies to run Eden
# https://github.com/Dystopiko/eden/blob/c7631dd147f25523505349e5757a414ae4bd883d/Dockerfile#L61-L62
RUN apt update \
    && apt install -y --no-install-recommends \
        ca-certificates \
        libcurl4 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -d /home/container -s /bin/bash container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY --from=eden --chown=container:container /app/eden /home/container/
COPY --from=eden --chown=container:container /app/crates /home/container/
COPY --chown=container:container entrypoint.sh /entrypoint.sh

CMD [ "/bin/bash", "/entrypoint.sh" ]
