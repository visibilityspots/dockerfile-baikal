# Baikal with the Home Assistant calendar-timezone fix (sabre-io/dav#1318).
#
# Baikal is downloaded from the upstream release and runs on Alpine with nginx
# and php-fpm 8.4. The fix is a patch instead of a whole copied Plugin.php, so
# a sabre/dav update cannot be silently reverted: when the patch no longer
# applies, the build fails. It accepts calendar-timezone both as a plain name
# ("Europe/Paris") and as a VCALENDAR.
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

FROM docker.io/library/alpine:3.22

ARG VERSION=0.12.1
LABEL org.opencontainers.image.title="baikal" \
      org.opencontainers.image.description="Baikal with the Home Assistant calendar-timezone fix" \
      org.opencontainers.image.version="${VERSION}" \
      org.opencontainers.image.source="https://github.com/visibilityspots/dockerfile-baikal"

# sqlite is the CLI, for backups from inside the container
RUN apk add --no-cache \
      nginx \
      php84 \
      php84-ctype \
      php84-curl \
      php84-dom \
      php84-fpm \
      php84-iconv \
      php84-mbstring \
      php84-openssl \
      php84-pdo \
      php84-pdo_mysql \
      php84-pdo_pgsql \
      php84-pdo_sqlite \
      php84-session \
      php84-simplexml \
      php84-xml \
      php84-xmlreader \
      php84-xmlwriter \
      sqlite && \
    ln -s php84 /usr/bin/php && \
    # php-fpm runs as uid 101, the owner of existing Baikal data; Alpine's nginx is 100
    adduser -S -D -H -u 101 -G nginx -h /var/www/baikal baikal && \
    rm -f /etc/nginx/http.d/default.conf /etc/php84/php-fpm.d/www.conf && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY files/nginx.conf /etc/nginx/http.d/baikal.conf
COPY files/php-fpm.conf /etc/php84/php-fpm.d/baikal.conf
COPY files/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY --from=builder --chown=baikal:nginx /baikal /var/www/baikal

VOLUME /var/www/baikal/config
VOLUME /var/www/baikal/Specific
EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
