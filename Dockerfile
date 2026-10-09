# Baikal with the Home Assistant calendar-timezone fix (sabre-io/dav#1318).
#
# ckulka/baikal stopped at Baikal 0.10.1, so the release is downloaded here and
# dropped into ckulka's nginx + php-fpm 8.2 runtime, which still works for
# 0.11/0.12 (they need php >= 8.2). The fix is a patch instead of a whole
# copied Plugin.php, so a sabre/dav update cannot be silently reverted: when
# the patch no longer applies, the build fails. It accepts calendar-timezone
# both as a plain name ("Europe/Paris") and as a VCALENDAR.
FROM docker.io/library/alpine:3.22 AS builder

ARG VERSION=0.12.1
ARG SHA256=0449abb72b151d39d9c08c63cb83a05d9e9adb065b1165ef6786b0b6a13d203c

ADD https://github.com/sabre-io/Baikal/releases/download/${VERSION}/baikal-${VERSION}.zip /tmp/baikal.zip
COPY home-assistant-timezone.patch /tmp/
RUN echo "${SHA256}  /tmp/baikal.zip" | sha256sum -c - && \
    apk add --no-cache unzip patch && \
    unzip -q /tmp/baikal.zip -d / && \
    patch -d /baikal -p1 --forward < /tmp/home-assistant-timezone.patch && \
    grep -q 'function readCalendarTimeZone' /baikal/vendor/sabre/dav/lib/CalDAV/Plugin.php

# ckulka/baikal:nginx-php8.2, pinned by digest (rolling tag, rebuilt 2025-11-30).
FROM docker.io/ckulka/baikal@sha256:8bd8d3d500668804b919f4065c9ade5263d1dc0733cdc5f9abfc8f55323af28f

ARG VERSION=0.12.1
LABEL org.opencontainers.image.title="baikal-docker-hass" \
      org.opencontainers.image.description="Baikal with the Home Assistant calendar-timezone fix" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.source="https://github.com/visibilityspots/dockerfile-baikal"

RUN rm -rf /var/www/baikal
COPY --from=builder --chown=nginx:nginx /baikal /var/www/baikal
