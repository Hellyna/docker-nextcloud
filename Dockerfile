ARG DOCKER_TAG
FROM nextcloud:${DOCKER_TAG}

ARG S6_OVERLAY_VERSION=2.2.0.1
ARG TARGETARCH

RUN export _url="https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${TARGETARCH}.tar.gz" && \
  test -n "$(which wget)" && \
  wget -qO - "$_url" | tar -xzf - -C / || \
  curl -sSL "$_url" | tar -xzf - -C /


ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
  S6_SERVICES_GRACETIME=10000 \
  S6_KILL_GRACETIME=6000

COPY rootfs /

ENTRYPOINT ["/init"]
